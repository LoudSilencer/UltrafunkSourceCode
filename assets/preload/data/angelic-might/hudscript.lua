    --*DEEP BREATH*--
function onCreate()
    if not downscroll then
        upScrollOffset = 60
    else
        upScrollOffset = 0
    end
    
    setProperty('showRating', false)
    setProperty('showComboNum', false)
    setProperty('introSoundsSuffix', 'BLANK')
    setProperty('skipCountdown', true)
    
    
    setPropertyFromClass('ClientPrefs', 'middleScroll', true)
    setProperty('camHUD.alpha', 0)
    
    makeLuaSprite('hudBox', '', 0, 0);
    makeGraphic('hudBox',275,65,'000000')
    addLuaSprite('hudBox', true);
    setObjectCamera('hudBox', 'hud')
    setProperty('hudBox.alpha', 0.5)
    setProperty('hudBox.angle', -7)
    setProperty('hudBox.x', 83)
    setProperty('hudBox.y', 563)
    
    makeLuaSprite('hudBox2', '', 0, 0);
    makeGraphic('hudBox2',275,145,'000000')
    addLuaSprite('hudBox2', true);
    setObjectCamera('hudBox2', 'hud')
    setProperty('hudBox2.alpha', 0.5)
    setProperty('hudBox2.angle', -7)
    setProperty('hudBox2.x', 70)
    setProperty('hudBox2.y', 414)
    
    makeLuaSprite('hudBox3', '', 0, 0);
    makeGraphic('hudBox3',295,280,'000000')
    addLuaSprite('hudBox3', true);
    setObjectCamera('hudBox3', 'hud')
    setProperty('hudBox3.alpha', 0.5)
    setProperty('hudBox3.angle', 2)
    setProperty('hudBox3.x', 900)
    setProperty('hudBox3.y', 244 + upScrollOffset)
    setObjectOrder('hudBox3', 2)
    
    
    makeLuaSprite('hudBox4', '', 0, 0);
    makeGraphic('hudBox4',295,100,'000000')
    addLuaSprite('hudBox4', true);
    setObjectCamera('hudBox4', 'hud')
    setProperty('hudBox4.angle', 2)
    setProperty('hudBox4.x', 907)
    setProperty('hudBox4.y', 138 + upScrollOffset)
    setProperty('hudBox4.alpha', 0.5)

    makeLuaSprite('hudBox5', '', 0, 0);
    makeGraphic('hudBox5',65,65,'000000')
    addLuaSprite('hudBox5', true);
    setObjectCamera('hudBox5', 'hud')
    setProperty('hudBox5.alpha', 0.5)
    setProperty('hudBox5.angle', -7)
    setObjectOrder('hudBox5', getObjectOrder('strumLineNotes') -1)
    setProperty('hudBox5.x', 362)
    setProperty('hudBox5.y', 541)

    makeLuaSprite('volume', 'volume', 0, 0);
    addLuaSprite('volume', true);
    setObjectCamera('volume', 'hud')
    scaleObject('volume', 0.64, 0.64)
    setProperty('volume.angle', -7)
    setObjectOrder('volume', getObjectOrder('strumLineNotes') -1)
    setProperty('volume.x', 362)
    setProperty('volume.y', 541)
    
    makeLuaSprite('finaleBlend', '', -1000,-1000)
    makeGraphic('finaleBlend', 1280,720, 'ffffff')
    scaleObject('finaleBlend', 3,3)
    setObjectCamera('finaleBlend', 'game')
    setProperty('finaleBlend.alpha', 0)
    addLuaSprite('finaleBlend', true)
    
    
    makeLuaSprite('micHud', 'micHud', 0, 0)
    addLuaSprite('micHud', true);
    setObjectCamera('micHud', 'hud')
    scaleObject('micHud', 0.29,0.29)
    setProperty('micHud.angle', -7)
    setProperty('micHud.x', 80)
    setProperty('micHud.y', 370)
    
    
    makeLuaText('healthNumber', 50, 200, 5, 579)
    addLuaText('healthNumber')
    setProperty('healthNumber.angle', - 7)
    setTextSize('healthNumber', 25)
    scaleObject('healthNumber', 1.3,1)
    setTextBorder('healthNumber', 0.5, 'ffffff')
    setObjectOrder('healthNumber', getObjectOrder('healthBar')+1)
    
    makeLuaText('susTxt', 'SUSTAIN', 400, 895, 500 + upScrollOffset)
    setProperty('susTxt.angle', 2)
    setTextBorder('susTxt', 0.5, 'ffffff')
    setTextSize('susTxt', 25)
    setTextAlignment('susTxt', 'left')
    
    makeLuaText('susNum', '', 400, 793, 494 + upScrollOffset)
    setProperty('susNum.angle', 2)
    setTextBorder('susNum', 0, 'ffffff')
    setTextSize('susNum', 30)
    setTextAlignment('susNum', 'right')
    
    makeLuaSprite('rank1', 'RankD', 0, 0);
    addLuaSprite('rank1', true);
    setObjectCamera('rank1', 'hud')
    setProperty('rank1.angle', 2)
    setProperty('rank1.x', 907-80)
    setProperty('rank1.y', 138-25 + upScrollOffset)
    setProperty('rank1.alpha', 0)
    
    makeLuaSprite('rank2', 'RankC', 0, 0);
    addLuaSprite('rank2', true);
    setObjectCamera('rank2', 'hud')
    setProperty('rank2.angle', 2)
    setProperty('rank2.x', 907-80)
    setProperty('rank2.y', 138-25 + upScrollOffset)
    setProperty('rank2.alpha', 0)
    
    makeLuaSprite('rank3', 'RankB', 0, 0);
    addLuaSprite('rank3', true);
    setObjectCamera('rank3', 'hud')
    setProperty('rank3.angle', 2)
    setProperty('rank3.x', 907-80)
    setProperty('rank3.y', 138-25 + upScrollOffset)
    setProperty('rank3.alpha', 0)
    
    makeLuaSprite('rank4', 'RankA', 0, 0);
    addLuaSprite('rank4', true);
    setObjectCamera('rank4', 'hud')
    setProperty('rank4.angle', 2)
    setProperty('rank4.x', 907-80)
    setProperty('rank4.y', 138-25 + upScrollOffset)
    setProperty('rank4.alpha', 0)
    
    makeLuaSprite('rank5', 'RankS', 0, 0);
    addLuaSprite('rank5', true);
    setObjectCamera('rank5', 'hud')
    setProperty('rank5.angle', 2)
    setProperty('rank5.x', 907-80)
    setProperty('rank5.y', 138-25 + upScrollOffset)
    setProperty('rank5.alpha', 0)
    
    makeLuaSprite('rank6', 'RankSS', 0, 0);
    addLuaSprite('rank6', true);
    setObjectCamera('rank6', 'hud')
    setProperty('rank6.angle', 2)
    setProperty('rank6.x', 907-80)
    setProperty('rank6.y', 138-25 + upScrollOffset)
    setProperty('rank6.alpha', 0)
    
    makeLuaSprite('rank7', 'RankSSS', 0, 0);
    addLuaSprite('rank7', true);
    setObjectCamera('rank7', 'hud')
    setProperty('rank7.angle', 2)
    setProperty('rank7.x', 895-75)
    setProperty('rank7.y', 135-23 + upScrollOffset)
    setProperty('rank7.alpha', 0)
    
    makeLuaSprite('rank8', 'RankU', 0, 0);
    addLuaSprite('rank8', true);
    setObjectCamera('rank8', 'hud')
    setProperty('rank8.angle', 2)
    setProperty('rank8.x', 907-80)
    setProperty('rank8.y', 138-25 + upScrollOffset)
    setProperty('rank8.alpha', 0)
    
    end
    
    function onSongStart()
    doTweenAlpha('hudIn', 'camHUD', 1, 0.1, 'linear')
    
	setPropertyFromClass('GameOverSubstate', 'characterName', 'CB-dead');
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'beautiful_nuts');
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'HEH1');
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'CB_RETRY');

    end
    
    function onGameOver()
        setProperty('camGame.zoom', 0.85)
    end

    function onUpdatePost()


    end
    
    
    local healthRound = 50
    function onStepHit()



    
    healthRound = getProperty('health')*50
    
    setTextString('healthNumber', math.floor(healthRound))
    setObjectOrder('healthNumber', getObjectOrder('healthBar')+1)
    end
    
    function onCreatePost()
    setTextFont('scoreTxt', 'Akkordeon-Six.ttf')
    setTextBorder('scoreTxt', 0, '891EAF')
    setTextFont('timeTxt', 'VCR_OSD_MONO_1.001.ttf')


    setTimeBarColors('000000', 'FF0000')
    setHealthBarColors('000000', 'E30100')
    setProperty('iconP1.alpha', 0)
    setProperty('iconP2.alpha', 0)
    setProperty('healthBar.angle', -7)
    setProperty('healthBar.x', 90)
    setProperty('healthBar.y', 570)
    setGraphicSize('healthBar', 260, 25)
    setGraphicSize('healthBarBG', 100, 100)
    setProperty('healthBarBG.visible', false)
    setProperty('healthBar.flipX', true)
    setObjectOrder('timeBar', 16)
    
    setProperty('timeBar.x', 50)
    setProperty('timeBarBG.alpha', 0)
    setProperty('timeBar.height', 400)
    setProperty('timeTxt.y', 30)
    setProperty('timeTxt.x', 230)
    
    
    noteTweenX('opponentStrums1', 0, 3000, 1, 'backInOut')
    noteTweenX('opponentStrums2', 1, 3000, 1, 'backInOut')
    noteTweenX('opponentStrums3', 2, 3000, 1, 'backInOut')
    noteTweenX('opponentStrums4', 3, 3000, 1, 'backInOut')
    
    end
    
    function opponentNoteHit(id, noteData, noteType, isSustainNote)
    
    triggerEvent('Drain', 0.01)
    --cameraShake('game', 0.002, 0.1)
    cameraShake('hud', 0.001, 0.1)

    end
    
    local hudLeft = false
    susTimer = 0.1
    disallowDisrespect = false
    function onUpdate()
        

        
        if holdZoom == true then
            triggerEvent('Camera Follow Pos', 740, 350)
        end



        setHealthBarColors('000000', 'E30100')
    
        if inGameOver then
            for i = 0,999 do
                removeLuaText('styleRating' .. i, true)
                setProperty('rank' .. i .. '.alpha', 0)
                end
            removeLuaText('susNum', false)
            removeLuaText('susTxt', false)
        end
    

    

    setTextSize('scoreTxt', 60)
    if downscroll then
    setProperty('scoreTxt.y', 40)
    else
    setProperty('scoreTxt.y', 620)
    end

    
    susTimer = susTimer + 1
    if susTimer > 180 then
        susTimer = 180
    end
    if susTimer == 180 then
        setTextString('susNum', math.floor(susTimer/60 * 10) / 10 .. 's+')
    else
        setTextString('susNum', math.floor(susTimer/60 * 10) / 10 .. 's')
    end
    
    
    if susTimer >= 180 then
        setTextColor('susNum', 'eb1f17')
        setTextBorder('susNum', 0.5, 'eb1f17')
        setTextSize('susNum', 50)
        setProperty('susNum.x', 787 + getRandomInt(-3,3))
        setProperty('susNum.y', 472 + getRandomInt(-3,3) + upScrollOffset)
        setProperty('susTxt.x', 895 + getRandomInt(-1,1))
        setProperty('susTxt.y', 500 + getRandomInt(-1,1) + upScrollOffset)
    elseif susTimer >= 60 then
        setTextColor('susNum', 'f39812')
        setTextBorder('susNum', 0.5, 'f39812')
        setTextSize('susNum', 40)
        setProperty('susNum.x', 790 + getRandomInt(-1,1))
        setProperty('susNum.y', 480 + getRandomInt(-1,1) + upScrollOffset)
        setProperty('susTxt.x', 895 + getRandomInt(-1,1))
        setProperty('susTxt.y', 500 + getRandomInt(-1,1) + upScrollOffset)
    else
        setTextColor('susNum', 'ffffff')
        setTextBorder('susNum', 0.5, 'ffffff')
        setTextSize('susNum', 30)
        setProperty('susNum.x', 793)
        setProperty('susNum.y', 493 + upScrollOffset)
    end
    
    if combo == 0 then
        for i = 0,999 do
            removeLuaText('styleRating' .. i, true)
            
            end
            removeLuaText('susNum', false)
            removeLuaText('susTxt', false)
            
    end
    

    rankTable = {'rank1', 'rank2', 'rank3', 'rank4', 'rank5', 'rank6', 'rank7', 'rank8'}
    
    if rankUp == true and rankVar ~= 0 then
        for i = 1,8 do
            setProperty(rankTable[i] .. '.alpha', 0)
        end    
    setProperty(rankTable[rankVar] .. '.alpha', 1)
    scaleObject(rankTable[rankVar], 1.5, 1.5)
    doTweenX('rankTweenX', rankTable[rankVar] .. '.scale', 1, 1.1, 'sineInOut')
    doTweenY('rankTweenY', rankTable[rankVar] ..  '.scale', 1, 1.1, 'sineInOut')
    
    rankUp = false
    end

    if disallowDisrespect == true then
        setProperty('volume.alpha', 0.2)
    else
        doTweenAlpha('volumeAlpha', 'volume', 0.9, 0.3, 'linear')
    end

    if combo == 800 then
        rankVar = 8
        rankUp = true
        combo = combo + 1
    elseif combo == 500 then
        rankVar = 7
        rankUp = true
        combo = combo + 1
    elseif combo == 420 then
        rankVar = 6
        rankUp = true
        combo = combo + 1
    elseif combo == 300 then
        rankVar = 5
        rankUp = true
        combo = combo + 1
    elseif combo == 200 then
        rankVar = 4
        rankUp = true
        combo = combo + 1
    elseif combo == 120 then
        rankVar = 3
        rankUp = true
        combo = combo + 1
    elseif combo == 50 then
        rankVar = 2
        rankUp = true
        combo = combo + 1
    elseif combo == 20 then
        rankVar = 1
        rankUp = true
        combo = combo + 1
    end
    

    
    if combo <= 9 then
        rankVar = 0
        for i = 1,8 do
            setProperty('rank' .. i .. '.alpha', 0)
        end
    end
    
    
    if keyboardJustPressed('SPACE') and disallowDisrespect == false and not inGameOver then
        randomAnim = {'singUP', 'singDOWN', 'singLEFT', 'singRIGHT'}
        randomSound = {'TBH', 'daniel', 'smosh', 'fart', 'stalker', 'MISS', 'FUCK', 'DIE', 'megalo', 'cbat', 'bong', 'bruh', 'pussy'}

        pickedSound = randomSound[getRandomInt(1,13)]

        characterPlayAnim('boyfriend', randomAnim[getRandomInt(1,4)], false)
        playSound(pickedSound, 0.3, pickedSound)


        addScore(350)

        





        styleRating = '+ DISRESPECT'
        combo = combo + 1
        makeLuaText('styleRating' .. ratingCount, '+ DISRESPECT', 400, 905, 250 + upScrollOffset)
        setTextAlignment('styleRating' .. ratingCount, 'left')
        setTextSize('styleRating' .. ratingCount, 40)
        setProperty('styleRating' .. ratingCount .. '.angle', 2)
        
        setTextBorder('styleRating' .. ratingCount, 0, 'ffffff')
        setTextColor('styleRating' .. ratingCount, 'ffffff')
    
        addLuaText('styleRating' .. ratingCount)
        
        doTweenY('styleTweenYIn','styleRating' .. ratingCount .. '.scale', 1.6, 0.0001, 'linear')
        doTweenY('styleTweenYOut','styleRating' .. ratingCount .. '.scale', 1, 0.3, 'bounceOut')
        
    
        for i = 0,prevRating do
        setProperty('styleRating' .. i .. '.x', getProperty('styleRating' .. i .. '.x') - 2)
        setProperty('styleRating' .. i .. '.y', getProperty('styleRating' .. i .. '.y') + 40)
        doTweenY('styleTweenYEnd','styleRating' .. i .. '.scale', 1, 0.0001, 'linear')
        end
    
        ratingCount = ratingCount + 1
        prevRating = ratingCount - 1
        delRating = ratingCount - 7
    
        if ratingCount >= 6 then
            setProperty('styleRating' .. delRating .. '.alpha', 0)
        end

        
        runTimer('disrespectTimer', 3)
        disallowDisrespect = true
    end
    
    end
    
    function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
    end
    
    function onTweenCompleted(n)
    if n == 'hudLeft' or n == 'hudRight' then
        doTweenX('hudReturn', 'camHUD', 0, 1.2, 'sineInOut')
        doTweenY('hudReturn2', 'camHUD', 0, 1.2, 'sineInOut')
    end

    
    end
    
    function onEvent(n)
    if n == 'Add Camera Zoom' then
    setTextColor('timeTxt', 'ff7878')
    setTextColor('scoreTxt', 'ff7878')
    setTextColor('healthNumber', 'ff7878')
    runTimer('textTimer', 0.1)
    
    cameraShake('game', 0.005, 0.2)
    cameraShake('hud', 0.002, 0.2)
    end
   

    if n == 'Flash Camera Intensity' then
        triggerEvent('Add Camera Zoom', 0.1, 0.04)
    end

    end
    
    function onTimerCompleted(n)
    if n == 'textTimer' then
        setTextColor('timeTxt', 'ffffff')
        setTextColor('scoreTxt', 'ffffff')
        setTextColor('healthNumber', 'ffffff')
    end
    
    if n == 'susCheck' then
        susCheck = true
        removeLuaText('susNum', false)
        removeLuaText('susTxt', false)
    end
    
        if n == 'disrespectTimer' then
    
            disallowDisrespect = false
    

        end
    
        if n == 'styleTimer' then
            ratingCount = 0
            prevRating = ratingCount - 1
            delRating = ratingCount - 7
            
            
            clearStyle = false
            for i = 0,999 do
            removeLuaText('styleRating' .. i, true)
            
            end
        end

        if n == 'doubleTimer' then
            doubleCheck = false
        end

    end
    
    
    ratingCount = 0
    prevRating = ratingCount - 1
    delRating = ratingCount - 6
    
    
    combo = 0
    susCheck = true
    function goodNoteHit(id, noteData, noteType, isSustainNote)
    
        

    if getPropertyFromGroup('notes', id, 'rating') ~= 'shit' and not isSustainNote and doubleCheck then --doubles
        
        runTimer('styleTimer', 3)
    
        makeLuaText('styleRating' .. ratingCount, ' + MULTI', 400, 905, 250 + upScrollOffset)
        setTextAlignment('styleRating' .. ratingCount, 'left')
        setTextSize('styleRating' .. ratingCount, 40)
        setProperty('styleRating' .. ratingCount .. '.angle', 2)
    
        setTextBorder('styleRating' .. ratingCount, 0, '23efdd')
        setTextColor('styleRating' .. ratingCount, '23efdd')
    
        addLuaText('styleRating' .. ratingCount)
        
        doTweenY('styleTweenYIn','styleRating' .. ratingCount .. '.scale', 1.6, 0.0001, 'linear')
        doTweenY('styleTweenYOut','styleRating' .. ratingCount .. '.scale', 1, 0.3, 'bounceOut')
        
    
        for i = 0,prevRating do
        setProperty('styleRating' .. i .. '.x', getProperty('styleRating' .. i .. '.x') - 2)
        setProperty('styleRating' .. i .. '.y', getProperty('styleRating' .. i .. '.y') + 40)
        doTweenY('styleTweenYEnd','styleRating' .. i .. '.scale', 1, 0.0001, 'linear')
        end
    
        ratingCount = ratingCount + 1
        prevRating = ratingCount - 1
        delRating = ratingCount - 7
    
        if ratingCount >= 6 then
            setProperty('styleRating' .. delRating .. '.alpha', 0)
        end
        

        doubleActive = false

    elseif getPropertyFromGroup('notes', id, 'rating') == 'sick' and not isSustainNote then
        
        runTimer('styleTimer', 3)
    
        makeLuaText('styleRating' .. ratingCount, '+ SICK', 400, 905, 250 + upScrollOffset)
        setTextAlignment('styleRating' .. ratingCount, 'left')
        setTextSize('styleRating' .. ratingCount, 40)
        setProperty('styleRating' .. ratingCount .. '.angle', 2)
    
        setTextBorder('styleRating' .. ratingCount, 0, 'efa21b')
        setTextColor('styleRating' .. ratingCount, 'efa21b')
    
        addLuaText('styleRating' .. ratingCount)
        
        doTweenY('styleTweenYIn','styleRating' .. ratingCount .. '.scale', 1.6, 0.0001, 'linear')
        doTweenY('styleTweenYOut','styleRating' .. ratingCount .. '.scale', 1, 0.3, 'bounceOut')
        
    
        for i = 0,prevRating do
        setProperty('styleRating' .. i .. '.x', getProperty('styleRating' .. i .. '.x') - 2)
        setProperty('styleRating' .. i .. '.y', getProperty('styleRating' .. i .. '.y') + 40)
        doTweenY('styleTweenYEnd','styleRating' .. i .. '.scale', 1, 0.0001, 'linear')
        end
    
        ratingCount = ratingCount + 1
        prevRating = ratingCount - 1
        delRating = ratingCount - 7
    
        if ratingCount >= 6 then
            setProperty('styleRating' .. delRating .. '.alpha', 0)
        end
    
    elseif getPropertyFromGroup('notes', id, 'rating') == 'good' and not isSustainNote then
        makeLuaText('styleRating' .. ratingCount, '+ GOOD', 400, 905, 250 + upScrollOffset)
        setTextAlignment('styleRating' .. ratingCount, 'left')
        setTextSize('styleRating' .. ratingCount, 40)
        setProperty('styleRating' .. ratingCount .. '.angle', 2)
    
        setTextBorder('styleRating' .. ratingCount, 0, '23efdd')
        setTextColor('styleRating' .. ratingCount, '23efdd')
    
        addLuaText('styleRating' .. ratingCount)
        
        doTweenY('styleTweenYIn','styleRating' .. ratingCount .. '.scale', 1.6, 0.0001, 'linear')
        doTweenY('styleTweenYOut','styleRating' .. ratingCount .. '.scale', 1, 0.3, 'bounceOut')
        
    
        for i = 0,prevRating do
        setProperty('styleRating' .. i .. '.x', getProperty('styleRating' .. i .. '.x') - 2)
        setProperty('styleRating' .. i .. '.y', getProperty('styleRating' .. i .. '.y') + 40)
        doTweenY('styleTweenYEnd','styleRating' .. i .. '.scale', 1, 0.0001, 'linear')
        end
    
        ratingCount = ratingCount + 1
        prevRating = ratingCount - 1
        delRating = ratingCount - 7
    
        if ratingCount >= 6 then
            setProperty('styleRating' .. delRating .. '.alpha', 0)
        end
        
    elseif getPropertyFromGroup('notes', id, 'rating') == 'bad' and not isSustainNote then
        makeLuaText('styleRating' .. ratingCount, '+ OK', 400, 905, 250 + upScrollOffset)
        setTextAlignment('styleRating' .. ratingCount, 'left')
        setTextSize('styleRating' .. ratingCount, 40)
        setProperty('styleRating' .. ratingCount .. '.angle', 2)
        
        setTextBorder('styleRating' .. ratingCount, 0, 'ffffff')
        setTextColor('styleRating' .. ratingCount, 'ffffff')
    
        addLuaText('styleRating' .. ratingCount)
        
        doTweenY('styleTweenYIn','styleRating' .. ratingCount .. '.scale', 1.6, 0.0001, 'linear')
        doTweenY('styleTweenYOut','styleRating' .. ratingCount .. '.scale', 1, 0.3, 'bounceOut')
        
    
        for i = 0,prevRating do
        setProperty('styleRating' .. i .. '.x', getProperty('styleRating' .. i .. '.x') - 2)
        setProperty('styleRating' .. i .. '.y', getProperty('styleRating' .. i .. '.y') + 40)
        doTweenY('styleTweenYEnd','styleRating' .. i .. '.scale', 1, 0.0001, 'linear')
        end
    
        ratingCount = ratingCount + 1
        prevRating = ratingCount - 1
        delRating = ratingCount - 7
    
        if ratingCount >= 6 then
            setProperty('styleRating' .. delRating .. '.alpha', 0)
        end
    end

    if noteType == "Invis" then
        makeLuaText('styleRating' .. ratingCount, '+ RICOSHOT', 400, 905, 250 + upScrollOffset)
        setTextAlignment('styleRating' .. ratingCount, 'left')
        setTextSize('styleRating' .. ratingCount, 40)
        setProperty('styleRating' .. ratingCount .. '.angle', 2)
        
        setTextBorder('styleRating' .. ratingCount, 0, '23efdd')
        setTextColor('styleRating' .. ratingCount, '23efdd')
    
        addLuaText('styleRating' .. ratingCount)
        
        doTweenY('styleTweenYIn','styleRating' .. ratingCount .. '.scale', 1.6, 0.0001, 'linear')
        doTweenY('styleTweenYOut','styleRating' .. ratingCount .. '.scale', 1, 0.3, 'bounceOut')
        
    
        for i = 0,prevRating do
        setProperty('styleRating' .. i .. '.x', getProperty('styleRating' .. i .. '.x') - 2)
        setProperty('styleRating' .. i .. '.y', getProperty('styleRating' .. i .. '.y') + 40)
        doTweenY('styleTweenYEnd','styleRating' .. i .. '.scale', 1, 0.0001, 'linear')
        end
    
        ratingCount = ratingCount + 1
        prevRating = ratingCount - 1
        delRating = ratingCount - 7
    
        if ratingCount >= 6 then
            setProperty('styleRating' .. delRating .. '.alpha', 0)
        end
    end
    
    if getPropertyFromGroup('notes', id, 'rating') == 'shit' and not isSustainNote then
        makeLuaText('styleRating' .. ratingCount, '+ SHIT', 400, 905, 250 + upScrollOffset)
        setTextAlignment('styleRating' .. ratingCount, 'left')
        setTextSize('styleRating' .. ratingCount, 40)
        setProperty('styleRating' .. ratingCount .. '.angle', 2)
    
        setTextBorder('styleRating' .. ratingCount, 0, '817a75')
        setTextColor('styleRating' .. ratingCount, '817a75')
    
        addLuaText('styleRating' .. ratingCount)
        
        doTweenY('styleTweenYIn','styleRating' .. ratingCount .. '.scale', 1.6, 0.0001, 'linear')
        doTweenY('styleTweenYOut','styleRating' .. ratingCount .. '.scale', 1, 0.3, 'bounceOut')
        
    
        for i = 0,prevRating do
        setProperty('styleRating' .. i .. '.x', getProperty('styleRating' .. i .. '.x') - 2)
        setProperty('styleRating' .. i .. '.y', getProperty('styleRating' .. i .. '.y') + 40)
        doTweenY('styleTweenYEnd','styleRating' .. i .. '.scale', 1, 0.0001, 'linear')
        end
    
        ratingCount = ratingCount + 1
        prevRating = ratingCount - 1
        delRating = ratingCount - 7
    
        if ratingCount >= 6 then
            setProperty('styleRating' .. delRating .. '.alpha', 0)
        end
    end
    
    runTimer('doubleTimer', 0.02)
    doubleCheck = true

    if doubleCheck == true then
        
    end
    
    combo = combo + 1
    
    
    if isSustainNote then
    runTimer('susCheck', 0.5)
    else
        runTimer('susCheck', 0.1)
    end
    
    if isSustainNote and susCheck == true then
    susTimer = 0.1
    addLuaText('susNum')
    addLuaText('susTxt')
    runTimer('susCheck', 0.5)
    susCheck = false
    end
    
    
    
    
    end
    
    allowZoom = false
    local clearStyle = false
    function onSectionHit()


        if mustHitSection == false then
            if allowZoom == false then
                setProperty('defaultCamZoom', 0.7)
            end
        


        elseif mustHitSection == true then
            setProperty('defaultCamZoom', 1.2)
        end

     if mustHitSection == true and clearStyle == false then
        clearStyle = true
    elseif mustHitSection == false and clearStyle == true then
    end
    end
    
    function noteMiss(id, noteData, noteType, isSustainNote)
    ratingCount = 0
    prevRating = ratingCount - 1
    delRating = ratingCount - 7
    
    
    clearStyle = false
    combo = 0
    for i = 0,999 do
    removeLuaText('styleRating' .. i, true)
    
    end
    
    removeLuaText('susNum', false)
    removeLuaText('susTxt', false)
    
    end



	 
