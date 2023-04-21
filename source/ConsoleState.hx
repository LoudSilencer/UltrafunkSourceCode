package;

#if desktop
import Discord.DiscordClient;
#end
import editors.ChartingState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.graphics.FlxGraphic;
import flixel.system.debug.interaction.tools.Pointer.GraphicCursorCross;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.addons.ui.FlxUIButton;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import lime.utils.Assets;
import flixel.system.FlxSound;
import haxe.Json;
import haxe.format.JsonParser;
import flixel.tweens.FlxEase;
import openfl.utils.Assets as OpenFlAssets;
import WeekData;
#if MODS_ALLOWED
import sys.FileSystem;
#end

#if !flash 
import flixel.addons.display.FlxRuntimeShader;
import openfl.filters.ShaderFilter;
#end

#if sys
import sys.FileSystem;
import sys.io.File;
#end



using StringTools;

typedef CharacterAssets =
{
	var characterName:String;
	var description:String;
	var songPrerequisite:String;
}


typedef CharactersCompass =
{
	var assets:Array<CharacterAssets>;
}



class ConsoleState extends MusicBeatState
{
	var allowScroll:Bool = true;
	var songVisualShit:Array<Array<Dynamic>> = [];
	var menuHudArray:Array<Dynamic> = [];
	var weeks:Array<WeekData> = [];

	var selector:FlxText;
	private static var curSelected:Int = 0;
	var curWeekSelected:Int = 0;
	var weekMin:Int = 0;
	var curDifficulty:Int = 0;
	private static var lastDifficultyName:String = '';
	public static var loadedOnce:Bool = false;
	var everythingArray:Array<Dynamic> = [];
	var scoreBG:FlxSprite;
	var diffText:FlxText;
	var lerpScore:Int = 0;
	var json:CharactersCompass;
	var lerpRating:Float = 0;
	var intendedScore:Int = 0;
	var intendedRating:Float = 0;
	public var camHUD:FlxCamera;
	public var camGame:FlxCamera;
	var scoreTxt:FlxText;

	private var curPlaying:Bool = false;

	var bg:FlxSprite;
	var intendedColor:Int;
	var colorTween:FlxTween;
	var cameraFollowPointer:FlxSprite;


	var optionShit:Array<String> = [
		'characters',
		'credits'
	];





		#if (!flash && sys)
	public var runtimeShaders:Map<String, Array<String>> = new Map<String, Array<String>>();
	public function createRuntimeShader(name:String):FlxRuntimeShader
	{
		if(!ClientPrefs.shaders) return new FlxRuntimeShader();

		#if (!flash && MODS_ALLOWED && sys)
		if(!runtimeShaders.exists(name) && !initLuaShader(name))
		{
			FlxG.log.warn('Shader $name is missing!');
			return new FlxRuntimeShader();
		}

		var arr:Array<String> = runtimeShaders.get(name);
		return new FlxRuntimeShader(arr[0], arr[1]);
		#else
		FlxG.log.warn("Platform unsupported for Runtime Shaders!");
		return null;
		#end
	}

	public function initLuaShader(name:String, ?glslVersion:Int = 120)
	{
		if(!ClientPrefs.shaders) return false;

		if(runtimeShaders.exists(name))
		{
			FlxG.log.warn('Shader $name was already initialized!');
			return true;
		}

		var foldersToCheck:Array<String> = [Paths.mods('shaders/')];
		if(Paths.currentModDirectory != null && Paths.currentModDirectory.length > 0)
			foldersToCheck.insert(0, Paths.mods(Paths.currentModDirectory + '/shaders/'));

		for(mod in Paths.getGlobalMods())
			foldersToCheck.insert(0, Paths.mods(mod + '/shaders/'));
		
		for (folder in foldersToCheck)
		{
			if(FileSystem.exists(folder))
			{
				var frag:String = folder + name + '.frag';
				var vert:String = folder + name + '.vert';
				var found:Bool = false;
				if(FileSystem.exists(frag))
				{
					frag = File.getContent(frag);
					found = true;
				}
				else frag = null;

				if (FileSystem.exists(vert))
				{
					vert = File.getContent(vert);
					found = true;
				}
				else vert = null;

				if(found)
				{
					runtimeShaders.set(name, [frag, vert]);
					//trace('Found shader $name!');
					return true;
				}
			}
		}
		FlxG.log.warn('Missing shader $name .frag AND .vert files!');
		return false;
	}
	#end





