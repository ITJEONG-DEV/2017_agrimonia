local composer = require "composer" 
local font = require "font.font"
local widget = require "widget"
local sound = require "sound.sound"
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

-- -----------------------------------------------------------------------------------
-- basic settttting!
-- -------------------------------------------------------------------- 
local twinkle, onKey, onTouch, createUI, onStartB, onLoadB, onExitB, goOther, turnTouchPhase, BDtran
local bg, BD, BD2, t1, t2, t3, b0, b1, b2, b3, b4, id, id2
local isFirst = true
local twinklePhase, touchPhase = 1, 0
local position = 1
local sceneGroup
local buttonNum, term = 3, 100
local t = 1500
local hereSound

BDtran = function(e)
	id2 = e.source
	local m = 1
	transition.to( BD, { alpha = 0.8, time = t, transition = easing.inQuad } )
	transition.to( BD2, { alpha = 0, time = t, transition = easing.outQuad } )

	transition.to( BD, { x = BD.x + m, y = BD.y - m, time = t, transition = easing.inQuad } )
	transition.to( BD2, { x = BD2.x - m, y = BD2.y + m, time = t, transition = easing.inQuad } )

	transition.to( BD, { alpha = 0, time = t, delay = t*1.5, transition = easing.outQuad } )
	transition.to( BD2, { alpha = 0.8, time = t, delay = t*1.5, transition = easing.inQuad } )

	transition.to( BD, { x = BD.x - m, y = BD.y + m, time = t, delay = t*1.5, transition = easing.inQuad } )
	transition.to( BD2, { x = BD2.x + m, y = BD2.y - m, time = t, delay = t*1.5, transition = easing.inQuad } )
end

twinkle = function(e)
	id = e.source
	twinklePhase = 1 - twinklePhase
	transition.to( t2, { time = 750, alpha = twinklePhase, transition = (twinklePhase == 0) and easing.outCubic or easing.inQubic } )
end

turnTouchPhase = function()
	touchPhase = touchPhase + 1
	if touchPhase == 1 then createUI() end
end

onKey = function(e)
	-- touch to start
	if touchPhase == 0 then
		if e.phase == "down" then
			if id then
				timer.cancel( id )
				t2:removeSelf( )
				t2 = nil
				id = nil
				twinkle = nil

				transition.to( t1, { time = 10, size = 100, y = _H*0.25, transition = easing.outQuad, onComplete = turnTouchPhase } )
			end
		end

	-- selectMenu
	elseif touchPhase == 1 then
		if isFirst then
			t3.alpha = 1
			isFirst = false
		else
			if e.phase == "down" then
				if e.keyName == "space" or e.keyName == "enter" then
					goOther()
				elseif e.keyName == "down" or e.keyName == "right" then
					if position == buttonNum then
						position = 1
						t3.y = t3.y - term*(buttonNum-1)
					else
						position = position + 1
						t3.y = t3.y + term
					end
				elseif e.kayName == "up" or e.keyName == "left" then
					if position == 1 then
						position = buttonNum
						t3.y = t3.y + term*(buttonNum-1)
					else
						position = position - 1
						t3.y = t3.y - term
					end
				end
			end
		end
	end
end

onTouch = function(e)
	if touchPhase == 0 then
		if e.phase == "began" then
			if id and isFirst then
				timer.cancel(id)
				t2:removeSelf()
				t2, id = nil, nil

				transition.to( t1, { time = 10, size = 100, y = _H*0.25, transition = easing.outQuad, onComplete = turnTouchPhase } )
			end
		end
	elseif touchPhase == 1 then
		if e.target then
			local id = e.target.id

			if id >= 1 and id <= buttonNum then
				position = id
				t3.alpha = 1
				t3.y = _H*0.5 + term*(position-1)
				goOther()
			end
		end
	end
end

createUI = function()
	Runtime:removeEventListener( "touch", onTouch )
	b0 =
	{
		label = "text",
		width = 500,
		height = 50,
		x = _W*0.5,
		y = _H*0.5,
		font = font.squareL ,
		onPress = onTouch,
		textOnly = true,
		fontSize = 30,
		labelColor = { default = { CC("000000") }, over = { CC("555555")}  },
	}

	b0.label = "START"
	b1 = widget.newButton(b0)
	b1.id = 1
	sceneGroup:insert(b1)

	b0.label = "LOAD"
	b0.y = b0.y + term
	b2 = widget.newButton(b0)
	b2.id = 2
	sceneGroup:insert(b2)

	b0.label = "EXIT"
	b0.y = b0.y + term
	b3 = widget.newButton(b0)
	b3.id = 3
	sceneGroup:insert(b3)
end

onStartB = function( )
	audio.fadeOut( { time = 2000 } )
	composer.removeScene( "scene.prologue" )
	composer.gotoScene( "scene.prologue", { time = 800, effect = "crossFade" } )
	--composer.removeScene( "scene.chapter" )
	--composer.gotoScene( "scene.chapter", { time = 800, effect = "crossFade" } )
end

onLoadB = function( )
	data.popUp("load")
end

onExitB = function( )
	os.exit( )
end

goOther = function()
	b1:setEnabled( false )
	b2:setEnabled( false )
	b3:setEnabled( false )
	Runtime:removeEventListener( "key", onKey )
	if position == 1 then
		onStartB()
	elseif position == 2 then
		onLoadB()
	elseif position == 3 then
		onExitB()
	end
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	bg = display.newImage( sceneGroup, "image/bg/bg.png", _W*0.5, _H*0.5 )

	BD = display.newImage( sceneGroup, "image/bg/BD.png", _W*0.5, _H*0.5 )
	BD.alpha = 0

	BD2 = display.newImage( sceneGroup, "image/bg/BD.png", _W*0.5, _H*0.5 )
	BD2.rotation = 180
	BD2.alpha = 0.8

	timer.performWithDelay( t*3, BDtran, 0 )

	-- t1 = display.newText( sceneGroup, "ægrimónĭa", _W*0.5, _H*0.35, font.vectra, 120)
	t1 = display.newText( sceneGroup, "ægrimónia", _W*0.5, _H*0.35, font.vectra, 130)
	t1:setFillColor( CC("000000") )

	t2 = display.newText( sceneGroup, "TOUCH TO START", _W*0.5, _H*0.75, font.squareL, 30)	
	timer.performWithDelay( 800, twinkle, -1 )
	t2:setFillColor( CC("000000") )

	t3 = display.newPolygon( sceneGroup, _W*0.55, _H*0.5, { 0, 0, 15, -7.5, 15, 7.5 } )
	t3.alpha = 0
	t3:setFillColor( CC("000000") )

	Runtime:addEventListener( "key", onKey )
	Runtime:addEventListener( "touch", onTouch )

	hereSound = audio.play( sound.start, { fadein = 3500, loops = -1 } )
end


-- show()
function scene:show( event )

	sceneGroup = self.view
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
		audio.stop( )

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
	Runtime:removeEventListener( "key", onKey )
	Runtime:removeEventListener( "touch", onTouch )
	b1:removeSelf()
	b2:remoevSelf()
	b3:removeSelf()
	bg:removeSelf()
	BD:removeSelf()
	BD2:removeSelf()
	t1:removeSelf()
	t2:removeSelf()
	t3:removeSelf()

	b0 = nil
	b1 = nil
	b2 = nil
	b3 = nil
	bg = nil
	BD = nil
	BD2 = nil
	t1 = nil
	t2 = nil
	t3 = nil
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