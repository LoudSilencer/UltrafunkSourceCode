function onCreate()
    makeLuaSprite('heresy', 'bg_blue', -300,-175)
    addLuaSprite('heresy', false)
    setScrollFactor('heresy', 0.9, 0.9)
    setProperty('heresy.alpha', 0)

    makeLuaSprite('heresyRed', 'bg_red', -300,-175)
    addLuaSprite('heresyRed', false)
    setScrollFactor('heresyRed', 0.9, 0.9)
    setProperty('heresyRed.alpha', 1)

    doTweenColor('bfcolor', 'boyfriendGroup', 'ff1f1f', 0.01, 'linear')
    doTweenColor('dadcolor', 'dadGroup', 'ff1f1f', 0.01, 'linear')

    makeLuaSprite('vignette', 'boobies', 0,0)
    addLuaSprite('vignette', false)
    setObjectCamera('vignette', 'other')
    scaleObject('vignette', 1.01,1.01)

    makeLuaSprite('vignette2', 'boobies', 0,0)
    addLuaSprite('vignette2', false)
    setObjectCamera('vignette2', 'other')
    scaleObject('vignette2', 1.01,1.01)

    makeLuaSprite('hurtVignette', 'vignette', 0,0)
    addLuaSprite('hurtVignette', false)
    setObjectCamera('hurtVignette', 'other')
    setProperty('hurtVignette.alpha', 0)

    makeLuaSprite('introBlack', '', 0,0)
    makeGraphic('introBlack',1280,720,'000000')
    setObjectCamera('introBlack', 'other')
    addLuaSprite('introBlack', false)
    
end

function noteMiss(id, noteData, noteType, isSustainNote)
    setProperty('hurtVignette.alpha', 0.5)
    doTweenAlpha('hurtAlpha', 'hurtVignette', 0, 0.5, 'linear')
end

function onUpdate()
    
    if curStep<=62 then
    textScroll()
    elseif curStep == 64 then
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


    if curStep >= 10 then
        if(check3==wordSize3) then
            check3=1
        end  
        local wordSize3 = string.len('LOCATION:            APPROACHING HERESY')
            splitWord3 = {}   
        for i=check3, check3 do            
            splitWord3[i] = string.sub('LOCATION:            APPROACHING HERESY', i, i)
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

    if curStep >= 20 then
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

    if curStep >= 30 then
        if(check5==wordSize5) then
            check5=1
        end  
        local wordSize5 = string.len("GABRIEL WAS MINE.")
            splitWord5 = {}   
        for i=check5, check5 do            
            splitWord5[i] = string.sub("GABRIEL WAS MINE.", i, i)
            check5= check5 +1;
            prevLetter5 = prevLetter5 .. splitWord5[i]
            makeLuaText('text5', prevLetter5, 700, 280, 530 - textOffsetY)
            setTextSize('text5', 30)
            setTextColor('text5', 'ff0000')
            setTextBorder('text5', 0, 'ff0000')
            setTextAlignment('text5', 'left')
            setObjectCamera('text5', 'other')
            addLuaText('text5')
        end
    end

    if curStep >= 44 then
        if(check6==wordSize6) then
            check6=1
        end  
        local wordSize6 = string.len("DO YOU THINK YOU'RE BETTER THAN ME?")
            splitWord6 = {}   
        for i=check6, check6 do            
            splitWord6[i] = string.sub("DO YOU THINK YOU'RE BETTER THAN ME?", i, i)
            check6= check6 +1;
            prevLetter6 = prevLetter6 .. splitWord6[i]
            makeLuaText('text6', prevLetter6, 700, 280, 560 - textOffsetY)
            setTextSize('text6', 30)
            setTextColor('text6', 'ff0000')
            setTextBorder('text6', 0, 'ff0000')
            setTextAlignment('text6', 'left')
            setObjectCamera('text6', 'other')
            addLuaText('text6')
        end
    end

    if curStep >= 54 then
        if(check7==wordSize7) then
            check7=1
        end  
        local wordSize7 = string.len('KILL STEALER')
            splitWord7 = {}   
        for i=check7, check7 do            
            splitWord7[i] = string.sub('KILL STEALER', i, i)
            check7= check7 +1;
            prevLetter7 = prevLetter7 .. splitWord7[i]
            makeLuaText('text7', prevLetter7, 700, 280, 590 - textOffsetY)
            setTextSize('text7', 30)
            setTextColor('text7', 'ff0000')
            setTextBorder('text7', 0, 'ff0000')
            setTextAlignment('text7', 'left')
            setObjectCamera('text7', 'other')
            addLuaText('text7')
        end
    end
end