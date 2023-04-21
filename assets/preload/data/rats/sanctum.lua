function onCreate()
    makeLuaSprite('sanctum2', 'bg_sanctum', -800,-575)
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
    makeGraphic('introBlack',0,0,'000000')
    setObjectCamera('introBlack', 'other')
    --addLuaSprite('introBlack', false)

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