	override function create()
	{
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();
		persistentUpdate = true;
		WeekData.reloadWeekFiles(false);

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Console", null);
		#end

		FlxG.sound.playMusic(Paths.music('takeCare'));
		curSelected = 0;

		FlxG.mouse.visible = true;


		var file:String = Paths.json('console/consoleCharacters');
		var rawJson = Assets.getText(file);
		json = cast Json.parse(rawJson);

		bg = new FlxSprite(-80).loadGraphic(Paths.image('consoleImage'));
		bg.screenCenter();
		add(bg);
		
		weekMin = 0;

		for (i in 0...json.assets.length)
		{
			trace(json.assets[i].characterName);
		}

		weekMin = 0;
		WeekData.setDirectoryFromWeek();

		curSelected = 0;
		intendedColor = bg.color;

		if(lastDifficultyName == '')
		{
			lastDifficultyName = CoolUtil.defaultDifficulty;
		}
		


		var shaderName = "vcr_with_glitch";
        
        initLuaShader(shaderName);
        
        var shader0 = createRuntimeShader(shaderName);

		camHUD = new FlxCamera();
		camGame = new FlxCamera();
		camHUD.bgColor.alpha = 0;
		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camHUD, false);
		FlxG.cameras.setDefaultDrawTarget(camGame, true);



    	camGame.setFilters([new ShaderFilter(shader0)]);
        camHUD.setFilters([new ShaderFilter(shader0)]);


		var square = new FlxSprite(-80).loadGraphic(Paths.image('txtBorder'));
		square.setGraphicSize(Std.int(square.width*2.7));
		square.screenCenter();
		square.y += 150;
		add(square);
		square.alpha = 1;

		scoreTxt = new FlxText(0, 350, FlxG.width, "", 20);
		scoreTxt.setFormat(Paths.font("VCR_OSD_MONO_1.001.ttf"), 25, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		scoreTxt.visible = true;
		scoreTxt.screenCenter();
		scoreTxt.y += 70;
		add(scoreTxt);
		scoreTxt.alpha = 1;

		changeRow();
		changeCollumn(scoreTxt,0);
		weekMin = 0;

		var swag:Alphabet = new Alphabet(1, 0, "swag");

		var textBG:FlxSprite = new FlxSprite(0, FlxG.height - 26).makeGraphic(FlxG.width, 26, 0xFF000000);
		textBG.alpha = 0.6;
		add(textBG);
		
		super.create();
	}

	override function closeSubState() {
		changeRow(0, false);
		persistentUpdate = true;
		super.closeSubState();
	}

	function weekIsLocked(name:String):Bool {
		var leWeek:WeekData = WeekData.weeksLoaded.get(name);
		return (!leWeek.startUnlocked && leWeek.weekBefore.length > 0 && (!StoryMenuState.weekCompleted.exists(leWeek.weekBefore) || !StoryMenuState.weekCompleted.get(leWeek.weekBefore)));
	}



