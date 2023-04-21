local shaderName = "bloom"
local shaderName2 = "pixelate"
local shaderName3 = "radchr"
local shaderNameBinary = "binary"
function onCreate()
    shaderCoordFix() -- initialize a fix for textureCoord when resizing game window

if not lowQuality then
    makeLuaSprite("tempShader0")
    makeLuaSprite("tempShader1")
    makeLuaSprite("tempShader2")
    makeLuaSprite("tempShaderBinary")


    runHaxeCode([[
        var shaderName = "]] .. shaderName .. [[";
        var shaderName2 = "]] .. shaderName2 .. [[";
        var shaderName3 = "]] .. shaderName3 .. [[";
        var shaderNameBinary = "]] .. shaderNameBinary .. [[";

        
        game.initLuaShader(shaderName);
        game.initLuaShader(shaderName2);
        game.initLuaShader(shaderName3);
        game.initLuaShader(shaderNameBinary);
        
        var shader0 = game.createRuntimeShader(shaderName);
        var shader2 = game.createRuntimeShader(shaderName2);
        var shader3 = game.createRuntimeShader(shaderName3);;
        var shaderBinary = game.createRuntimeShader(shaderNameBinary);;

        game.camGame.setFilters([new ShaderFilter(shader0)]);
        game.camHUD.setFilters([new ShaderFilter(shader0)]);


        game.getLuaObject("tempShader0").shader = shader0;
        game.getLuaObject("tempShader1").shader = shader2;
        game.getLuaObject("tempShader2").shader = shader3;
        game.getLuaObject("tempShaderBinary").shader = shaderBinary;

        return;

    ]])

    initLuaShader("gaussian")
    setSpriteShader("heresy", "gaussian")
    setSpriteShader("heresyRed", "gaussian")


    
end
end

function onSongStart()
    triggerEvent('Add Camera Zoom')
end


function onUpdate(elapsed)
    setShaderFloat("tempShaderBinary", "iTime" , os.clock())
end

binaryOn = false
function onEvent(n)
if not lowQuality then
    if n == 'addBinary' then
    runHaxeCode([[
        var shaderNameBinary = "]] .. shaderNameBinary .. [[";
        game.initLuaShader(shaderNameBinary);
        var shaderBinary = game.createRuntimeShader(shaderNameBinary);
        
        trace("HI!");
        
        game.camGame.setFilters([new ShaderFilter(shaderBinary)]);
        game.getLuaObject("tempShaderBinary").shader = shaderBinary;
        
        return;
    ]])
        setProperty('camGame.alpha', 0)
        doTweenAlpha('hudIn', 'camGame', 1, 0.3, 'linear')
        binaryOn = true
    end 

    if n == 'removeBinary' then
    runHaxeCode([[
        var shaderName = "]] .. shaderName .. [[";
        
        game.initLuaShader(shaderName);
        
        var shader0 = game.createRuntimeShader(shaderName);

        game.camGame.setFilters([new ShaderFilter(shader0)]);
        game.camHUD.setFilters([new ShaderFilter(shader0)]);
        

        trace("HI!");
        game.getLuaObject("tempShader0").shader = shader0;

        return;
        
    ]])
        setProperty('camGame.alpha', 0)
        doTweenAlpha('hudIn', 'camGame', 1, 0.3, 'linear')
        binaryOn = false
    end 
    if n == 'Add Camera Zoom' and binaryOn == true then
        runHaxeCode([[
            var shaderName = "]] .. shaderName .. [[";
            var shaderName2 = "]] .. shaderName2 .. [[";
            var shaderName3 = "]] .. shaderName3 .. [[";
            
            game.initLuaShader(shaderName);
            game.initLuaShader(shaderName2);
            game.initLuaShader(shaderName3);
            
            var shader0 = game.createRuntimeShader(shaderName);
            var shader2 = game.createRuntimeShader(shaderName2);
            var shader3 = game.createRuntimeShader(shaderName3);


            var shaderNameBinary = "]] .. shaderNameBinary .. [[";
            game.initLuaShader(shaderNameBinary);
            var shaderBinary = game.createRuntimeShader(shaderNameBinary);

            trace("HI!");

            game.getLuaObject("tempShaderBinary").shader = shaderBinary;

        game.camGame.setFilters([new ShaderFilter(shader0), new ShaderFilter(shader2), new ShaderFilter(shader3), new ShaderFilter(shaderBinary)]);
        game.camHUD.setFilters([new ShaderFilter(shader0), new ShaderFilter(shader3)]);


        game.getLuaObject("tempShader0").shader = shader0;
        game.getLuaObject("tempShader1").shader = shader2;
        game.getLuaObject("tempShader2").shader = shader3; // setting it into temporary sprite so luas can set its shader uniforms/properties
        return;
    ]])
        runTimer('shaderFade', 0.1)

        elseif n == 'Add Camera Zoom' and binaryOn == false then
            runHaxeCode([[
                var shaderName = "]] .. shaderName .. [[";
                var shaderName2 = "]] .. shaderName2 .. [[";
                var shaderName3 = "]] .. shaderName3 .. [[";
                
                game.initLuaShader(shaderName);
                game.initLuaShader(shaderName2);
                game.initLuaShader(shaderName3);
                
                var shader0 = game.createRuntimeShader(shaderName);
                var shader2 = game.createRuntimeShader(shaderName2);
                var shader3 = game.createRuntimeShader(shaderName3);
    
    
                var shaderNameBinary = "]] .. shaderNameBinary .. [[";
                game.initLuaShader(shaderNameBinary);
                var shaderBinary = game.createRuntimeShader(shaderNameBinary);
    
                trace("HI!");
    
                game.getLuaObject("tempShaderBinary").shader = shaderBinary;
    
            game.camGame.setFilters([new ShaderFilter(shader0), new ShaderFilter(shader2), new ShaderFilter(shader3)]);
            game.camHUD.setFilters([new ShaderFilter(shader0), new ShaderFilter(shader3)]);
    
    
            game.getLuaObject("tempShader0").shader = shader0;
            game.getLuaObject("tempShader1").shader = shader2;
            game.getLuaObject("tempShader2").shader = shader3; // setting it into temporary sprite so luas can set its shader uniforms/properties
            return;
        ]])
        runTimer('shaderFade', 0.1)
        end
