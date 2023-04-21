function onCreate()
    --setProperty('skipCountdown', true)

    makeLuaSprite('heresy', 'bg_blue', -300,-175)
    addLuaSprite('heresy', false)
    setScrollFactor('heresy', 0.9, 0.9)
    setProperty('heresy.alpha', 1)

    makeLuaSprite('arena', 'bg_swordarena', -300,-175)
    addLuaSprite('arena', false)
    setScrollFactor('arena', 0.9, 0.9)
    setProperty('arena.alpha', 0)

    makeLuaSprite('sanctum2', 'bg_sanctum', -700,-475)
    addLuaSprite('sanctum2', false)
    setScrollFactor('sanctum2', 0.9, 0.9)
    setProperty('sanctum2.alpha', 0)

    makeLuaSprite('stem', 'stem', -700,-470)
    addLuaSprite('stem', false)
    setScrollFactor('stem', 0.9, 0.9)
    setProperty('stem.alpha', 1)

    setScrollFactor('dad', 0.9, 0.9)
    
    setObjectOrder('gfGroup', getObjectOrder('dadGroup') + 1)


    makeLuaSprite('fleshg', 'fleshgrows', -300,-175)
    addLuaSprite('fleshg', true)
    setScrollFactor('fleshg', 0.9, 0.9)
    setProperty('fleshg.alpha', 0)

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
    --addLuaSprite('introBlack', false)

    makeAnimatedLuaSprite('animelines', 'animelines', 0,0)
    addLuaSprite('animelines', true)
    addAnimationByPrefix('animelines', 'animelines', 'animelines', 24, true)
    setProperty('animelines.alpha', 0)
    setObjectCamera('animelines', 'hud')
    setObjectOrder('animelines', 2)



    scaleObject('gfGroup', 0.9, 0.9)
    setProperty('gfGroup.alpha', 0)


    --setProperty('dad.x', 730)
    --setProperty('boyfriend.x', 20)

    --setProperty('fadeBLACK.alpha', 1)

end

function onCountdownTick(counter)
	-- counter = 0 -> "Three"
	-- counter = 1 -> "Two"
	-- counter = 2 -> "One"
	-- counter = 3 -> "Go!"
	-- counter = 4 -> Nothing happens lol, tho it is triggered at the same time as onSongStart i think
	if counter == 0 then
        
        playSound('coinFlip', 1)
    elseif counter == 1 then

        playSound('coinFlip', 1)
    elseif counter == 2 then

        playSound('coinFlip', 1)
    elseif counter == 3 then

        playSound('coinShoot', 1)
    end
end

function onGameOver()
    loadSong('Sub Five','2')
end

    animeLines = false
function onSongStart()
    animeLines = true
    triggerEvent('Add Camera Zoom', '', '')
end

function onCreatePost()

end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if noteType == 'GF Sing' then

    end
end

function opponentNoteHit()
    if curStep >= 656 and curStep <= 1166 then                  --Flesh 1
        cameraShake('game', 0.005, 0.1)
        cameraShake('hud', 0.002, 0.1)
    end

    if curStep >= 1167 and curStep <= 1807 then                 --Picobot
        cameraShake('game', 0.002, 0.1)
        cameraShake('hud', 0.001, 0.1)
    end

    if curStep >= 1808 and curStep <= 2319 then                 --Flesh 2
        cameraShake('game', 0.005, 0.1)
        cameraShake('hud', 0.002, 0.1)
    end

    if curStep >= 2320 and curStep <= 2863 then                 --Gabriel

        setScrollFactor('dad', 1, 1)

    end

    if curStep >= 2864 then                                     -- Minos
        cameraShake('game', 0.006, 0.2)
        cameraShake('hud', 0.001, 0.2)
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

    if n == 'Flash Camera White' then
        cameraShake('game', 0.006, 0.25)
        cameraShake('hud', 0.001, 0.25)
    end
end


function onStepHit()
    if curStep >= 656 and curStep <= 1166 then                  --Flesh 1
        setProperty('defaultCamZoom', 0.6)

        setProperty('dad.x', 355)
        setProperty('dad.y', -183)
        setScrollFactor('dad', 0.9, 0.9)

        setProperty('boyfriend.x', 1100)
        setProperty('boyfriend.y', 220)
    end

    if curStep >= 1167 and curStep <= 1807 then                 --Picobot
        setProperty('defaultCamZoom', 0.9)

        setProperty('dad.x', 0)
        setProperty('dad.y', 400)
        setScrollFactor('dad', 1, 1)

        setProperty('boyfriend.x', 850)
        setProperty('boyfriend.y', 120)
    end

    if curStep >= 1808 and curStep <= 2319 then                 --Flesh 2
        setProperty('defaultCamZoom', 0.6)

        setProperty('dad.x', 355)
        setProperty('dad.y', -183)
        setScrollFactor('dad', 0.9, 0.9)

        setProperty('boyfriend.x', -250)
        setProperty('boyfriend.y', 320)
        if flipV == false then
            setProperty('boyfriend.flipX', not getProperty('boyfriend.flipX'))
            flipV = true
            debugPrint('Flipped')
        end

    end

    if curStep >= 2320 and curStep <= 2863 then                 --Gabriel

        setScrollFactor('dad', 1, 1)

    end

    if curStep >= 2864 then                                     -- Minos
        setProperty('defaultCamZoom', 0.6)

        setProperty('dad.x', 470)
        setProperty('dad.y', 50)
        setScrollFactor('dad', 0.9, 0.9)

        setProperty('boyfriend.x', 1100)
        setProperty('boyfriend.y', 220)
        if flipV == true then
            setProperty('boyfriend.flipX', not getProperty('boyfriend.flipX'))
            flipV = false
        end
    end
end

flipV = false
function onUpdate()
    setProperty('stem.alpha', getProperty('sanctum2.alpha'))

    if animeLines == true then
        setProperty('animelines.alpha', getProperty('flashwhite.alpha') + 0.05)
    else
        setProperty('animelines.alpha', 0)
    end

end
