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
local chapterNum, chapterTextNum,isChapterStart, isEventEnded = 1, 1, true, true

local chapterString = { "Tales of the Wanderers", "It is Not that Soldiers Are Afraid of Death" }
local chatNum, goChat, start

start = function()
	-- isEventEnded : 씬을 바꿀 일이 있냐?
	-- isChapterStart : 새로운 챕터를 시작해야 하냐? ( 대화위주 )
	if isEventEnded then
		if isChapterStart then
			if bg then bg:removeSelf() end

			if chapterNum == 1 then
				bg = display.newImage( "image/bg/chapter1.png" )
			
			elseif chapterNum == 2 then
				if chapterTextNum == 1 then
					bg = displya.newRect( 0, 0, _W, _H )
					bg:setFillColor( CC("000000") )	
				elseif chapterTextNum == 2 then
				elseif chapterTextNum == 4 then
				end
			elseif chapterNum == 3 then
			end
		else
			if chapterNum == 2 then
				if chapterTextNum == 3 then
				end
			elseif chapterNum == 3 then
			end
		end
		bg.x, bg.y = _W*0.5, _H*0.5
		sceneGroup:insert( bg )
	else
	end
end

createUI = function()
end

goChat = function()
	chapterTextNum = chapterTextNum + 1

	chat.showChat( chapterNum, chapterTextNum )
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

		-- music?`

		chapterEffect.showChapter( chapterNum, chapterString[chapterNum] )
		createUI()

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
