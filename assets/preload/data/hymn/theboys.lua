doIdle = true
function onCreate()

	makeAnimatedLuaSprite('ghost1', 'characters/' .. 'CB-old', 900, -150);
	addAnimationByIndices('ghost1', 'idle', 'idle', '0,1,2,3,4', 16)
	objectPlayAnimation('ghost1', 'idle');
	addLuaSprite('ghost1', false);
	setProperty('ghost1.alpha', 0)
	scaleObject('ghost1', 1.25, 1.25);

	makeAnimatedLuaSprite('ghost2', 'characters/' .. 'CB-old', 500, 50);
	addAnimationByIndices('ghost2', 'idle', 'idle', '0,1,2,3,4', 16)
	objectPlayAnimation('ghost2', 'idle');
	addLuaSprite('ghost2', false);
	setProperty('ghost2.alpha', 0)
	scaleObject('ghost2', 0.9, 0.9);
	setProperty('ghost2.flipX', true)

	makeAnimatedLuaSprite('ghost3', 'characters/' .. 'CB-old', 200, 50);
	addAnimationByIndices('ghost3', 'idle', 'idle', '0,1,2,3,4', 16)
	objectPlayAnimation('ghost3', 'idle');
	addLuaSprite('ghost3', false);
	setProperty('ghost3.alpha', 0)
	scaleObject('ghost3', 0.8, 0.8);


end

function onStepHit()
	if curStep == 336 then
		doTweenAlpha('ghost1In', 'ghost1', 0.1, 1, 'linear')
	elseif curStep == 351 then
		doTweenAlpha('ghost3In', 'ghost3', 0.1, 1, 'linear')
	elseif curStep == 367 then
		doTweenAlpha('ghost2In', 'ghost2', 0.1, 1, 'linear')
	end
end

function onBeatHit()
	-- triggered 4 times per section
	if curBeat % 2 == 0 then
		for i = 1,3 do
		objectPlayAnimation('ghost' .. i, 'idle');
		end
	end
end
