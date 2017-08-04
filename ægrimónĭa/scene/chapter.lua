local composer = require "composer" 
local font = require "font.font"
local widget = require "widget"
local chat = require "scenario.chatBox"
local chapterEffect = require "scenario.chapterEffect"
local textFile = require "scenario.readText"
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
-- chatting Modules
-- -----------------------------------------------------------------------------------
local currentData =
{
	chapterNum = 1,
	chapterTextNum = 1,
	isChapterStart = false,
	isEventEnded = true
}
local chapterString = { "Tales of the Wanderers", "It is Not that Soldiers Are Afraid of Death" }

local createButtonUI, onButton, showChat, whatIsNext, goChatBox, goChapter
local saveB, loadB, titleB
local bgData, bgSet, bgSheet

local isFirst = true
local sceneGroup

function createButtonUI()
	saveB = widget.newButton(
	{
		width = 50,
		height = 50,
		left = 25,
		top = 30,
		defaultFile = "image/ui/UI_SAVEB.png",
        overFile = "image/ui/UI_SAVEO.png",
		onEvent = onButton,
		id = "save",
	})

	loadB = widget.newButton(
	{
		width = 50,
		height = 50,
		left = 25 + 70*1,
		top = 30,
		defaultFile = "image/ui/UI_LOADB.png",
		overFile = "image/ui/UI_LOADO.png",
		onEvent = onButton,
		id = "load",	
	})

	titleB = widget.newButton(
	{
		width = 50,
		height = 50,
		left = 25 + 70*2,
		top = 28,
		defaultFile = "image/ui/UI_TITLEB.png",
		overFile = "image/ui/UI_TITLEO.png",
		onEvent = onButton,
		id = "title",	
	})

	sceneGroup:insert(saveB)
	sceneGroup:insert(loadB)
	sceneGroup:insert(titleB)
end

function onButton(e)
	if e.phase == "began" then
		if e.target.id == "save" then
			loadB:setEnabled( false )
			titleB:setEnabled( false )
			data.popUp( e.target.id, currentData )

		elseif e.target.id == "load" then
			saveB:setEnabled( false )
			titleB:setEnabled( false )
			data.popUp( e.target.id )

		elseif e.target.id == "title" then
			saveB:setEnabled( false )
			loadB:setEnabled( false )
			print("title")
		end
	elseif e.phase == "ended" then
		saveB:setEnabled( true )
		loadB:setEnabled( true )
		titleB:setEnabled( true )
	end
end

function goChapter()
	composer.removeScene( "scene.loadFile" )
	composer.gotoScene( "scene.loadFile", { time = 1600, effect = "crossFade" } )
end

function goChatBox()
	showChat( currentData.chapterNum, currentData.chapterTextNum )	
end

function autoSave()
	print("autoSave")
	print("chapterNum : "..currentData.chapterNum)
	print("chapterTextNum : "..currentData.chapterTextNum)
	if currentData.chapterNum == 1 then
		audio.fadeOut( { time = 2000 } )
		currentData.chapterNum = 2
		isChapterStart = false
	elseif currentData.chapterNum == 2 then
		if currentData.chapterNum == 14 then
			currentData.chaperNum = 3
			currentData.chapterTextNum = 1
		else
			currentData.chapterTextNum = currentData.chapterTextNum + 1

			if currentData.chatperTextNum == 3 then
				if currentData.isEventEnded then currentData.isEventEnded = false
				else currentData.isEventEnded = true
				end
			elseif currentData.chapterTextNum == 4 then
				if currentData.isEventEnded then currentData.isEventEnded = false
				else currentData.isEventEnded = true
				end
			elseif currentData.chapterTextNum == 5 then
				if currentData.isEventEnded then currentData.isEventEnded = false
				else currentData.isEventEnded = true
				end
			elseif currentData.chapterTextNum == 8 then
				if currentData.isEventEnded then currentData.isEventEnded = false
				else currentData.isEventEnded = true
				end
			elseif currentData.chapterTextNum == 9 then
				if currentData.isEventEnded then currentData.isEventEnded = false
				else currentData.isEventEnded = true
				end
			end
		end
	end

	data.saveData( 1, currentData )

	if currentData.chapterTextNum == 1 then
		print("goChapter")
		timer.performWithDelay( 500, goChapter, 1 )
	else
		print("whatIsNext")
		timer.performWithDelay( 500, whatIsNext, 1 )
	end
