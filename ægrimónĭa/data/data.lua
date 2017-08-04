local composer = require "composer"
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


local saveData, loadData, checkData
local data = {}
local saveText = {}
local b = {}
local onSaveSlot = false

function goSaving()
	composer.removeScene( "scene.chapter" )
	composer.gotoScene( "scene.chapter", { time = 800, effect = "crossFade" } )
end

function M.popUp(typed, data)
	local createUI, closePopUp, onSlotB
	local bg, bg2, b0, t1, cb

	function createUI()
		bg = display.newRoundedRect( _W*0.5, _H*0.5, 1075, 600, 15 )
		bg.alpha = 0.5

		bg2 = display.newImage( "image/ui/saveSlotB.png", _W*0.5, _H*0.5 )
		bg2.alpha = 0.9
		bg2.strokeWidth = 2
		bg2:setStrokeColor(CC("ffffff"))

		t1 = display.newText( "", _W*0.5, _H*0.25, font.gothicYetHangul, 25 )

		cb = widget.newButton(
		{
			left = 1141.5,
			top = 60,
			defaultFile = "image/ui/cancel.png",
			overFile = "image/ui/cancelO.png",
			onEvent = closePopUp
		})

		b0 =
		{
			left = 0,
			top = 0,
			defaultFile = "image/ui/saveSlot.png",
			overFile = "image/ui/saveSlotO.png",
			onEvent = onSlotB,
			left = _W*0.1425,
			top = _H*0.37,
			strokeColor = { default = { CC("ffffff")}, over = { CC("666666")} },
			strokeWidth = 2,
		}

		b0.id = 1
		b[1] = widget.newButton( b0 )

		b0.id = 2
		b0.left = b0.left + 475
		b[2] = widget.newButton( b0 )

		b0.id = 3
		b0.left = b0.left - 475
		b0.top = b0.top + 187
		b[3] = widget.newButton( b0 )

		b0.id = 4
		b0.left = b0.left + 475
		b[4] = widget.newButton( b0 )

		for i = 1, 4, 1 do
			saveText[i] = {}
			saveText[i][1] = display.newText( "", b[i].x - 85, b[i].y - 45, font.gothicYetHangul, 15 )
			saveText[i][2] = display.newText( "", b[i].x, b[i].y + 20, font.squareEB, 30 )
			saveText[i][3] = display.newText( "", b[i].x + 180, b[i].y -45, font.squareEB, 15 )
		end

		if typed == "save" then b[1]:setEnabled( false ) end
	end

	function closePopUp()
		onSaveSlot = false
		bg2:removeSelf( )
		bg:removeSelf( )
		b[1]:setEnabled( true )
		for i = 1, 4, 1 do
			b[i]:removeSelf( )
			b[i] = nil
			saveText[i][1]:removeSelf( )
			saveText[i][2]:removeSelf( )
			saveText[i][3]:removeSelf( )
		end
		t1:removeSelf( )
		cb:removeSelf( )
		bg = nil
		bg2 = nil
		b0 = nil
		t1 = nil
		cb = nil
	end

	function onSlotB(e)
		--print("button : "..e.phase)
		if e.phase == "began" then
			local id = e.target.id
			--print("id : "..id)
			if typed == "save" then
				M.saveData( id, data, true )
			elseif typed == "load" then
				M.saveData( id, M.loadData(id) )

				closePopUp()
				timer.performWithDelay( 500, goSaving, 1 )
			end
		end
	end

	onSaveSlot = true
	createUI()
	checkData()
end

function M.saveData( num, data )
	data.date = os.date("%Y년 %m월 %d일  %H시 %M분 %S초")
	data.isChapterStart = tostring(data.isChapterStart)
	data.isEventEnded = tostring(data.isEventEnded)

	local path = system.pathForFile( "data"..num..".txt", system.DocumentsDirectory )
	local encoded = json.encode( data )

	local file, errorString = io.open( path, "w" )
	--print(path)

	if not file then
		--print("File error : ".. errorString )
	else
		file:write( encoded )

		io.close( file )
		print("Save data successful.")
	end
	file = nil

	if onSaveSlot then checkData() end
end

function M.loadData( num )
	local path = system.pathForFile( "data"..num..".txt", system.DocumentsDirectory )
	local file, errorString = io.open( path, "r" )

	if not file then
		--print("File error : " .. errorString )
	else
		local decoded, pos, msg = json.decodeFile( path )

		if not decoded then
			--print("decoded failed at " .. tostring(pos).. " : ".. tostring(msg))
		else
			--print( "data : "..decoded.date.."chapter : "..decoded.chapter.."\tchapterTextNum : "..decoded.chapterTextNum.."\tisChapterStart"..decoded.isChapterStart )
			return
			{ 
				date = decoded.date,
				chapterNum = decoded.chapterNum,
				chapterTextNum = decoded.chapterTextNum,
				--isChapterStart = decoded.isChapterStart,
				--isEventEnded = decoded.isEventEnded
				isChapterStart = ( decoded.isChapterStart == "true" ) and true or false,
				isEventEnded = ( decoded.isEventEnded == "true" ) and true or false
			}
		end
		io.close( file )
		--print("Load data successful.")
	end
	file = nil
end

function checkData()
	if typed == "save" then b[1]:setEnabled( false ) end

	for i = 1, 4, 1 do
		local path = system.pathForFile( "data"..i..".txt", system.DocumentsDirectory )
		--print("path : "..tostring(path))
		local file, errorString = io.open( path, "r" )

		if not file then
			data[i] = { "Empty" }
			--print(i.." : "..data[i][1])
		else
			local decoded, pos, msg = json.decodeFile( path )

			if not decoded then
				data[i] = { "Empty" }
				--print(i.." : "..data[i][1])
			else
				data[i] =
				{
					date = decoded.date,
					chapterNum = decoded.chapterNum,
					chapterTextNum = decoded.chapterTextNum,
					--isChapterStart = decoded.isChapterStart,
					--isEventEnded = decoded.isEventEnded
					isChapterStart = ( decoded.isChapterStart == "true" ) and true or false,
					isEventEnded = ( decoded.isEventEnded == "true" ) and true or false
				}
				--print(i.." : ")
				--print(data[i].date, data[i].chapterNum, data[i].chapterTextNum)
				--print(data[i].isChapterStart, data[i].isEventEnded)
				--print(type(data[i].isChapterStart), type(data[i].isEventEnded))
			end
		end
		io.close()

		file = nil
	end

	for i = 1, 4, 1 do
		if data[i][1] == "Empty" then
			saveText[i][2].text = data[i][1]
		else
			saveText[i][1].text = data[i].date
			saveText[i][2].text = "chapter "..data[i].chapterNum
			if i == 1 then
				saveText[i][3].text = "AUTO"
			end
		end

		--saveText[i].x = _W*0.1425 + 475*(i<=2 and 0 or 1)
		--saveText[i].y = _H*0.37 + 187*(1-i%2)
	end
end


return M