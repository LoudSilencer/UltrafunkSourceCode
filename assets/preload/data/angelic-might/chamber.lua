function onCreate()

    makeAnimatedLuaSprite('heart', 'heart', -300,-175)
    addAnimationByPrefix('heart', 'heartBeat', 'anim', 18, false)
    addLuaSprite('heart', 0, 0)
    setScrollFactor('heart', 0.8, 0.8)

    makeLuaSprite('chamber', 'bg_heartchamber', -300,-175)
    addLuaSprite('chamber', false)
    setScrollFactor('chamber', 1, 1)
    setProperty('chamber.alpha', 1)



    makeLuaSprite('vignette', 'boobies', 0,0)
    addLuaSprite('vignette', false)
    setObjectCamera('vignette', 'other')
    scaleObject('vignette', 1.01,1.01)


    makeLuaSprite('hurtVignette', 'vignette', 0,0)
    addLuaSprite('hurtVignette', false)
    setObjectCamera('hurtVignette', 'other')
    setProperty('hurtVignette.alpha', 0)

    makeLuaSprite('introBlack', '', 0,0)
    makeGraphic('introBlack',1280,720,'000000')
    setObjectCamera('introBlack', 'other')
    addLuaSprite('introBlack', false)

    initLuaShader("gaussian")
    setSpriteShader("heart", "gaussian")
    
end

function onCreatePost()
    scaleObject('dad', 0.8, 0.8)
    scaleObject('boyfriend', 0.8, 0.8)

    doTweenY('GabrielDown', 'dad', getProperty('dad.y') -100, 2, 'sineInOut')
end

function onTweenCompleted(n)
    if n == 'GabrielDown' then
        doTweenY('GabrielUp', 'dad', getProperty('dad.y') + 100, 2, 'sineInOut')
    end

    if n == 'GabrielUp' then
        doTweenY('GabrielDown', 'dad', getProperty('dad.y') -100, 2, 'sineInOut')
    end
end

function onBeatHit()
    if curBeat % 4 == 0 then
        objectPlayAnimation('heart', 'heartBeat', false)
        triggerEvent('Add Camera Zoom', 0.015, 0)
        playSound('heartbeat', 0.5)

        objectPlayAnimation('dad', 'realIdle', false)
    end
end

local eyeSwapLeft = false
local eyeSwapRight = false
function onSectionHit()

    if mustHitSection == false then
            eyeSwapLeft = true
                if eyeSwapLeft == true and eyeSwapRight == true then
                    objectPlayAnimation('gf', 'idle')
                    eyeSwapRight = false
                end

        runTimer('leftTimer', 0.05)
    elseif mustHitSection == true then
            eyeSwapRight = true
                if eyeSwapRight == true and eyeSwapLeft == true then
                    objectPlayAnimation('gf', 'idle')
                    eyeSwapLeft = false
                end

        runTimer('rightTimer', 0.05)
    end
end

function noteMiss(id, noteData, noteType, isSustainNote)
    setProperty('hurtVignette.alpha', 0.5)
    doTweenAlpha('hurtAlpha', 'hurtVignette', 0, 0.5, 'linear')
end

function onUpdate()
    
    if curStep<=19 then
    textScroll()
    elseif curStep == 20 then
        for i = 1,7 do
        doTweenAlpha('textAlpha' .. i, 'text' .. i, 0, 2, 'linear')
        end
        doTweenAlpha('introAlpha', 'introBlack', 0, 2, 'linear')
    end


    if getProperty('gf.animation.curAnim.finished') == true and getProperty('gf.animation.curAnim.name') == 'idle-left' then
        objectPlayAnimation('gf', 'idle-left')
    elseif getProperty('gf.animation.curAnim.finished') == true and getProperty('gf.animation.curAnim.name') == 'idle-right' then
        objectPlayAnimation('gf', 'idle-right')
    end

end

