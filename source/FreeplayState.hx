package;

#if desktop
import Discord.DiscordClient;
#end
import editors.ChartingState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import lime.utils.Assets;
import flixel.system.FlxSound;
import flixel.tweens.FlxEase;
import openfl.utils.Assets as OpenFlAssets;
import WeekData;
#if MODS_ALLOWED
import sys.FileSystem;
#end

using StringTools;

class FreeplayState extends MusicBeatState
{
	var songs:Array<SongMetadata> = [];
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
	public static var loadConsole:Bool = false;

	var scoreBG:FlxSprite;
	var scoreText:FlxText;
	var diffText:FlxText;
	var lerpScore:Int = 0;
	var lerpRating:Float = 0;
	var intendedScore:Int = 0;
	var intendedRating:Float = 0;

	private var speedLines:FlxTypedGroup<FlxSprite>;
	private var grpSongs:FlxTypedGroup<Alphabet>;
	private var curPlaying:Bool = false;

	private var iconArray:Array<HealthIcon> = [];

	var bg:FlxSprite;
	var bg2:FlxSprite;
	var intendedColor:Int;
	var colorTween:FlxTween;
	var colorTween2:FlxTween;
	override function create()
	{
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();
		if (!loadedOnce)
		{
			loadedOnce = true;
			MusicBeatState.switchState(new FreeplayState(),true);
		}
		persistentUpdate = true;
		PlayState.isStoryMode = true;
		WeekData.reloadWeekFiles(false);

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		curSelected = 0;
		FlxG.mouse.visible = false;
		for (i in 0...WeekData.weeksList.length) {
			if(weekIsLocked(WeekData.weeksList[i])) continue;

			var leWeek:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[i]);
			var leSongs:Array<String> = [];
			var leChars:Array<String> = [];

			for (j in 0...leWeek.songs.length)
			{
				leSongs.push(leWeek.songs[j][0]);
				leChars.push(leWeek.songs[j][1]);
			}
			weeks.push(leWeek);
			WeekData.setDirectoryFromWeek(leWeek);
			for (song in leWeek.songs)
			{
				var colors:Array<Int> = song[2];
				if(colors == null || colors.length < 3)
				{
					colors = [146, 113, 253];
				}
				addSong(song[0], i, song[1], FlxColor.fromRGB(colors[0], colors[1], colors[2]),leWeek.requiredPoints);
			}
		}
		WeekData.loadTheFirstEnabledMod();

		/*		//KIND OF BROKEN NOW AND ALSO PRETTY USELESS//

		var initSonglist = CoolUtil.coolTextFile(Paths.txt('freeplaySonglist'));
		for (i in 0...initSonglist.length)
		{
			if(initSonglist[i] != null && initSonglist[i].length > 0) {
				var songArray:Array<String> = initSonglist[i].split(":");
				//addSong(songArray[0], 0, songArray[1], Std.parseInt(songArray[2]));
			}
		}*/

