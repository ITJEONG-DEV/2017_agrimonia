local composer = require "composer" 
local font = require "font.font"
local sound = require "sound.sound"
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local _W, _H = display.contentWidth, display.contentHeight
local pH=5
local mH=20
local dealed -- 딜이 들어온 방향(1=W, 2=A, 3=S, 4=D)
local delayTime=3000
local startFlag=0
local dealFlag=0, mobFlag=0
local bg, bg2, title, foot
local bt1, bt2
local mt1, mt2, mt3, mt4, mt5, mt6, mt7, mt8
local bgm, cgm
local hpImage=graphics.newImageSheet("image/charSprite/HP_UI_strip12png", {width=128, height=128, numFrames=12})
local currentKnight
local Knight={}
local heart={}

local CC = function (hex)
	local r = tonumber( hex:sub(1,2), 16 ) / 255
	local g = tonumber( hex:sub(3,4), 16 ) / 255
	local b = tonumber( hex:sub(5,6), 16 ) / 255
	local a = 255 / 255

	if #hex == 8 then a = tonumber( hex:sub(7,8), 16 ) / 255 end

	return r, g, b, a
end

function showImage()
	bg=display.newImageRect("image/bg/chapter2_1game.png", _W, _H)
	bg2=display.newRect(0, 0, _W, _H)
	bg.anchorX=0
	bg.anchorY=0
	bg2.anchorX=0
	bg2.anchorY=0
	bg2:setFillColor(0,0,0,0.5)

	title=display.newText({text="수련생 A와 대련", x=_W*0.5, y=_H*0.15, font=font.squareEB, fontSize=25})
	bt1=display.newText({text="게임 방법", x=_W*0.125, y=_H*0.35, font=font.squareEB, fontSize=18})
	mt1=display.newText({text="수련생 A가 상하좌우로 공격을 합니다.", x=_W*0.25, y=_H*0.475, font=font.squareEB, fontSize=12.5})
	mt2=display.newText({text="수련생 A는 공격 전에 동작이 느립니다.", x=_W*0.255, y=_H*0.55, font=font.squareEB, fontSize=12.5})
	mt3=display.newText({text="그 틈을 타서 공격하고 적의 공격을 막아야 합니다.", x=_W*0.31, y=_H*0.625, font=font.squareEB, fontSize=12.5})
	mt4=display.newText({text="단, 수련생 A의 공격은 점점 빨라집니다.", x=_W*0.2575, y=_H*0.7, font=font.squareEB, fontSize=12.5})

	bt2=display.newText({text="조작키", x=_W*0.695, y=_H*0.35, font=font.squareEB, fontSize=18})
	mt5=display.newText({text="W: 상단 방어   S: 하단 방어", x=_W*0.795, y=_H*0.475, font=font.squareEB, fontSize=12.5})
	mt6=display.newText({text="A: 좌측 방어   D: 우측 방어", x=_W*0.795, y=_H*0.55, font=font.squareEB, fontSize=12.5})
	mt7=display.newText({text="Q: 빠르고 약한 공격", x=_W*0.755, y=_H*0.625, font=font.squareEB, fontSize=12.5})
	mt8=display.newText({text="E: 강하고 느린 공격", x=_W*0.755, y=_H*0.7, font=font.squareEB, fontSize=12.5})

	foot=display.newText({text="PRESS SPACE BAR TO START", x=_W*0.5, y=_H*0.85, font=font.squareEB, fontSize=19.55})
end

function delaying()
	dealFlag=0
end

function dealingQ()
	mH=mH-1
	cgm=audio.play(sound.Qdeal, {loops=0})
	timer.performWithDelay(600, delaying, 1)
end

function dealingE()
	mH=mH-4
	cgm=audio.play(sound.Edeal, {loops=0})
	timer.performWithDelay(1200, delaying, 1)
end

function subPlayer() -- 플레이어 체력 깎음
	heart[pH]=display.newSprite(hpImage, {name="dying" start=1, count=12, time=100, loopCount=1, loopDirection="forward"})
	mobFlag=0
	if pH>=1 then
		pH=pH-1
	else
		-- 게임오버 화면을 띄웁시다
	end
end

function mobDealing(event) -- 공격 들어올 방향 정함
	math.randomseed(os.time())
	dealed=math.random(4)
	mobFlag=1
	currentKnight=display.newSprite(Knight[dealed], {name="dealing", start=1, count=3, time=800, loopCount=1, loopDirection="forward"})
	dealFlag=0
	if delayTime>=600 then
		delayTime=delayTime-300
	elseif delayTime>=500 then
		delayTime=delayTime-20
	end
end

function onGameStart()
	heart[1]=display.newImageRect(hpImage, 1, _W*0.05, _H*0.1)
	heart[2]=display.newImageRect(hpImage, 1, _W*0.125, _H*0.1)
	heart[3]=display.newImageRect(hpImage, 1, _W*0.2, _H*0.1)
	heart[4]=display.newImageRect(hpImage, 1, _W*0.275, _H*0.1)
	heart[5]=display.newImageRect(hpImage, 1, _W*0.35, _H*0.1)
	Knight[1]=graphics.newImageSheet("image/charSprite/fromUp.png", {width=640, height=360, numFrames=4})
	Knight[2]=graphics.newImageSheet("image/charSprite/fromLeft.png", {width=640, height=360, numFrames=3})
	Knight[3]=graphics.newImageSheet("image/charSprite/fromDown.png", {width=640, height=360, numFrames=3})
	Knight[4]=graphics.newImageSheet("image/charSprite/fromRight.png", {width=640, height=360, numFrames=3})
	currentKnight=display.newImageRect(Knight[1], 1, _W*0.5, _H*0.5)
	timer.performWithDelay(delayTime, mobDealing, 0)
end

-- -----------------------------------------------------------------------------------
-- basic settttting!
-- -----------------------------------------------------------------------------------

--[[
여남은 할일들
마커 띄우기
]]

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

end

-- show()
function scene:show( event )
 
	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		bgm=audio.play(sound.schi, {loops=-1})
		showImage()
		-- music?

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

		-- stop audio

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

	-- audio.dipose( musicTrack )

end

function onKeyEvent(event) -- 키를 입력받음
	if event.phase=="down" then
		if event.keyName="space" then
			if startFlag==0 then
				onGameStart()
			end
		end
		if event.keyName=="w" then
			if mobFlag==1 and dealed~=1 then
				subPlayer()
			else
				mobFlag=0
			end
		end
		if event.keyName=="a" then
			if mobFlag==1 and dealed~=2 then
				subPlayer()
			else
				mobFlag=0
			end
		end
		if event.keyName=="s" then
			if mobFlag==1 and dealed~=3 then
				subPlayer()
			else
				mobFlag=0
			end
		end
		if event.keyName=="d" then
			if mobFlag==1 and dealed~=4 then
				subPlayer()
			else
				mobFlag=0
			end
		end
		if event.keyName="q" then
			if dealFlag==0 then
				dealFlag=1
				dealingQ()
			end
		end
		if event.keyName="e" then
			if dealFlag==0 then
				dealFlag=1
				dealingE()
			end
		end
	end
end

-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
Runtime:addEventListener("key", onKeyEvent) -- 이벤트 리스너를 추가해서 onKeyEvent로 연결시킴
-- -----------------------------------------------------------------------------------

return scene