function onTimerCompleted(n)
    if n == 'leftTimer' then
        objectPlayAnimation('gf', 'idle-left')
        triggerEvent('Alt Idle Animation', 'gf', '-left')
    elseif n == 'rightTimer' then
        objectPlayAnimation('gf', 'idle-right')
        triggerEvent('Alt Idle Animation', 'gf', '-right')
    end

end

prevLetter = ''
prevLetter2 = ''
prevLetter3 = ''
prevLetter4 = ''
prevLetter5 = ''
prevLetter6 = ''
prevLetter7 = ''
textLine = 0
textOffsetY = 0
function textScroll()


        if luaTextExists('text7') then
            textOffsetY = 150
        elseif luaTextExists('text6') then
            textOffsetY = 125
        elseif luaTextExists('text5') then
            textOffsetY = 100
        elseif luaTextExists('text4') then
            textOffsetY = 75
        elseif luaTextExists('text3') then
            textOffsetY = 50
        elseif luaTextExists('text2') then
            textOffsetY = 25
        end

    textLine = textLine + 1  
    if(check==wordSize) then
        check=1
    end  
    local wordSize = string.len('STATUS UPDATE:')
        splitWord = {}   
    for i=check, check do            
        splitWord[i] = string.sub('STATUS UPDATE:', i, i)
        check= check +1;
        prevLetter = prevLetter .. splitWord[i]
        makeLuaText('text1', prevLetter, 450, 280, 350 - textOffsetY)
        setTextSize('text1', 30)
        setTextBorder('text1', 0, 'ffffff')
        setTextAlignment('text1', 'left')
        setObjectCamera('text1', 'other')
        addLuaText('text1')
    end

    if curStep >= 5 then
        if(check2==wordSize2) then
            check2=1
        end  
        local wordSize2 = string.len('MACHINE ID:          CHOIRBOY')
            splitWord2 = {}   
        for i=check2, check2 do            
            splitWord2[i] = string.sub('MACHINE ID:          CHOIRBOY', i, i)
            check2= check2 +1;
            prevLetter2 = prevLetter2 .. splitWord2[i]
            makeLuaText('text2', prevLetter2, 700, 280, 410 - textOffsetY)
            setTextSize('text2', 30)
            setTextBorder('text2', 0, 'ffffff')
            setTextAlignment('text2', 'left')
            setObjectCamera('text2', 'other')
            addLuaText('text2')
        end
    end


    if curStep >= 8 then
        if(check3==wordSize3) then
            check3=1
        end  
        local wordSize3 = string.len('LOCATION:            APPROACHING CHAMBER')
            splitWord3 = {}   
        for i=check3, check3 do            
            splitWord3[i] = string.sub('LOCATION:            APPROACHING CHAMBER', i, i)
            check3= check3 +1;
            prevLetter3 = prevLetter3 .. splitWord3[i]
            makeLuaText('text3', prevLetter3, 900, 280, 440 - textOffsetY)
            setTextSize('text3', 30)
            setTextBorder('text3', 0, 'ffffff')
            setTextAlignment('text3', 'left')
            setObjectCamera('text3', 'other')
            addLuaText('text3')
        end
    end

    if curStep >= 10 then
        if(check4==wordSize4) then
            check4=1
        end  
        local wordSize4 = string.len('CURRENT OBJECTIVE:   ROAST ANGEL')
            splitWord4 = {}   
        for i=check4, check4 do            
            splitWord4[i] = string.sub('CURRENT OBJECTIVE:   ROAST ANGEL', i, i)
            check4= check4 +1;
            prevLetter4 = prevLetter4 .. splitWord4[i]
            makeLuaText('text4', prevLetter4, 700, 280, 470 - textOffsetY)
            setTextSize('text4', 30)
            setTextBorder('text4', 0, 'ffffff')
            setTextAlignment('text4', 'left')
            setObjectCamera('text4', 'other')
            addLuaText('text4')
        end
    end
end