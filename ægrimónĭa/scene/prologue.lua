local composer = require "composer" 
local font = require "font.font"
local text = require "scenario.readText"
local data = require "data.data"
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
local currentLine=0
local bg, currentText, outer, inner, tiimer, going, start,id
local textArray=text[2]
local flag = true
local t = 20

function saveMove()
	composer.removeScene( "scene.loadFile" )
	composer.gotoScene("scene.loadFile", { time = t * 0.8, effect = "crossFade" })	
end

function goTo(event)
	currentLine=currentLine+1
	currentText.text=textArray[currentLine]
	if currentLine > table.maxn(text[2]) then
		timer.cancel(tiimer)
		bg:removeSelf()
		currentText:removeSelf()
		data.saveData( 1, 
			{
				chapterNum = 1,
				chapterTextNum = 1,
				isChapterStart = false,
				isEventEnded = true,
				date = ""
			})
		timer.performWithDelay( 1000, saveMove, 1 )
	end
	inner=transition.fadeIn(currentText, {time = t})
	outer=transition.fadeOut(currentText, {delay = 5*t, time = t})
end

function start()
	if flag then
		tiimer=timer.performWithDelay(6*t, goTo, -1)
		flag = false
	end
	currentText=display.newText("",_W*0.5, _H*0.5, font.squareEB, 50)
	currentText:setTextColor(0,0,0)
	currentText.align="center"
	currentText.alpha=0
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
	bg=display.newImage("image/bg/prolog.png", _W*0.5, _H*0.5)
	bg.alpha = 0
	transition.to( bg, { delay = 1000, time = 1500, alpha = 1, onComplete = start })
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
	bg = nil
	currentText = nil
	flag = nil
	timer = nil
	inner = nil
	outer = nil

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