		bg = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
			bg.setGraphicSize(Std.int(bg.width * 1.08));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);
		bg.alpha = .7;
		bg.y = bg.height;
		FlxTween.tween(bg,{y:0-bg.height},.7,{type: FlxTweenType.LOOPING});

		bg2 = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		bg2.screenCenter();
		bg2.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg2);
		bg2.alpha = 1;
		bg2.y = bg2.height;
		FlxTween.tween(bg2, {alpha: 1}, .35, {ease: FlxEase.quartInOut,
							onComplete: function(twn:FlxTween) {
								FlxTween.tween(bg2,{y:0-bg2.height},.7,{type: FlxTweenType.LOOPING});
							}});

		grpSongs = new FlxTypedGroup<Alphabet>();
		add(grpSongs);
		weekMin = 0;
		speedLines = new FlxTypedGroup<FlxSprite>();
		add(speedLines);


		FlxTween.tween(bg2, {alpha: 1}, .05, {type: FlxTweenType.LOOPING,
			onComplete: function(twn:FlxTween) {
				var speedLine = new FlxSprite(-80).loadGraphic(Paths.image("speedlines"));
				speedLine.y = 1500;
				speedLine.alpha = .12;
				speedLine.x = FlxG.random.int(0, 2000);
				speedLines.add(speedLine);
				FlxTween.tween(speedLine,{y:-100},.5,{
				onComplete: function(twn:FlxTween) {
					speedLines.remove(speedLine);
				}
				});
			}});
		

		if (loadConsole)
		{
			loadConsole = false;
			MusicBeatState.switchState(new ConsoleState());
		}

		for (j in 0...weeks.length)
		{


				var header = new FlxSprite(-80).loadGraphic(Paths.image("menuLine"));
				header.x = 540 - (300/2) - 270;
				header.y = (j * 650) + 500 - 420;
				add(header);
				header.alpha = 1;
				menuHudArray.push(header);

				var titleTxt = new FlxText(640 - (300/2) - 820, (j * 650) + 270 - 900 + 650, FlxG.width, weeks[j].weekName.toUpperCase(), 20);
				titleTxt.setFormat(Paths.font("VCR_OSD_MONO_1.001.ttf"), 50, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
				titleTxt.visible = true;
				add(titleTxt);
				titleTxt.alpha = 1;
				menuHudArray.push(titleTxt);


			for (i in 0...weeks[j].songs.length)
			{
				var songText:Alphabet = new Alphabet(90, 320, songs[i+weekMin].songName, true);
				songText.isMenuItem = false;
				songText.targetY = j - curSelected;
				grpSongs.add(songText);

				var maxWidth = 200;
				if (songText.width > maxWidth)
				{
					songText.scaleX = maxWidth / songText.width;
				}
				songText.snapToPosition();
				songText.visible = false;

				var everythingArray:Array<Dynamic> = [];
				
				var square:FlxSprite;
				if (Highscore.getRating(songs[i+weekMin].songName, 2) < .3)
				{
					square = new FlxSprite(-80).loadGraphic(Paths.image('squareBorder'));
					square.x = (i * 320) + 400 - (square.width/2) - 70;
					square.y = (j * 650) + 800 - (square.height/2) - 275 - 150;
					add(square);
					square.alpha = .4;
					square.antialiasing = true;
					everythingArray.push(square);
				}
				else
				{
					square = new FlxSprite(-80).loadGraphic(Paths.image('freeplay/' + Paths.formatToSongPath(songs[i+weekMin].songName)));
					square.x = (i * 320) + 400 - (square.width/2) - 70;
					square.y = (j * 650) + 800 - (square.height/2) - 275 - 150;
					square.antialiasing = true;
					add(square);
					
					square.alpha = .4;
					everythingArray.push(square);
				}


				var theName = songs[i+weekMin].songName.toUpperCase();
				if (songs[i+weekMin].points > FlxG.save.data.points)
				{
					theName = "???????";
				}
				var sngTxt = new FlxText((i * 320) - 300, (j * 650) + 500 - 320, FlxG.width, theName, 20);
				sngTxt.setFormat(Paths.font("VCR_OSD_MONO_1.001.ttf"), 30, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
				sngTxt.visible = true;
				add(sngTxt);
				sngTxt.alpha = .4;
				everythingArray.push(sngTxt);



				songVisualShit.push(everythingArray);

				var sngScore = new FlxText((i * 320) - 430, (j * 650) + 500 + 50, FlxG.width,  Std.string(Highscore.getScore(songs[i+weekMin].songName, 2))  , 20);
				sngScore.setFormat(Paths.font("VCR_OSD_MONO_1.001.ttf"), 22, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
				sngScore.visible = true;
				sngScore.alpha = 1;
				add(sngScore);
				menuHudArray.push(sngScore);


				var songRating = Highscore.getRating(songs[i+weekMin].songName, 2);
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
				ratingS.x = (i * 320) + 590 - (square.width/2) - 60;
				ratingS.y = (j * 650) + 1080 - (square.height/2) - 275 - 150;
				add(ratingS);
				ratingS.alpha = 1;
				menuHudArray.push(ratingS);



				Paths.currentModDirectory = songs[i+weekMin].folder;
				var icon:HealthIcon = new HealthIcon(songs[i+weekMin].songCharacter);
				icon.sprTracker = songText;

				// using a FlxGroup is too much fuss!
				iconArray.push(icon);
				//add(icon);

				// songText.x += 40;
				// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
				// songText.screenCenter(X);
			}
			weekMin += weeks[j].songs.length;
		}
		weekMin = 0;
		WeekData.setDirectoryFromWeek();

		scoreText = new FlxText(FlxG.width * 0.7, 5, 0, "P: " + FlxG.save.data.points, 32);
		scoreText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.YELLOW, RIGHT);

		scoreBG = new FlxSprite(scoreText.x - 6, 0).makeGraphic(1, 66, 0xFF000000);
		scoreBG.alpha = 0.6;
		//add(scoreBG);

		diffText = new FlxText(scoreText.x, scoreText.y + 36, 0, "", 24);
		diffText.font = scoreText.font;
		//add(diffText);

		add(scoreText);

		if(curSelected >= songs.length) curSelected = 0;
		

		if(lastDifficultyName == '')
		{
			lastDifficultyName = CoolUtil.defaultDifficulty;
		}
		
		changeRow();
		weekMin = 0;

		var swag:Alphabet = new Alphabet(1, 0, "swag");

		// JUST DOIN THIS SHIT FOR TESTING!!!
		/* 
			var md:String = Markdown.markdownToHtml(Assets.getText('CHANGELOG.md'));

			var texFel:TextField = new TextField();
			texFel.width = FlxG.width;
			texFel.height = FlxG.height;
			// texFel.
			texFel.htmlText = md;

			FlxG.stage.addChild(texFel);

			// scoreText.textField.htmlText = md;

			trace(md);
		 */

		var textBG:FlxSprite = new FlxSprite(0, FlxG.height - 26).makeGraphic(FlxG.width, 26, 0xFF000000);
		textBG.alpha = 0.6;
		add(textBG);

		#if PRELOAD_ALL
		var leText:String = "Press SPACE to listen to the Song / Press CTRL to open the Gameplay Changers Menu / Press RESET to Reset your Score and Accuracy.";
		var size:Int = 16;
		#else
		var leText:String = "Press CTRL to open the Gameplay Changers Menu / Press RESET to Reset your Score and Accuracy.";
		var size:Int = 18;
		#end
		var text:FlxText = new FlxText(textBG.x, textBG.y + 4, FlxG.width, leText, size);
		text.setFormat(Paths.font("vcr.ttf"), size, FlxColor.WHITE, RIGHT);
		text.scrollFactor.set();
		//add(text);
		super.create();
	}

	override function closeSubState() {
		changeRow(0, false);
		persistentUpdate = true;
		super.closeSubState();
	}

	public function addSong(songName:String, weekNum:Int, songCharacter:String, color:Int, points:Int)
	{
		songs.push(new SongMetadata(songName, weekNum, songCharacter, color, points));
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

		//scoreText.text = 'PERSONAL BEST: ' + lerpScore + ' (' + ratingSplit.join('.') + '%)';
		positionHighscore();

		var upP = controls.UI_UP_P;
		var rightP = controls.UI_RIGHT_P;
		var downP = controls.UI_DOWN_P;
		var leftP = controls.UI_LEFT_P;
		var accepted = controls.ACCEPT;
		var space = FlxG.keys.justPressed.SPACE;
		var ctrl = FlxG.keys.justPressed.CONTROL;

		var shiftMult:Int = 1;
		if(FlxG.keys.pressed.SHIFT) shiftMult = 3;

		if(songs.length > 1)
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
			changeCollumn(-1);
		else if (controls.UI_RIGHT_P)
			changeCollumn(1);

		if (controls.BACK)
		{
			persistentUpdate = false;
			if(colorTween != null) {
				colorTween.cancel();
				colorTween2.cancel();
			}
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}


		else if (accepted)
		{
			if (songs[curDifficulty].points > FlxG.save.data.points)
			{
				FlxG.sound.play(Paths.sound('no'), 0.7);
				var sngTxt = new FlxText(-300, 500 - 320, FlxG.width, "You need at least " + songs[curDifficulty].points +  " P to play!", 20);
				sngTxt.setFormat(Paths.font("VCR_OSD_MONO_1.001.ttf"), 80, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.RED);
				sngTxt.visible = true;
				sngTxt.screenCenter();
				add(sngTxt);

				FlxTween.tween(sngTxt, {alpha: 1}, 1, {ease: FlxEase.quartInOut,
					onComplete: function(twn:FlxTween) {
						remove(sngTxt);
					}});
			}
			else
			{
			FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
			persistentUpdate = false;
			var songLowercase:String = Paths.formatToSongPath(songs[curDifficulty].songName);
			var poop:String = Highscore.formatSong(songLowercase, 2);
			/*#if MODS_ALLOWED
			if(!sys.FileSystem.exists(Paths.modsJson(songLowercase + '/' + poop)) && !sys.FileSystem.exists(Paths.json(songLowercase + '/' + poop))) {
			#else
			if(!OpenFlAssets.exists(Paths.json(songLowercase + '/' + poop))) {
			#end
				poop = songLowercase;
				trace('Couldnt find file');
			}*/
			trace(poop);

			PlayState.SONG = Song.loadFromJson(poop, songLowercase);
			PlayState.isStoryMode = true;
			PlayState.storyDifficulty = 2;

			var songArray:Array<String> = [];
			var leWeek:Array<Dynamic> = weeks[curSelected].songs;
			var foundSong = false;
			for (i in 0...leWeek.length) {
				if (foundSong)
					songArray.push(leWeek[i][0]);
				else if (leWeek[i][0] == songs[curDifficulty].songName)
				{
					songArray.push(leWeek[i][0]);
					foundSong = true;
				}
			}

			trace(songArray);
			// Nevermind that's stupid lmao
			PlayState.storyPlaylist = songArray;



			trace('CURRENT WEEK: ' + WeekData.getWeekFileName());
			if(colorTween != null) {
				colorTween.cancel();
				colorTween2.cancel();
			}
			
			if (FlxG.keys.pressed.SHIFT){
				LoadingState.loadAndSwitchState(new ChartingState());
			}else{
				LoadingState.loadAndSwitchState(new PlayState());
			}

			FlxG.sound.music.volume = 0;
					
			destroyFreeplayVocals();
			}
		}
		else if(controls.RESET)
		{
			persistentUpdate = false;
			openSubState(new ResetScoreSubState(songs[curDifficulty].songName, 2, songs[curDifficulty].songCharacter));
			FlxG.sound.play(Paths.sound('scrollMenu'));
		}
		super.update(elapsed);
	}

	public static function destroyFreeplayVocals() {
		if(vocals != null) {
			vocals.stop();
			vocals.destroy();
		}
		vocals = null;
	}

	function changeCollumn(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		curDifficulty += change;
		if (change == 0)
		{
			curDifficulty = weekMin;
		}
		if (curDifficulty < weekMin)
			curDifficulty = weekMin;
		else if (curDifficulty >= weekMin + weeks[curSelected].songs.length)
		{
			curDifficulty = weekMin + weeks[curSelected].songs.length -1;
		}

		lastDifficultyName = CoolUtil.difficulties[2];

		var counter = 0;
		for (i in songVisualShit)
		{
			if (counter == curDifficulty)
			{
				FlxTween.tween(i[0],{alpha:1}, 0.1, {ease: FlxEase.quartInOut});
				FlxTween.tween(i[1],{alpha:1}, 0.1, {ease: FlxEase.quartInOut});
			}
			else if (counter > weekMin && counter <= weekMin + weeks[curSelected].songs.length)
			{
				FlxTween.tween(i[0],{alpha:0.6}, 0.1, {ease: FlxEase.quartInOut});
				FlxTween.tween(i[1],{alpha:0.6}, 0.1, {ease: FlxEase.quartInOut});
			}
			else
			{
				FlxTween.tween(i[0],{alpha:0.3}, 0.1, {ease: FlxEase.quartInOut});
				FlxTween.tween(i[1],{alpha:0.3}, 0.1, {ease: FlxEase.quartInOut});
			}
			counter++;
		}
		trace(curDifficulty);

		bg.color = songs[curDifficulty].color;
		bg2.color = songs[curDifficulty].color;
		intendedColor = bg.color;
		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected].songName, 2);
		intendedRating = Highscore.getRating(songs[curSelected].songName, 2);
		#end

		PlayState.storyDifficulty = 2;
		diffText.text = '< ' + CoolUtil.difficultyString() + ' >';
		positionHighscore();

		Paths.currentModDirectory = songs[curDifficulty].folder;
		PlayState.storyWeek = songs[curDifficulty].week;
		trace(songs[curDifficulty].songName);
	}

	function changeRow(change:Int = 0, playSound:Bool = true)
	{
		if (allowScroll)
		{
		curSelected += change;

		if (curSelected < 0)
			curSelected = 0;
		else if (curSelected >= weeks.length)
			curSelected = weeks.length - 1;
		else
		{
			if (change == 1)
			{
				allowScroll = false;
				weekMin += weeks[curSelected-1].songs.length;
				for (i in songVisualShit)
				{
					FlxTween.tween(i[0], {y: i[0].y - 650}, 0.3, {ease: FlxEase.quartInOut,
					onComplete: function(twn:FlxTween) {
						allowScroll = true;
					}});
					FlxTween.tween(i[1], {y: i[1].y - 650}, 0.3, {ease: FlxEase.quartInOut});
				}
				for (i in menuHudArray)
				{
					FlxTween.tween(i, {y: i.y - 650}, 0.3, {ease: FlxEase.quartInOut});
				}
			}
			if (change == -1)
			{
				allowScroll = false;
				weekMin -= weeks[curSelected].songs.length;
				for (i in songVisualShit)
				{
					FlxTween.tween(i[0], {y: i[0].y + 650}, 0.3, {ease: FlxEase.quartInOut,
					onComplete: function(twn:FlxTween) {
						allowScroll = true;
					}});
					FlxTween.tween(i[1], {y: i[1].y + 650}, 0.3, {ease: FlxEase.quartInOut});
				}
				for ( i in menuHudArray)
				{
					FlxTween.tween(i, {y: i.y + 650}, 0.3, {ease: FlxEase.quartInOut});
				}
			}	
		}
		trace(curSelected);

		var newColor:Int = songs[curSelected].color;
		
		if(newColor != intendedColor) {
			if(colorTween != null) {
				colorTween.cancel();
				colorTween2.cancel();
			}
			intendedColor = newColor;
			colorTween = FlxTween.color(bg, .2, bg.color, intendedColor, {
				onComplete: function(twn:FlxTween) {
					colorTween = null;
				}
			});
			colorTween2 = FlxTween.color(bg, .2, bg2.color, intendedColor, {
				onComplete: function(twn:FlxTween) {
					colorTween2 = null;
				}
			});
		}

		// selector.y = (70 * curSelected) + 30;

		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected].songName, 2);
		intendedRating = Highscore.getRating(songs[curSelected].songName, 2);
		#end

		var bullShit:Int = 0;

		for (i in 0...iconArray.length)
		{
			iconArray[i].alpha = 0.6;
		}

		iconArray[curSelected].alpha = 1;

		for (item in grpSongs.members)
		{
			item.targetY += change;
			bullShit++;

			item.alpha = 0.5;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = .8;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
		

		CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();
		var diffStr:String = WeekData.getCurrentWeek().difficulties;
		if(diffStr != null) diffStr = diffStr.trim(); //Fuck you HTML5

		if(diffStr != null && diffStr.length > 0)
		{
			var diffs:Array<String> = diffStr.split(',');
			var i:Int = diffs.length - 1;
			while (i > 0)
			{
				if(diffs[i] != null)
				{
					diffs[i] = diffs[i].trim();
					if(diffs[i].length < 1) diffs.remove(diffs[i]);
				}
				--i;
			}

			if(diffs.length > 0 && diffs[0].length > 0)
			{
				CoolUtil.difficulties = diffs;
			}
		}
		changeCollumn();
		}
	}

	private function positionHighscore() {
		scoreText.x = FlxG.width - scoreText.width - 6;

		scoreBG.scale.x = FlxG.width - scoreText.x + 6;
		scoreBG.x = FlxG.width - (scoreBG.scale.x / 2);
		diffText.x = Std.int(scoreBG.x + (scoreBG.width / 2));
		diffText.x -= diffText.width / 2;
	}
}

class SongMetadata
{
	public var songName:String = "";
	public var week:Int = 0;
	public var songCharacter:String = "";
	public var color:Int = -7179779;
	public var folder:String = "";
	public var points:Int = 0;

	public function new(song:String, week:Int, songCharacter:String, color:Int, points:Int)
	{
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
		this.color = color;
		this.points = points;
		this.folder = Paths.currentModDirectory;
		if(this.folder == null) this.folder = '';
	}
}