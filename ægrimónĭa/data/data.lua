local json = require "json"
local widget = require "widget"
local font = require "font.font"

local M = {}

local _W, _H = display.contentWidth, display.contentHeight

local CC = function (hex)
	local r = tonumber( hex:sub(1,2), 16 ) / 255
	local g = tonumber( hex:sub(3,4), 16 ) / 255
	local b = tonumber( hex:sub(5,6), 16 ) / 255
	local a = 255 / 255

	if #hex == 8 then a = tonumber( hex:sub(7,8), 16 ) / 255 end

	return r, g, b, a
end


local saveData, loadData

function M.popUp(type)
	local bg, bg2, b0, b1, b2, b3, b4, t1

	bg = display.newRoundedRect( _W*0.5, _H*0.5, 1075, 600, 15 )
	bg.alpha = 0.5

	bg2 = display.newImage( "image/ui/saveSlotB.png", _W*0.5, _H*0.5 )
	bg2.alpha = 0.9

	t1 = display.newText( "", _W*0.5, _H*0.25, font.gothicYetHangul, 25 )

	b0 =
	{
		left = 0,
		top = 0,
		defaultFile = "image/ui/saveSlot.png",
		overFile = "image/ui/saveSlotO.png",
		left = _W*0.1425,
		top = _H*0.3,
	}
	b0.release = (type == "save") and saveData or loadData


	b0.id = 1
	b1 = widget.newButton( b0 )

	b0.id = 2
	b0.left = b0.left + 475
	b2 = widget.newButton( b0 )

	b0.id = 3
	b0.left = b0.left - 475
	b0.top = b0.top + 187
	b3 = widget.newButton( b0 )

	b0.id = 4
	b0.left = b0.left + 475
	b4 = widget.newButton( b0 )
end

function saveData()
	local path = system.pathForFile( "data"..num..".txt", system.ResourceDirectory )
	local encoded = json.encode( data )

	local file, errorString = io.open( path, "w" )
	print(path)

	if not file then
		print("File error : ".. errorString )
	else
		file:write( encoded )

		io.close( file )
		print("Save data successful.")
	end
end

function loadData( num )
	local path = system.pathForFile( "data"..num..".txt", system.ResourceDirectory )
	local file, errorString = io.open( path, "r" )

	if not file then
		print("File error : " .. errorString )
	else
		local decoded, pos, msg = json.decodedFile( path )

		if not decoded then
			print("decoded failed at " .. tostring(pos).. " : ".. tostring(msg))
		else
			print( "chapter : "..decoded.chapter.."\tchapterTextNum : "..decoded.chapterTextNum.."\tisChapterStart"..decoded.isChatperStart )
			return chapter
		end
	end
end

return M