end

function showChat( chapterNum, startLineNum )
	local textArray = textFile[chapterNum+2][startLineNum]
	local nameArray = textFile[1]

	local createChatUI, showDialog, goNext, start

	local showText, showName, charImage, chatBox, onPress
	local num = 0
	local showDialogID, text
	local isCurrentTextEnded

	function createChatUI()
		chatBox = display.newImage( sceneGroup, "scenario/chatBox.png", _W*0.5, _H*0.86 )
		showName = display.newText( sceneGroup, "", _W*0.15, _H*0.86, font.gothicYetHangul, 35 )
		showText = display.newText( sceneGroup, "", _W*0.3, _H*0.86, font.gothicYetHangul, 25 )
		showText.anchorX = 0, 0
	end

	function showDialog(e)
		showDialogID = e.source

		if string.len(showText.text) == string.len(text) then
			timer.cancel(showDialogID)
			isCurrentTextEnded = true
		end

		showText.text = showText.text .. text:sub( string.len(showText.text)+1, string.len(showText.text)+3 )
	end

	function goNext()
		local n, m
		chatBox.alpha = 1
		isCurrentTextEnded = false
		num = num + 1
		showName.text = ""

		if charImage then
			charImage:removeSelf()
			charImage = nil
		end

		if num <= table.maxn( textArray ) then
			showText.text = ""

			n = textArray[num][1]
			text = textArray[num][2]
			m = textArray[num][3]

			if n == -1 then
				chatBox.alpha = 0

				if text == "bell" then
					text = ""
					audio.play( sound.bell, { duration = 2500, onComplete = goNext })
				elseif text == "bar" then
					text = ""
					audio.play( sound.bar, { loops = -1,  } )
					goNext()
				elseif text == "arena" then
					text = ""
					audio.play( sound.arena, { loops = -1 } )
					goNext()
				end
			else
				if n == nil then
					if m then
						showName.text = nameArray[textArray[num][3]+1]
					end

				else
					showName.text = nameArray[n+1]

					if n == 0 then
						if m == 1 then --smile
							charImage = display.newImage( "image/charIllust/player_smile.png" )
						elseif m == 6 then -- sad
							charImage = display.newImage( "image/charIllust/player_sad.png" )
						elseif m == 8 then -- happy
							charImage = display.newImage( "image/charIllust/player_happy.png" )
						else
							charImage = display.newImage( "image/charIllust/player_normal.png" )
						end

					elseif n == 1 or n == 7 then
						if m == 1 then --laugh
							charImage = display.newImage( "image/charIllust/ruke_laugh.png" )
						elseif m == 2 then --shimuruk
							charImage = display.newImage( "image/charIllust/ruke_shimuruk.png" )
						elseif m == 3 or m == 4 then --uridungjeol
							charImage = display.newImage( "image/charIllust/ruke_uridungjeol.png" )
						elseif m == 5 then --musseuk
							charImage = display.newImage( "image/charIllust/ruke_musseuk.png" )
						elseif m == 6 then --sad
							charImage = display.newImage( "image/charIllust/ruke_sad.png" )
						elseif m == 7 then --eyeclosed
							charImage = display.newImage( "image/charIllust/ruke_eyeclosed.png" )
						else
							charImage = display.newImage( "image/charIllust/ruke_normal.png" )
						end
					elseif n == 3 then
					elseif n == 4 then
						charImage = display.newImage( "image/charIllust/peris_armed.png")
					elseif n == 6 then
						if m == 1 then -- smile
							charImage = display.newImage( "image/charIllust/peris_smile.png" )
						elseif m == 8 then --happy
							charImage = display.newImage( "image/charIllust/peris_happy.png" )
						end
					end
				end

				if charImage then
					charImage.x, charImage.y = _W*0.5, _H - charImage.contentHeight * 0.75 * 0.8 / 2
					charImage:scale(0.75, 0.75)
					sceneGroup:insert(charImage)
					charImage:toBack()
					if bg then bg:toBack( ) end
				end

				timer.performWithDelay( 50, showDialog, -1 )
			end
		else
			--remove Chat Box
			if showDialogID then timer.cancel(showDialogID) end
			Runtime:removeEventListener( "key", onPress )
			showText:removeSelf()
			chatBox:removeSelf()
			showName:removeSelf()
			if charImage then charImage:removeself() end

			chaBox = nil
			isCurrentTextEnded = nil
			textArray = nil
			text = nil
			showDialogID = nil
			num = nil
			createChatUI = nil
			onPress = nil
			showDialog = nil
			start = nil
			goNext = nil

			autoSave()
		end
	end

	function start()
		createChatUI()
		Runtime:addEventListener( "key", onPress )
		goNext()
	end

	function onPress(e)
		if e.phase == "down" then
			if e.keyName == "space" then
				if isCurrentTextEnded then goNext()
				else showText.text = text isCurrentTextEnded = true
				end
			end
		end
	end

	start()
