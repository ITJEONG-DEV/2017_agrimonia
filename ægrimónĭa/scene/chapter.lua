local composer = require "composer" 
local font = require "font.font"
local widget = require "widget"
local chat = require "scenario.chatBox"
local chapterEffect = require "scenario.chapterEffect"

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

-- -----------------------------------------------------------------------------------
-- basic settttting!
-- -------------------------------------------------------------------- 
local onKey, onTouch, createUI
local bg
local sceneGroup
local chapterNum = 1
local chapterTextNum = 0
local chapterString = { "Tales of the Wanderers", "It is Not that Soldiers Are Afraid of Death" }
local chatNum, goChat

createUI = function()
	bg = display.newImage( sceneGroup, "image/bg/chapter1.png", _W*0.5, _H*0.5 )
end

goChat = function()
	chapterTextNum = chapterTextNum + 1

	chat.showChat( chapterNum+1, chapterTextNum )
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
	createUI()


end


-- show()
function scene:show( event )

	sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

		-- music?`
		chapterEffect.showChapter( chapterNum, chapterString[chapterNum] )

		timer.performWithDelay( 7700, goChat ,1 )

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
	b0 = nil

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
