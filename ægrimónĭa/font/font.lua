-- using example
-- local font = require "font.font"
-- showText = display.newText( "halo", 300, 500, font.gothicCoding, 25 )

local M = {}

M.gothicCoding = native.newFont( "font/NanumGothicCoding.ttf" )
M.gothicCodingB = native.newFont( "font/NanumGothicCoding-Bold.ttf" )
M.squareB = native.newFont( "font/NanumSquareB.ttf" )
M.squareEB = native.newFont( "font/NanumSquareEB.ttf" )
M.squareL = native.newFont( "font/NanumSquareL.ttf" )
M.squareR = native.newFont( "font/NanumSquareR.ttf" )
M.gothicYetHangul = native.newFont( "font/NanumBarunGothic-YetHangul.ttf" )
M.MTCORSVA = native.newFont( "font/MTCORSVA.TTF" )
M.vectra = native.newFont( "font/Antro_Vectra.otf" )

return M