--[[ Programmer: Daniel Lopez
     SDK: Corona SDK
     Text Editor: Sublime Text 3
     Date Begun: June 17, 2016
]]


local mySound = {}


--mySound.blop = audio.loadSound("blop.mp3")


function mySound:playBlop()
	local blop = audio.loadSound("Resources/blop.mp3")

	audio.play(blop)
end

function mySound:playMusic()
	local music = audio.loadStream("Resources/music.mp3")

	audio.play(music, {channel = 1, loops = -1, fadein = 2000})


end

return mySound