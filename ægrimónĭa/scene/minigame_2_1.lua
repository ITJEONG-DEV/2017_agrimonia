local composer = require "composer" 
local font = require "font.font"
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local _W, _H = display.contentWidth, display.contentHeight
local pH=5
local mH=10
local dealFlag=0
local dealed -- 딜이 들어온 방향(1=W, 2=A, 3=S, 4=D)
local delayTime=3000

local CC = function (hex)
	local r = tonumber( hex:sub(1,2), 16 ) / 255
	local g = tonumber( hex:sub(3,4), 16 ) / 255
	local b = tonumber( hex:sub(5,6), 16 ) / 255
	local a = 255 / 255

	if #hex == 8 then a = tonumber( hex:sub(7,8), 16 ) / 255 end

	return r, g, b, a
end

function mobDealing(event)
	math.randomseed(os.time())
	dealed=math.random(4)
end

-- -----------------------------------------------------------------------------------
-- basic settttting!
-- -----------------------------------------------------------------------------------

--[[
여남은 할일들

공격 키 만들어놓기
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
		display.newImageRect(../image/chapter2_1game.png,_W, _H)
		mobDealing()
		while dealFlag==0 do
			timer.performWithDelay(delayTime, mobDealing, 1)
			if delayTime>=600 then
				delayTime=delayTime-300
			elseif delayTime>=500 then
				delayTime=delayTime-20
			end
		end
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
			if e.keyName=="w" then
				if dealed~=1 then
					pH=pH-1
				end
			end
			if e.keyName=="a" then
				if dealed~=2 then
					pH=pH-1
				end
			end
			if e.keyName=="s" then
				if dealed~=3 then
					pH=pH-1
				end
			end
			if e.keyName=="d" then
				if dealed~=4 then
					pH=pH-1
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
