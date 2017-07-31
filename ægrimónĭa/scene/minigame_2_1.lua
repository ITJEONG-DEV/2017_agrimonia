local composer = require "composer" 
local font = require "font.font"
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
local dealFlag=0

local CC = function (hex)
	local r = tonumber( hex:sub(1,2), 16 ) / 255
	local g = tonumber( hex:sub(3,4), 16 ) / 255
	local b = tonumber( hex:sub(5,6), 16 ) / 255
	local a = 255 / 255

	if #hex == 8 then a = tonumber( hex:sub(7,8), 16 ) / 255 end

	return r, g, b, a
end

function delaying()
	dealFlag=0
end

function dealingQ()
	mH=mH-1
	timer.performWithDelay(600, delaying, 1)
end

function dealingE()
	mH=mH-4
	timer.performWithDelay(1200, delaying, 1)
end

function subPlayer() -- 플레이어 체력 깎음
	pH=pH-1
	if ph<=0 then
		-- 게임오버 화면을 띄웁시다
	end
end

function mobDealing(event) -- 공격 들어올 방향 정함
	math.randomseed(os.time())
	dealed=math.random(4)
	dealFlag==0
	if delayTime>=600 then
		delayTime=delayTime-300
	elseif delayTime>=500 then
		delayTime=delayTime-20
	end
end

function onGameStart()
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
		display.newImageRect("image/chapter2_1game.png", _W, _H)
		-- 젠장 이거 어떻게든 해야지 display.newText()
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

function onKeyEvent(e) -- 키를 입력받음
		if e.phase=="down" then
			if e.keyName="space" then
				if startFlag==0 then
					onGameStart()
				end
			end
			if e.keyName=="w" then
				if dealed~=1 then
					subPlayer()
				end
			end
			if e.keyName=="a" then
				if dealed~=2 then
					subPlayer()
				end
			end
			if e.keyName=="s" then
				if dealed~=3 then
					subPlayer()
				end
			end
			if e.keyName=="d" then
				if dealed~=4 then
					subPlayer()
				end
			end
			if e.keyName="q" then
				if dealFlag==0 then
					dealFlag=1
					dealingQ()
				end
			end
			if e.keyName="e" then
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
