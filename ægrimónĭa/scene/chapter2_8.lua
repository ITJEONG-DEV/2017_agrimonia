local composer = require "composer" 
local font = require "font.font"
local text = require "scenario.readText"
local chatBox=require "scenario.chatBox"
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local _W, _H = display.contentWidth, display.contentHeight

local CC = function (hex)
	local r = tonumber( hex:sub(1,2), 16 ) / 255
	local g = tonumber( hex:sub(3,4), 16 ) / 255
	local b = tonumber( hex:sub(5,6), 16 ) / 255
	local a = 255 / 255

	if #hex == 8 then a = tonumber( hex:sub(7,8), 16 ) / 255 end

	return r, g, b, a
end
local imsh=graphics.newImageSheet("image/bg/ruke_house_strip4.png", {width = 640, height = 360, numFrames = 4, sheetContentWidth = 2560, sheetContentHeight = 360})
local bpsp=display.newSprite(imsh, {name="background", frames={1, 2, 3, 4}, time=400, loopCount=0})
local rukeSheet=graphics.newImageSheet("image/charSprite/ruke_walk_strip6.png", {width = 256, height = 256, numFrames = 6, sheetContentWidth = 1536, sheetContentHeight = 256})
local rukeWalk=display.newSprite(rukeSheet, {name="walk1", frames={1, 2, 3, 4, 5, 6}, time=600, loopCount=1})
local rukeMove
local moveFlag, keyFlag=0, 0
local moveX, moveY=0, 0

function interaction()
	if rukeWalk.x >= 10 and rukeWalk.x <= 30 then
		if rukeWalk.y >= 153 and rukeWalk.y <= 156 then 
			-- 페리스 
			chatBox.showChat(2, 8)
		end
	end
	if rukeWalk.x >= 130 and rukeWalk.x <= 150 then
		if rukeWalk.y >=153 and rukeWalk.y <= 156 then
			-- 책장
			chatBox.showChat(2, 9)
		end
		if rukeWalk.y >= 243 and rukeWalk.y <= 246 then
			-- 하단 탁자
			chatBox.showChat(2, 10)
		end
	end
	if rukeWalk.x >= 260 and rukeWalk.x <= 280 then
		if rukeWalk.y >= 153 and rukeWalk.y <= 156 then
			-- 거울
			chatBox.showChat(2, 11)
		end
	end
	if rukeWalk.x >= 430 and rukeWalk.x <= 450 then
		if rukeWalk.y >= 243 and rukeWalk.y <= 246 then
			-- 우하단 탁자
			composer.removeScene("chapter2_9")
			composer.gotoScene("chapter2_9")
		end
	end
end

function movesir(event)
	if rukeWalk.x >= -50 and rukeWalk.x <= 450 then
		if rukeWalk.y >= 153 and rukeWalk.y <= 246 then
			if keyFlag==1 then
				rukeWalk:play()
				rukeWalk.x=rukeWalk.x+moveX
				rukeWalk.y=rukeWalk.y+moveY
			end
		end
	end
	if rukeWalk.x < -50 or rukeWalk.x > 450 then
		rukeWalk:play()
		rukeWalk.x=rukeWalk.x-moveX
		rukeWalk.y=rukeWalk.y+moveY
	end
	if rukeWalk.y < 153 or rukeWalk.y > 246 then
		rukeWalk:play()
		rukeWalk.x=rukeWalk.x+moveX
		rukeWalk.y=rukeWalk.y-moveY
	end
	if moveFlag == 1 then
		rukeWalk:play()
		if rukeWalk.y > 153 then
			rukeWalk.y=rukeWalk.y-30
		elseif rukeWalk.x >20 then
			rukeWalk.x=rukeWalk.x-10
		end 
	end
end

function onKeyEvent(event)
	if event.phase=="down" then
		keyFlag=1
		if event.keyName=="right" then
			moveX=10
		end
		if event.keyName=="left" then
			moveX=-10
		end
		if event.keyName=="up" then
			moveY=-3
		end
		if event.keyName=="down" then
			moveY=3
		end
		if event.keyName=="space" then
			interaction()
		end
	end	
	if event.phase=="up" then
		keyFlag=0
		moveX=0
		moveY=0
	end
end

-- -----------------------------------------------------------------------------------
-- basic settttting!
-- -----------------------------------------------------------------------------------


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
	start()
end


-- show()
function scene:show( event )
 
	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		-- music?
		bpsp.x, bpsp.y=_W*0.5,_H*0.5
		bpsp:play()
		rukeWalk.y=_H*0.4
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
	Runtime:removeEventListener("enterFrame", movesir)
	Runtime:removeEventListener("key", onKeyEvent)
	imsh:removeSelf()
	bpsp:removeSelf()
	rukeSheet:removeSelf()
	rukeWalk:removeSelf()
	rukeMove=nil
	moveFlag=nil
	keyFlag=nil
	moveX=nil
	moveY=nil
end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
Runtime:addEventListener("key", onKeyEvent)
Runtime:addEventListener("enterFrame", movesir)
-- -----------------------------------------------------------------------------------

return scene