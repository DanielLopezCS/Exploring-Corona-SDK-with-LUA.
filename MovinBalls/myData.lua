--[[ Programmer: Daniel Lopez
     SDK: Corona SDK
     Text Editor: Sublime Text 3
     Date Begun: June 17, 2016
]]



-- the data center for information that is not meant to be stored for more than one app session

local myData = {}
myData.var1 = 0
myData.var2 = 0
myData.var3 = 0
myData.tempScore = 0
myData.maxFace = 9
myData.highestCombo = 0
myData.TRANSITION_TIME_SCENE = 500

myData.latestScore = 0
myData.timesPlayed = 0


--Incase Need To Change Menu BackGround Color
myData.menuBackGroundColorOne = 1
myData.menuBackGroundColorTwo = 1
myData.menuBackGroundColorThree = 1
--Incase Need To Change Game BackGround Color
myData.gameBackGroundColorOne = 0
myData.gameBackGroundColorTwo = 0
myData.gameBackGroundColorThree = 0
--Incase Need To Change HealthBar Color
myData.healthBarColorOne = 0
myData.healthBarColorTwo = 0
myData.healthBarColorThree = 1




return myData