end
end

function onTimerCompleted(n)
if not lowQuality then
    if n == 'shaderFade' and binaryOn == true then
    runHaxeCode([[
        var shaderName = "]] .. shaderName .. [[";
        var shaderName2 = "]] .. shaderName2 .. [[";
        var shaderName3 = "]] .. shaderName3 .. [[";
        
        game.initLuaShader(shaderName);
        game.initLuaShader(shaderName2);
        game.initLuaShader(shaderName3);
        
        var shader0 = game.createRuntimeShader(shaderName);
        var shader2 = game.createRuntimeShader(shaderName2);
        var shader3 = game.createRuntimeShader(shaderName3);


        
            var shaderNameBinary = "]] .. shaderNameBinary .. [[";
            game.initLuaShader(shaderNameBinary);
            var shaderBinary = game.createRuntimeShader(shaderNameBinary);

            trace("HI!");

            game.getLuaObject("tempShaderBinary").shader = shaderBinary;

        game.camGame.setFilters([new ShaderFilter(shader0), new ShaderFilter(shaderBinary)]);
        game.camHUD.setFilters([new ShaderFilter(shader0)]);
        




        game.getLuaObject("tempShader0").shader = shader0;
        game.getLuaObject("tempShader1").shader = shader2;
        game.getLuaObject("tempShader2").shader = shader3; // setting it into temporary sprite so luas can set its shader uniforms/properties
        return;

    ]])
    elseif n == 'shaderFade' and binaryOn == false then
        runHaxeCode([[
            var shaderName = "]] .. shaderName .. [[";
            var shaderName2 = "]] .. shaderName2 .. [[";
            var shaderName3 = "]] .. shaderName3 .. [[";
            
            game.initLuaShader(shaderName);
            game.initLuaShader(shaderName2);
            game.initLuaShader(shaderName3);
            
            var shader0 = game.createRuntimeShader(shaderName);
            var shader2 = game.createRuntimeShader(shaderName2);
            var shader3 = game.createRuntimeShader(shaderName3);
    
    

    
            game.camGame.setFilters([new ShaderFilter(shader0)]);
            game.camHUD.setFilters([new ShaderFilter(shader0)]);
            
    
    
    
    
            game.getLuaObject("tempShader0").shader = shader0;
            game.getLuaObject("tempShader1").shader = shader2;
            game.getLuaObject("tempShader2").shader = shader3; // setting it into temporary sprite so luas can set its shader uniforms/properties
            return;
    
        ]])
    end
end
end

function shaderCoordFix()
if not lowQuality then
    runHaxeCode([[
        resetCamCache = function(?spr) {
            if (spr == null || spr.filters == null) return;
            spr.__cacheBitmap = null;
            spr.__cacheBitmapData = null;
        }
        
        fixShaderCoordFix = function(?_) {
            resetCamCache(game.camGame.flashSprite);
            resetCamCache(game.camHUD.flashSprite);
            resetCamCache(game.camOther.flashSprite);
        }
    
        FlxG.signals.gameResized.add(fixShaderCoordFix);
        fixShaderCoordFix();
        return;
    ]])
    end
    
    local temp = onDestroy
    function onDestroy()
        if not lowQuality then
        runHaxeCode([[
            FlxG.signals.gameResized.remove(fixShaderCoordFix);
            return;
        ]])
        if (temp) then temp() end
        end
    end
end