	var instPlaying:Int = -1;
	public static var vocals:FlxSound = null;
	var holdTime:Float = 0;
	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, CoolUtil.boundTo(elapsed * 24, 0, 1)));
		lerpRating = FlxMath.lerp(lerpRating, intendedRating, CoolUtil.boundTo(elapsed * 12, 0, 1));

		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;
		if (Math.abs(lerpRating - intendedRating) <= 0.01)
			lerpRating = intendedRating;

		var ratingSplit:Array<String> = Std.string(Highscore.floorDecimal(lerpRating * 100, 2)).split('.');
		if(ratingSplit.length < 2) { //No decimals, add an empty space
			ratingSplit.push('');
		}
		
		while(ratingSplit[1].length < 2) { //Less than 2 decimals in it, add decimals then
			ratingSplit[1] += '0';
		}


		var upP = controls.UI_UP_P;
		var rightP = controls.UI_RIGHT_P;
		var downP = controls.UI_DOWN_P;
		var leftP = controls.UI_LEFT_P;
		var accepted = controls.ACCEPT;

		var shiftMult:Int = 1;
		if(FlxG.keys.pressed.SHIFT) shiftMult = 3;
		else if (controls.ACCEPT)
		{
			var theName = json.assets[curDifficulty].characterName;
			if (theName == "cancer rodent")
			{
				if (FlxG.save.data.rats == true)
				{
					persistentUpdate = false;
					var songLowercase:String = Paths.formatToSongPath("Rats");
					var poop:String = Highscore.formatSong(songLowercase, 2);
					trace(poop);

					PlayState.SONG = Song.loadFromJson(poop, songLowercase);
					PlayState.isStoryMode = true;
					PlayState.storyDifficulty = 2;
					PlayState.isStoryMode = false;


					var songArray:Array<String> = [];

					LoadingState.loadAndSwitchState(new PlayState());

					FlxG.sound.music.volume = 0;
				}
				else if(FlxG.save.data.points >= 1)
				{
					var randee = FlxG.random.int(0, 200);
					if (randee == 69)
					{
						FlxG.sound.play(Paths.sound('yeah'), 1);
						FlxG.save.data.rats = true;
						changeCollumn(scoreTxt);
					}
					else
					{
						FlxG.sound.play(Paths.sound('no'), 0.7);
						var sngTxt = new FlxText(-300, 500 - 320, FlxG.width, "Uh, something went wrong. Try again?", 20);
						sngTxt.setFormat(Paths.font("VCR_OSD_MONO_1.001.ttf"), 80, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.RED);
						sngTxt.visible = true;
						sngTxt.screenCenter();
						add(sngTxt);

						FlxTween.tween(sngTxt, {alpha: 1}, 1, {ease: FlxEase.quartInOut,
							onComplete: function(twn:FlxTween) {
								remove(sngTxt);
							}});
					}
				}
				else
				{
					FlxG.sound.play(Paths.sound('no'), 0.7);
					var sngTxt = new FlxText(-300, 500 - 320, FlxG.width, "You need at least " + "1" +  " P to play!", 20);
					sngTxt.setFormat(Paths.font("VCR_OSD_MONO_1.001.ttf"), 80, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.RED);
					sngTxt.visible = true;
					sngTxt.screenCenter();
					add(sngTxt);

					FlxTween.tween(sngTxt, {alpha: 1}, 1, {ease: FlxEase.quartInOut,
						onComplete: function(twn:FlxTween) {
							remove(sngTxt);
						}});
				}
			}
			else if (theName == "gabriel")
			{
				if(FlxG.save.data.gabriel == true)
				{
					persistentUpdate = false;
					var songLowercase:String = Paths.formatToSongPath("Judgement");
					var poop:String = Highscore.formatSong(songLowercase, 2);
					trace(poop);

					PlayState.SONG = Song.loadFromJson(poop, songLowercase);
					PlayState.isStoryMode = true;
					PlayState.storyDifficulty = 2;
					PlayState.isStoryMode = false;


					var songArray:Array<String> = [];

					LoadingState.loadAndSwitchState(new PlayState());

					FlxG.sound.music.volume = 0;
				}
				else if(FlxG.save.data.points >= 7500)
				{
					FlxG.sound.play(Paths.sound('yeah'), 1);
					FlxG.save.data.gabriel = true;
					changeCollumn(scoreTxt);
				}
				else
				{
					FlxG.sound.play(Paths.sound('no'), 0.7);
					var sngTxt = new FlxText(-300, 500 - 320, FlxG.width, "You need at least " + "7500" +  " P to play!", 20);
					sngTxt.setFormat(Paths.font("VCR_OSD_MONO_1.001.ttf"), 80, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.RED);
					sngTxt.visible = true;
					sngTxt.screenCenter();
					add(sngTxt);

					FlxTween.tween(sngTxt, {alpha: 1}, 1, {ease: FlxEase.quartInOut,
						onComplete: function(twn:FlxTween) {
							remove(sngTxt);
						}});
				}
			}
			else if (theName == "v1")
			{
				if(FlxG.save.data.v1 == true)
				{
					persistentUpdate = false;
					var songLowercase:String = Paths.formatToSongPath("Sub Five");
					var poop:String = Highscore.formatSong(songLowercase, 2);
					trace(poop);

					PlayState.SONG = Song.loadFromJson(poop, songLowercase);
					PlayState.isStoryMode = true;
					PlayState.storyDifficulty = 2;
					PlayState.isStoryMode = false;


					var songArray:Array<String> = [];

					LoadingState.loadAndSwitchState(new PlayState());

					FlxG.sound.music.volume = 0;
				}
				else if(FlxG.save.data.points >= 7500)
				{
					FlxG.sound.play(Paths.sound('yeah'), 1);
					FlxG.save.data.v1 = true;
					changeCollumn(scoreTxt);
				}
				else
				{
					FlxG.sound.play(Paths.sound('no'), 0.7);
					var sngTxt = new FlxText(-300, 500 - 320, FlxG.width, "You need at least " + "7500" +  " P to play!", 20);
					sngTxt.setFormat(Paths.font("VCR_OSD_MONO_1.001.ttf"), 80, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.RED);
					sngTxt.visible = true;
					sngTxt.screenCenter();
					add(sngTxt);

					FlxTween.tween(sngTxt, {alpha: 1}, 1, {ease: FlxEase.quartInOut,
						onComplete: function(twn:FlxTween) {
							remove(sngTxt);
						}});
				}
			}
				
		}
		if(json.assets.length > 1)
		{
			if (upP)
			{
				changeRow(-shiftMult);
				holdTime = 0;
			}
			if (downP)
			{
				changeRow(shiftMult);
				holdTime = 0;
			}

		}

		if (controls.UI_LEFT_P)
			changeCollumn(scoreTxt,-1);
		else if (controls.UI_RIGHT_P)
			changeCollumn(scoreTxt,1);

		if (controls.BACK)
		{
			persistentUpdate = false;
			if(colorTween != null) {
				colorTween.cancel();
			}
			FlxG.sound.play(Paths.sound('cancelMenu'));
			
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}
		super.update(elapsed);
	}

	function changeCollumn(scoreTxt:FlxText,change:Int = 0)
	{

		if (json.assets[curDifficulty].characterName == "cancer rodent")
		{
			FlxG.sound.playMusic(Paths.music('takeCare'));
		}
		if (json.assets[curDifficulty].characterName == "something wicked")
		{
			FlxG.sound.playMusic(Paths.music('takeCare'));
		}
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		curDifficulty += change;
		if (curDifficulty < 0)
			curDifficulty = 0;
		else if (curDifficulty >= json.assets.length -1)
		{
			curDifficulty = json.assets.length -1;
		}
		for (i in everythingArray)
		{
			remove(i);
		}
		
		scoreTxt.text = json.assets[curDifficulty].description;



		if (json.assets[curDifficulty].characterName == "something wicked")
		{
			FlxG.sound.playMusic(Paths.sound('SomethingEvil'));
			var scoreTxt = new FlxText(0, 350, FlxG.width, json.assets[curDifficulty].characterName.toUpperCase(), 20);
			scoreTxt.setFormat(Paths.font("VCR_OSD_MONO_1.001.ttf"), 60, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			scoreTxt.visible = true;
			scoreTxt.screenCenter();
			scoreTxt.y -= 90;
			everythingArray.push(scoreTxt);
			add(scoreTxt);
		}
		else
		{

		if (json.assets[curDifficulty].characterName == "cancer rodent")
		{
			FlxG.sound.playMusic(Paths.music('rats'));
		}
		var scoreTxt = new FlxText(0, 350, FlxG.width, json.assets[curDifficulty].characterName.toUpperCase(), 20);
		scoreTxt.setFormat(Paths.font("VCR_OSD_MONO_1.001.ttf"), 60, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		scoreTxt.visible = true;
		scoreTxt.screenCenter();
		scoreTxt.y -= 90;
		everythingArray.push(scoreTxt);
		add(scoreTxt);


		var icon = new FlxSprite(-80).loadGraphic(Paths.image('console/' + json.assets[curDifficulty].characterName));
		icon.screenCenter();
		icon.y -= 200;
		add(icon);
		icon.alpha = 1;
		everythingArray.push(icon);
		icon.alpha = 1;

		var theName = json.assets[curDifficulty].characterName;


		if (theName == "v1")
		{
			if (FlxG.save.data.v1 == true)
			{
				var scoreTxt = new FlxText(0, 350, FlxG.width, "--PLAY SONG: PRESS ENTER--", 20);
				scoreTxt.setFormat(Paths.font("VCR_OSD_MONO_1.001.ttf"), 30, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
				scoreTxt.visible = true;
				scoreTxt.screenCenter();
				scoreTxt.y += 300;
				everythingArray.push(scoreTxt);
				add(scoreTxt);

				var songRating = Highscore.getRating("sub-five", 2);
				var graphicRating = "NOSCORE";
				if (songRating < .5)
					graphicRating = "NOSCORE";
				else if (songRating <= .65)
					graphicRating = "D";
				else if (songRating <= .75)
					graphicRating = "C";
				else if (songRating <= .85)
					graphicRating = "B";
				else if (songRating <= .92)
					graphicRating = "A";
				else if (songRating <= .985)
					graphicRating = "S";
				else if (songRating <= 1)
					graphicRating = "P";
				
				var ratingS = new FlxSprite(-80).loadGraphic(Paths.image(graphicRating));
				ratingS.setGraphicSize(Std.int(ratingS.width * .6));
				ratingS.x = 150;
				ratingS.y = 100;
				add(ratingS);
				ratingS.alpha = 1;
				everythingArray.push(ratingS);

			}
			else
			{
				var scoreTxt = new FlxText(0, 350, FlxG.width, "--PURCHASE SONG: 7500 P--", 20);
				scoreTxt.setFormat(Paths.font("VCR_OSD_MONO_1.001.ttf"), 30, FlxColor.YELLOW, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
				scoreTxt.visible = true;
				scoreTxt.screenCenter();
				scoreTxt.y += 300;
				everythingArray.push(scoreTxt);
				add(scoreTxt);
			}
		}
		else if (theName == "gabriel")
		{
			if (FlxG.save.data.gabriel == true)
			{
				var scoreTxt = new FlxText(0, 350, FlxG.width, "--PLAY SONG: PRESS ENTER--", 20);
				scoreTxt.setFormat(Paths.font("VCR_OSD_MONO_1.001.ttf"), 30, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
				scoreTxt.visible = true;
				scoreTxt.screenCenter();
				scoreTxt.y += 300;
				everythingArray.push(scoreTxt);
				add(scoreTxt);

				var songRating = Highscore.getRating("judgement", 2);
				var graphicRating = "NOSCORE";
				if (songRating < .5)
					graphicRating = "NOSCORE";
				else if (songRating <= .65)
					graphicRating = "D";
				else if (songRating <= .75)
					graphicRating = "C";
				else if (songRating <= .85)
					graphicRating = "B";
				else if (songRating <= .92)
					graphicRating = "A";
				else if (songRating <= .985)
					graphicRating = "S";
				else if (songRating <= 1)
					graphicRating = "P";
				
				var ratingS = new FlxSprite(-80).loadGraphic(Paths.image(graphicRating));
				ratingS.setGraphicSize(Std.int(ratingS.width * .6));
				ratingS.x = 150;
				ratingS.y = 100;
				add(ratingS);
				ratingS.alpha = 1;
				everythingArray.push(ratingS);
			}
			else
			{
				var scoreTxt = new FlxText(0, 350, FlxG.width, "--PURCHASE SONG: 7500 P--", 20);
				scoreTxt.setFormat(Paths.font("VCR_OSD_MONO_1.001.ttf"), 30, FlxColor.YELLOW, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
				scoreTxt.visible = true;
				scoreTxt.screenCenter();
				scoreTxt.y += 300;
				everythingArray.push(scoreTxt);
				add(scoreTxt);
			}
		}
		if (theName == "cancer rodent")
		{
			if (FlxG.save.data.rats == true)
			{
				var scoreTxt = new FlxText(0, 350, FlxG.width, "--PLAY SONG: PRESS ENTER--", 20);
				scoreTxt.setFormat(Paths.font("VCR_OSD_MONO_1.001.ttf"), 30, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
				scoreTxt.visible = true;
				scoreTxt.screenCenter();
				scoreTxt.y += 300;
				everythingArray.push(scoreTxt);
				add(scoreTxt);

				var songRating = Highscore.getRating("rats", 2);
				var graphicRating = "NOSCORE";
				if (songRating < .5)
					graphicRating = "NOSCORE";
				else if (songRating <= .65)
					graphicRating = "D";
				else if (songRating <= .75)
					graphicRating = "C";
				else if (songRating <= .85)
					graphicRating = "B";
				else if (songRating <= .92)
					graphicRating = "A";
				else if (songRating <= .985)
					graphicRating = "S";
				else if (songRating <= 1)
					graphicRating = "P";
				
				var ratingS = new FlxSprite(-80).loadGraphic(Paths.image(graphicRating));
				ratingS.setGraphicSize(Std.int(ratingS.width * .6));
				ratingS.x = 150;
				ratingS.y = 100;
				add(ratingS);
				ratingS.alpha = 1;
				everythingArray.push(ratingS);
			}
			else
			{
				var scoreTxt = new FlxText(0, 350, FlxG.width, "--PURCHASE SONG: 1 P--", 20);
				scoreTxt.setFormat(Paths.font("VCR_OSD_MONO_1.001.ttf"), 30, FlxColor.YELLOW, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
				scoreTxt.visible = true;
				scoreTxt.screenCenter();
				scoreTxt.y += 300;
				everythingArray.push(scoreTxt);
				add(scoreTxt);
			}
		}


		}
		
	}

	function changeRow(change:Int = 0, playSound:Bool = true)
	{
		if (allowScroll)
		{
			curSelected += change;
		}
	}

}
