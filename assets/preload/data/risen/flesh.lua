local shaderName = "flesh"

function onCreate()
    shaderCoordFix() -- initialize a fix for textureCoord when resizing game window

if not lowQuality then
    shaderCoordFix() -- initialize a fix for textureCoord when resizing game window

    makeLuaSprite("tempShader0")
    runHaxeCode([[
        var shaderName = "]] .. shaderName .. [[";
        
        game.initLuaShader(shaderName);
        
        var shader0 = game.createRuntimeShader(shaderName);

        game.getLuaObject("tempShader0").shader = shader0; // setting it into temporary sprite so luas can set its shader uniforms/properties
        return;
    ]])
    
end
end


function onUpdate(elapsed)
    setShaderFloat("fleshbg", "iTime" , os.clock())
    setProperty('fleshbg.alpha', 1.3-getProperty('health')/2)
    setProperty('sanctum.alpha', getProperty('health')/2)
end


function onEvent(n)
if not lowQuality then
    if n == 'addBinary' then
        

        makeLuaSprite('fleshbg', 'bg_flesh', -2300,-1175)
        addLuaSprite('fleshbg', false)
        setScrollFactor('fleshbg', 0.9, 0.9)
        setProperty('fleshbg.alpha', 0)

        makeLuaSprite('sanctum', 'bg_sanctum', -825,-500)
        addLuaSprite('sanctum', false)
        setScrollFactor('sanctum', 0.9, 0.9)
        setProperty('sanctum.alpha', 1)

        makeLuaSprite('stem', 'stem', -815,-500)
        addLuaSprite('stem', false)
        setScrollFactor('stem', 0.9, 0.9)
        setProperty('stem.alpha', 1)
        --setObjectOrder('stem', getObjectOrder('fleshbg') + 1)



        setSpriteShader("fleshbg", "flesh")
        setProperty('fleshbg.alpha', 1)
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
    end 
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
