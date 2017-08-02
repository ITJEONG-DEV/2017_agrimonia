local json = require "json"

local M = {}

function M.saveData( data, num )
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

function M.loadData( num )
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