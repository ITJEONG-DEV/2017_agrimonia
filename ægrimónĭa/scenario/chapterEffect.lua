local M = {}

local font = require "font.font"

local _W, _H = display.contentWidth, display.contentHeight

function M.showChapter( chapterNum, chapterName )
	local bg, t1, t2

	local function remove()
		bg:removeSelf( )
		t1:removeSelf( )
		t2:removeSelf( )
		bg = nil
		t1 = nil
		t2 = nil
	end

	bg = display.newRect( 0, 0, _W, _H )
	bg.anchorX, bg.anchorY = 0, 0
	bg:setFillColor( 0,0,0 )

	t1 = display.newText( "CHAPTER "..chapterNum, _W*0.3-140, _H*0.3, font.squareB, 65 )
	t2 = display.newText( chapterName, _W*0.5, _H*0.525, font.MTCORSVA, 55 )

	t1.alpha = 0
	t2.alpha = 0

	transition.to( t1, { time = 3000, alpha = 1, x = t1.x + 140, transition = easing.outQuad } )
	transition.to( t2, { delay = 3500, time = 2000, alpha = 1, transition = easing.outQuad } )

	transition.to( bg, { delay = 5550, time = 2100, alpha = 0, transition = easing.inQuad, onComplete = remove } )
	transition.to( t1, { delay = 5550, time = 2000, alpha = 0, transition = easing.inQuad } )
	transition.to( t2, { delay = 5550, time = 2000, alpha = 0, transition = easing.inQuad } )
end

return M