local json = require "json"

local M = {}

local path = system.pathForFile( "data.txt", system.ResourceDirectory )


function M.saveData( data )
	local encoded = json.encode( data )

	local file, errorString = io.open( path, "w" )

	if not file then
		print("File error : ".. errorString )
	else
		file:write( encoded )

		io.close( file )
		print("Save data successful.")
	end
end

function M.loadData()
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