end

function whatIsNext()
	local db = data.loadData(1)

	currentData.chapterNum = db.chapterNum
	currentData.chapterTextNum = db.chapterTextNum
	currentData.isChapterStart = db.isChapterStart
	currentData.isEventEnded = db.isEventEnded
	db = nil

	print("whatIsNext")
	print(currentData.chapterNum)
	print(currentData.chapterTextNum)
	print(currentData.isChapterStart)
	print(currentData.isEventEnded)

	if currentData.isEventEnded then
		if not currentData.isChapterStart then
			currentData.isChapterStart = false

			if ( not isFirst or not isEventEnded ) and bg then
				bg:removeSelf()
				bg = nil
			else
				isFirst = false
			end

			if currentData.chapterNum == 1 then
				if currentData.chapterTextNum == 1 then
					bg = display.newImage( "image/bg/bar.png" )

					chapterEffect.showChapter( 1, chapterString[1] )
					timer.performWithDelay( 7700, goChatBox, 1 )
				end

			elseif currentData.chapterNum == 2 then
				if currentData.chapterTextNum == 1 then
					bg = display.newRect( 0, 0, _W, _H )
					bg:setFillColor( CC("000000") )

					chapterEffect.showChapter( 2, chapterString[2] )

					timer.performWithDelay( 7700, goChatBox, 1 )

				elseif currentData.chapterTextNum == 2 then
					bg = display.newImage( "image/bg/arena.png" )
					bg:scale(2,2)

				elseif currentData.chapterTextNum == 5 then
					bg = display.newRect( 0, 0, _W, _H )
					bg:setFillColor( CC("000000") )
				elseif currentData.chapterTextNum == 6 or currentData.chapterTextNum == 10 or currentData.chapterTextNum == 12 or currentData.chapterTextNum == 14 then
					bg = display.newImage( "image/bg/bar.png" )
				elseif currentData.chapterTextNum == 7 or currentData.chapterTextNum == 11 or currentData.chapterTextNum == 13	then
					bg = display.newSprite( bgSheet, bgData )
				end

			elseif currentData.chapterNum == 3 then
			end

			if currentData.chapterTextNum ~= 1 then
				timer.performWithDelay( 400, goChatBox, 1 )
			end

			bg.x, bg.y = _W*0.5, _H*0.5
			sceneGroup:insert(bg)
		else
			autoSave()
		end

	else
		if currentData.chapterNum == 2 then
			if currentData.chapterTextNum == 3 then
				-- battle
			elseif currentData.chapterTextNum == 4 then
				-- step by step
			elseif currentData.chapterTextNum == 5 then
				-- A running
			elseif currentData.chatperTextNum == 8 then
			end
		elseif currentData.chapterNum == 3 then
		end
	end

	saveB:toFront( )
	loadB:toFront( )
	titleB:toFront( )
end

------------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
	bgData = { width = 640, height = 360, numFrames = 4, sheetContentWidth = 2560, sheetContentHeight = 360 }
	bgSet = { name = "default", start = 1, count = 4, time = 1000, loopCount = 0 }
	bgSheet = graphics.newImageSheet( "image/bg/ruke_house.png", bgData )

end

-- show()
function scene:show( event )

	sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		createButtonUI()
		whatIsNext()
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
