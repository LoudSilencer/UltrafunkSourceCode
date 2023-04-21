function onCreate()
    makeLuaSprite('sanctum2', 'bg_sanctum', -300,-175)
    addLuaSprite('sanctum2', false)
    setScrollFactor('sanctum2', 0.9, 0.9)
    setProperty('sanctum2.alpha', 1)

    setScrollFactor('dad', 0.9, 0.9)
    
    setObjectOrder('gfGroup', getObjectOrder('dadGroup') + 1)


    makeLuaSprite('fleshg', 'fleshgrows', -300,-175)
    addLuaSprite('fleshg', true)
    setScrollFactor('fleshg', 0.9, 0.9)
    setProperty('fleshg.alpha', 0)

    --doTweenColor('bfcolor', 'boyfriendGroup', 'ff1f1f', 0.01, 'linear')
    --doTweenColor('dadcolor', 'dadGroup', 'ff1f1f', 0.01, 'linear')

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

    scaleObject('gfGroup', 0.9, 0.9)
    setProperty('gfGroup.alpha', 0)


    makeLuaSprite('glowingeyes', 'glowingeyes', 0,-300)
    addLuaSprite('glowingeyes', false)
    setObjectCamera('glowingeyes', 'hud')
    setObjectOrder('glowingeyes', getObjectOrder('fadeBLACK')+1)
    scaleObject('glowingeyes', 1.4, 1.4)
    setProperty('glowingeyes.alpha', 0)
    
end

function onCreatePost()

end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if noteType == 'GF Sing' then
        setProperty('glowingeyes.alpha', 1)
        doTweenAlpha('eyesAlpha', 'glowingeyes', 0, 0.4, 'sineOut')
    end
end

function noteMiss(id, noteData, noteType, isSustainNote)
    setProperty('hurtVignette.alpha', 0.5)
    doTweenAlpha('hurtAlpha', 'hurtVignette', 0, 0.5, 'linear')
end

function onEvent(n)
    if n == 'Drain' then
        setProperty('hurtVignette.alpha', 0.1)
        doTweenAlpha('hurtAlpha', 'hurtVignette', 0, 0.5, 'linear')
    end
end

function onStepHit()
    if curStep == 896 then
        setProperty('gfGroup.alpha', 1)
    end

    if curStep >= 928 then
        removeLuaSprite('glowingeyes', true)
    end
end

function onUpdate()
    
    if curStep<=19 then
    textScroll()
    elseif curStep > 50 then
        for i = 1,7 do
        doTweenAlpha('textAlpha' .. i, 'text' .. i, 0, 2, 'linear')
        end
        doTweenAlpha('introAlpha', 'introBlack', 0, 2, 'linear')
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
        local wordSize3 = string.len('LOCATION:            APPROACHING SANCTUM')
            splitWord3 = {}   
        for i=check3, check3 do            
            splitWord3[i] = string.sub('LOCATION:            APPROACHING SANCTUM', i, i)
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
        local wordSize4 = string.len('CURRENT OBJECTIVE:   FIND AN OPPONENT')
            splitWord4 = {}   
        for i=check4, check4 do            
            splitWord4[i] = string.sub('CURRENT OBJECTIVE:   FIND AN OPPONENT', i, i)
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