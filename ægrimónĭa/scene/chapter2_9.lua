local composer = require "composer" 
local font = require "font.font"
local text = require "scenario.readText"
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
local moveFlag=0
local moveX, moveY=0, 0
bpsp.x, bpsp.y=_W*0.5,_H*0.5
rukeWalk.y=_H*0.4

function flaging()
	moveFlag=1
end

function movesir(event)
	if moveFlag==0 then
		if rukeWalk.x<450 and rukeWalk.y<246 then
			rukeWalk:play()
		end
		if rukeWalk.x < 450 then
			rukeWalk.x=rukeWalk.x+10
		elseif rukeWalk.y < 246 then
			rukeWalk.y=rukeWalk.y+3
		end
	end
	if moveFlag==1 then
		if rukeWalk.x>20 and rukeWalk.y>153 then
			rukeWalk:play()
		end
		if rukeWalk.x < 20 then
			rukeWalk.x=rukeWalk.x-10
		elseif rukeWalk.y < 153 then
			rukeWalk.y=rukeWalk.y-3
		end
		if rukeWalk.x==20 and rukeWalk.y==153 then
			-- 씬을 다 지워야됨
			composer.gotoScene("chapter")
		end 
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
		bpsp:play()
		if rukeWalk.x==140 and rukeWalk.y==246 then
			rukeWalk:pause()
			timer.performWithDelay(2000, flaging)
		end
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
	imsh:removeSelf()
	bpsp:removeSelf()
	rukeSheet:removeSelf()
	rukeWalk:removeSelf()
	moveFlag=nil
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
Runtime:addEventListener("enterFrame", movesir)
-- -----------------------------------------------------------------------------------

return scene