local composer = require "composer" 
local font = require "font.font"

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
-- -----------------------------------------------------------------------------------
local createUI, goChapter, circling

local img
local BD
local bg, bgData, bgSet, bgSheet
local count = 0

function goChapter()
	composer.removeScene( "scene.chapter" )
	composer.gotoScene( "scene.chapter", { time = 1600, effect = "crossFade" } )
end

function circling(e)
	if e.phase == "ended" then
		timer.performWithDelay( 50, goChapter, 1 )
	end
end

function createUI()
	bgData =
	{
		width = 250, 
		height = 50, 
		numFrames = 8, 
		sheetContentWidth = 2000, 
		sheetContentHeight = 50 
	}
	
	bgSet = 
	{ 
		{
			name = "default", 
			frames = { 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8 }, 
			time = 6000, 
			loopCount = 1 }
	}
	
	bgSheet = graphics.newImageSheet( "image/ui/loading.png", bgData )
	
	bg = display.newSprite( bgSheet, bgSet )

	bg:addEventListener( "sprite", circling )

	bg.x, bg.y = _W*0.5, _H*0.5
	
	bg:play()

	bg:scale(2,2)

	--img = display.newImage("image/charIllust/player_happy.png")
	--BD = display.newImage("image/bg/BD.png")

end

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
		createUI()

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
		bg:removeSelf()
		bgSheet = nil
		bgData = nil
		bgSet = nil
		bg = nil

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
