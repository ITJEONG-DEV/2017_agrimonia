-- Copyright (c) 2017 Corona Labs Inc.

local composer = require( "composer" )

-- Hide status bar
display.setStatusBar( display.HiddenStatusBar )

-- Seed the random number generator
math.randomseed( os.time() )

-- Reserve channel 1 for background music
audio.reserveChannels( 1 )
-- Reduce the overall volume of the channel
audio.setVolume( 0.5, { channel=1 } )

-- Go to the menu screen
 composer.gotoScene( "scene.startMenu" )
-- composer.gotoScene( "scene.prologue" )
-- composer.gotoScene( "scene.chapter" )
-- composer.gotoScene( "scene.loadFile" )
-- composer.gotoScene( "scene.minigame_2_1" )
-- composer.gotoScene( "ex" )