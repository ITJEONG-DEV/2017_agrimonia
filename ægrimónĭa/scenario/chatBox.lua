local M = { }

local _W, _H = display.contentWidth, display.contentHeight

local textFile = require "scenario.readText"
local font = require "font.font"
local sound = require "sound.sound"

local CC = function (hex)
	local r = tonumber( hex:sub(1,2), 16 ) / 255
	local g = tonumber( hex:sub(3,4), 16 ) / 255
	local b = tonumber( hex:sub(5,6), 16 ) / 255
	local a = 255 / 255

	if #hex == 8 then a = tonumber( hex:sub(7,8), 16 ) / 255 end

	return r, g, b, a
end

-- -----------------------------------------------------------------------------------
-- code start
-- -----------------------------------------------------------------------------------
function M.showChat( chapterNum, startLineNum )
	local textArray = textFile[chapterNum+1][startLineNum]
	local nameArray = textFile[1]

	local showChatG = display.newGroup()

	local createUI, press, showDialog, start, goNext
	local chatBox, showName, showText, text
	local id, id2
	local isCurrentTextEnded
	local num = 0
	local charImage	

	--chat ui
	function createChatUI()
		chatBox = display.newImage( showChatG, "scenario/chatBox.png", _W*0.5, _H*0.86 )

		showName = display.newText( showChatG, "", _W*0.15, _H*0.86, font.gothicYetHangul, 35 )

		showText = display.newText( showChatG, "", _W*0.3, _H*0.86, font.gothicYetHangul, 25 )
		showText.anchorX = 0, 0
	end

	function press(e)
		local keyName = e.keyName

		if e.phase == "down" then
			if keyName == "space" then
				if id2 then timer.cancel(id2) end

				if isCurrentTextEnded then
					goNext()
				else
					showText.text = text
					isCurrentTextEnded = true
				end
			end
		end
	end

	function showDialog(e)
		id = e.source
		if string.len(showText.text) == string.len(text) then
			timer.cancel(id)
			isCurrentTextEnded = true
		end

		showText.text = showText.text .. text:sub( string.len(showText.text)+1, string.len(showText.text)+3 )	
	end


	function start()
		createChatUI()
		Runtime:addEventListener( "key", press )
		goNext()
	end

	function goNext()
		isCurrentTextEnded = false
		num = num + 1
		showName.text = ""
		if charImage then
			charImage:removeSelf()
			charImage = nil
		end

		if num <= table.maxn( textArray ) then
			showText.text = ""

			local n = textArray[num][1]
			text = textArray[num][2]

			if n == nil then
				if textArray[num][3] then
					showName.text = nameArray[ textArray[num][3] + 1 ]
				end
			elseif n == -1 then
				print(m)
				if text == "bell" then
					audio.play( sound.bell )
				elseif text == "bgm" then
					audio.play( sound.bar, { loops = -1, channel = 1 })
					goNext()
				end
				text = ""
			else
				showName.text = nameArray[n+1]
				if n == 0 then
					if textArray[num][3] == 1 then
						charImage = display.newImage( "image/charIllust/player_smile.png" )
					elseif textArray[num][3] == 2 then
						charImage = display.newImage( "image/charIllust/player_sad.png" )
					else
						charImage = display.newImage( "image/charIllust/player_normal.png" )
					end
				elseif n == 1 then
					charImage = display.newImage( "image/charIllust/ruke_normal.png")
				elseif n == 2 then
				elseif n == 3 then
				elseif n == 4 then
				elseif n == 5 then
				elseif n == 6 then
				end
			end
			if charImage then
				charImage.x, charImage.y = _W*0.5, _H-charImage.contentHeight*0.75*0.8/2
				charImage:scale(0.75,0.75)
				showChatG:insert(charImage)
				charImage:toBack()
			end

			timer.performWithDelay( 100, showDialog, -1 )
		else
			if id then timer.cancel(id) end
			if id2 then timer.cancel(id2) end
			Runtime:removeEventListener( "key", press )
			showText:removeSelf( )
			chatBox:removeSelf()
			chatBox = nil
			isCurrentTextEnded = nil
			textArray = nil
			text = nil
			id = nil
			id2 = nil
			num = nil
			createUI = nil
			press = nil
			showDialog = nil
			start= nil
			goNext = nil

			return true
		end
	end

	start()
end


return M