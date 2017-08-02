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
-- -------------------------------------------------------------------- 

local showChat, start, goChatBox
local onKey, onSaveB
local createSaveB
local sceneGroup = display.newGroup( )

local saveB

local bg

local chapterNum, chapterTextNum, isChapterStart, isEventEnded = 1, 1, true, true
local chapterString = { "Tales of the Wanderers", "It is Not that Soldiers Are Afraid of Death" }


function showChat( chapterNum, startLineNum )
	local textArray = textFile[chapterNum+2][startLineNum]
	local nameArray = textFile[1]
	local num = 0

	local createChatUI, showDialog, goNextLine, start
	local showDialogID

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

			local n = textArray[num][1]
			text = textArray[num][2]

			if n == -1 then
				chatBox.alpha = 0
				if text == "bell" then
					-- data.popUp()
					text = ""
					audio.play( sound.bell, { duration = 2500, onComplete = goNext, channel = 1 } )
				elseif text == "bgm" then
					text = ""
					audio.play( sound.bar, { loops = -1, channel = 1 })
					goNext()
				end
			else
				if n == nil then
					if textArray[num][3] then
						showName.text = nameArray[ textArray[num][3] + 1 ]
					end

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
					sceneGroup:insert(charImage)
					charImage:toBack()
					if bg then bg:toBack() end
				end

				timer.performWithDelay( 100, showDialog, -1 )
			end
		else
			if id then timer.cancel(id) end
			Runtime:removeEventListener( "key", press )
			showText:removeSelf( )
			chatBox:removeSelf()
			chatBox = nil
			isCurrentTextEnded = nil
			textArray = nil
			text = nil
			showDialogID = nil
			num = nil
			createUI = nil
			press = nil
			showDialog = nil
			start= nil
			goNext = nil

			if chapterTextNum == 1 then
			else
			end
			chapterTextNum = chapterTextNum + 1
		end
	end

	function start()
		createChatUI()
		Runtime:addEventListener( "key", onKey )
		goNext()
	end

	start()
end

function onKey(e)
	local keyName = e.keyName

	if e.phase == "down" then
		if keyName == "space" then
			if isCurrentTextEnded then
				goNext()
			else
				showText.text = text
				isCurrentTextEnded = true
			end
		end
	end
end

function onSaveB()
end

function createSaveB()
	saveB = widget.newButton(
	{
		left = 0,
		top = 0,
		defaultFile = "image/ui/saveB.png",
		overFile = "image/ui/saveBO.png",
		onRelease = onSaveB
	})

	saveB:scale(0.5, 0.5)
end

function goChatBox()
	showChat( chapterNum, chapterTextNum )
	chapterTextNum = chapterTextNum + 1
end

function start()
	-- isEventEnded : 씬을 바꿀 일이 있냐?
	-- isChapterStart : 새로운 챕터를 시작해야 하냐? ( 대화위주 )
	if isEventEnded then
		if isChapterStart then
			if bg then bg:removeSelf() end

			if chapterNum == 1 then
				bg = display.newImage( "image/bg/bar.png" )

				chapterEffect.showChapter( chapterNum, chapterString[chapterNum] )
				timer.performWithDelay( 7700, goChatBox ,1 )
			
			elseif chapterNum == 2 then
				if chapterTextNum == 1 then
					bg = display.newRect( 0, 0, _W, _H )
					bg:setFillColor( CC("000000") )

					chapterEffect.showChapter( chapterNum, chapterString[chapterNum] )

					timer.performWithDelay( 7700, goChatBox ,1 )
				elseif chaptertextNum == 5 then
					bg = display.newRect( 0, 0, _W, _H )
					bg:setFillColor( CC("000000") )
				elseif chapterTextNum == 6 or chapterTextNum == 10 or chapterTextNum == 12 or chapterTextNum == 14 then
					bg = display.newImage( "image/bg/bar.png" )
				elseif chapterTextNum == 7 or chapterTextNum == 11 or chapterTextNum == 13 then
					-- in house
				end
			elseif chapterNum == 3 then
			end
		else
			if chapterNum == 2 then
				if chapterTextNum == 1 then
				elseif chapterTextNum == 2 then
					-- 병사 시험 장면

				elseif chapterTextNum == 3 then
					-- 전투

				elseif chapterTextNum == 4 then
					-- 몇 걸음 걸어간다

				elseif chapterTextNum == 5 then
					-- A가 뛴다

				elseif chapterTextNum == 8 then
					-- 루크가 움직인당
				end

			elseif chapterNum == 3 then
			end
		end
		bg.x, bg.y = _W*0.5, _H*0.5
		sceneGroup:insert( bg )
	else
	end
	sceneGroup:insert(saveB)
	saveB:toFront( )
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

		-- music?
		createSaveB()
		start()

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
