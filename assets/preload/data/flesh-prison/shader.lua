local shaderName = "bloom"
local shaderName2 = "pixelate"
local shaderName3 = "radchr"
function onCreate()
    shaderCoordFix() -- initialize a fix for textureCoord when resizing game window

if not lowQuality then
    makeLuaSprite("tempShader0")
    makeLuaSprite("tempShader1")
    makeLuaSprite("tempShader2")


    runHaxeCode([[
        var shaderName = "]] .. shaderName .. [[";
        var shaderName2 = "]] .. shaderName2 .. [[";
        var shaderName3 = "]] .. shaderName3 .. [[";

        
        game.initLuaShader(shaderName);
        game.initLuaShader(shaderName2);
        game.initLuaShader(shaderName3);
        
        var shader0 = game.createRuntimeShader(shaderName);
        var shader2 = game.createRuntimeShader(shaderName2);
        var shader3 = game.createRuntimeShader(shaderName3);;

        game.camGame.setFilters([new ShaderFilter(shader0)]);
        game.camHUD.setFilters([new ShaderFilter(shader0)]);


        game.getLuaObject("tempShader0").shader = shader0;
        game.getLuaObject("tempShader1").shader = shader2;
        game.getLuaObject("tempShader2").shader = shader3;
        return;

    ]])

    initLuaShader("gaussian")
    setSpriteShader("heresy", "gaussian")
    setSpriteShader("heresyRed", "gaussian")
end
end

function onEvent(n)
if not lowQuality then

    if n == 'Add Camera Zoom' then
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
    if n == 'shaderFade' then
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
