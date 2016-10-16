--[[ Programmer: Daniel Lopez
     SDK: Corona SDK
     Text Editor: Sublime Text 3
     Date Begun: June 17, 2016
]]


local saveWriter = {}


--HighScore Variables
saveWriter.scoreOne = 0

saveWriter.filename = "savedScores.txt"



--set functions
function saveWriter.set(value)

	saveWriter.scoreOne = value
	
end

--get functions
function saveWriter.getScore()

	return saveWriter.scoreOne

end





--save highscore one
function saveWriter.save()

local path = system.pathForFile( saveWriter.filename, system.DocumentsDirectory )
   local file = io.open(path, "w")
   if ( file ) then
      local contents = tostring(saveWriter.scoreOne)

      file:write(contents)
     
	  io.close( file )

      

   else 
      print( "Error for file ", saveWriter.filename, "." )
     
   end

end

--save highscore two



--load highscore one
function saveWriter.load()
   local path = system.pathForFile( saveWriter.filename, system.DocumentsDirectory )
   local contents = ""
   local file = io.open( path, "r" )
   if ( file ) then
   
      local contents = file:read( "*a" )

      

      saveWriter.scoreOne = tonumber(contents);

      io.close( file )

   else
      print( "Error for file ", saveWriter.filename, "." )
   end
end

--load high score two

return saveWriter