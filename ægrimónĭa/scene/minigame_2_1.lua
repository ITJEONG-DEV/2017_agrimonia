local composer = require "composer" 
local font = require "font.font"
local sound = require "sound.sound"
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

local sceneGroup
-- -----------------------------------------------------------------------------------
-- basic settttting!
-- -----------------------------------------------------------------------------------
local showImage, hideImage, deleteImage, onKey
local bg, title, bgm
local tt1 = {}
local tt2 = {}
local tp
local phase = 1

function showImage()
	bg = display.newImage( sceneGroup, "image/bg/chapter2_1game.png", _W*0.5, _H*0.5 )
	bg.alpha = 0.8

	title = display.newText( sceneGroup, "수련생 A와 대련", _W*0.5, _H*0.15, font.squareEB, 40 )

	tt1[1] = display.newText( sceneGroup, "게임 방법", _W*0.1, _H*0.325, font.squareEB, 30 )
	tt1[2] = display.newText( sceneGroup, "조작키", _W*0.68, _H*0.325, font.squareEB, 30 )

	tt2[1] = display.newText( sceneGroup, "수련생 A가 상하좌우로 공격을 합니다.\n\n수련생 A는 공격 전에 동작이 느려집니다.\n\n그 틈을 타서 공격하고, 수련생 A의 공격을 막아야합니다.\n\n수련생 A의 공격은 점점 빨라집니다.", _W*0.25, _H*0.5, font.squareEB, 20 )
	tt2[2] = display.newText( sceneGroup, "W : 상단 방어        S : 하단 방어\n\nA : 좌측 방어         D : 우측 방어\n\nQ : 빠르고 약한 공격\n\nE : 강하고 느린 공격", _W*0.75, _H*0.5, font.squareEB, 20 )

	tp = display.newText( sceneGroup, "PRESS SPACEBAR TO START", _W*0.5, _H*0.85, font.squareEB, 30 )
end

function hideImage()
	transition.to( bg, { alpha = 0, time = 800 } )
	transition.to( title, { alpha = 0, time = 800 } )
	transition.to( tt1[1], { alpha = 0, time = 800 } )
	transition.to( tt1[2], { alpha = 0, time = 800 } )
	transition.to( tt2[1], { alpha = 0, time = 800 } )
	transition.to( tt1[2], { alpha = 0, time = 800 } )
	transition.to( tp, { alpha = 0, time = 800, onComplete = deleteImage } )
end

function deleteImage()
	bg:removeSelf()
	title:removeSelf()
	tt1[1]:removeSelf( )
	tt1[2]:removeSelf( )
	tt2[1]:removeSelf( )
	tt2[2]:removeSelf( )
	tp:removeSelf( )
	phase = phase + 1
end

function onKey(e)
	if phase == 1 then
		if e.phase == "down" then
			if e.keyName == "sapce" then
				hideImage()
			end
		end
	elseif phase == 2 then
	end
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

end

-- show()
function scene:show( event )
 
	sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		bgm = audio.play( sound.chi, { loops = -1 } )

		showImage()

		Runtime:addEventListener( "key", onKey )
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


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
