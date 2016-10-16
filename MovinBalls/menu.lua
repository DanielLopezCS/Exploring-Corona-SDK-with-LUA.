--[[ Programmer: Daniel Lopez
     SDK: Corona SDK
     Text Editor: Sublime Text 3
     Date Begun: June 17, 2016
]]


local composer = require ("composer")
local data = require("myData")
local saveWriter = require("saveWriter")
local ads = require("ads")
local mySound = require("mySound")



local scene = composer.newScene()

local menuBall = display.newImage("Resources/ball.png",display.contentCenterX, display.contentCenterY)

local maxWidth = display.contentWidth
local maxHeight = display.contentHeight

local halfWidth = maxWidth/2
local halfHeight = maxHeight/2


local maxHeight =  display.contentHeight
local maxWidth = display.contentWidth
local highscore 

local highScoreGroup
local group 
local howGroup

local go

local appID = "ca-app-pub-9583155003717900/5102947875"
local provider = "admob"
local interstitialID = "ca-app-pub-9583155003717900/5699560275"

local howButton 

local scales = {}
local TRANSITION_TIME_BALLS = 950
local DEFAULT_FACE = 9
local INTERSTITIAL_AD_RATE = 2
local TOP_START = maxHeight * .3
local lowWidth = 80
local lowHeight = 80

function createScales()
	for i = 1, 9, 1 do
		scales[i] = i * .1
	end

end

function showAd(adType)
local adX, adY = 0, display.contentHeight - display.screenOriginY
	ads.show( adType, { x=adX, y=adY } )

end




local highScoreListener = function(event)

	local group = event.target

	if "ended" == event.phase then

	mySound.playBlop()

	composer.gotoScene("highScoreScreen","fade", data.TRANSITION_TIME_SCENE)

	return true
	end
end

local howButtonListener = function(event)

	local group = event.target

	if "ended" == event.phase then

	mySound.playBlop()

	composer.gotoScene("howToPlayScreen","fade", data.TRANSITION_TIME_SCENE)

	return true
	end
end

local buttonListener = function(event)

	local group = event.target

	if "ended" == event.phase then

		mySound.playBlop()

		menuBall.isVisible = false
		data.maxFace = DEFAULT_FACE
		composer.gotoScene("game","fade", data.TRANSITION_TIME)
	
	return true

	end
end

function scene:create( event )
 
   local sceneGroup = self.view
		
		mySound.playMusic()

		createScales()
		bounceBalls()

		menuBall.x = halfWidth
		menuBall.y = halfHeight

   -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end
 
 function scene:destroy( event )
 
   local sceneGroup = self.view
 
   -- Called prior to the removal of scene's view ("sceneGroup").
   -- Insert code here to clean up the scene.
   -- Example: remove display objects, save state, etc.
end

function scene:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).
	  
	makeMenu()

	saveWriter.load()


	--[[data.var1 = saveWriter.getScoreOne()  
	data.var2 = saveWriter.getScoreTwo()
	data.var3 = saveWriter.getScoreThree()
	--]]

	data.highestCombo = 0
	
	if data.timesPlayed == INTERSTITIAL_AD_RATE then 
	
		ads.show( "interstitial", { appId=interstitialID } )
		
		data.timesPlayed = 0

		elseif data.timesPlayed ~= INTERSTITIAL_AD_RATE then 
			 showAd("banner")
    	end

   elseif ( phase == "did" ) then

   end

end

function makeMenu()


	highscore = 0

  
	group = display.newGroup()

	go = display.newImage("Resources/ready.png", display.contentCenterX, display.contentCenterY)

	group:insert(go,true)

	go.x = halfWidth
	go.y = TOP_START

	display.setDefault("background", data.menuBackGroundColorOne, data.menuBackGroundColorTwo, data.menuBackGroundColorThree)



	highscore = display.newImage("Resources/highscore.png", display.contentCenterX, display.contentCenterY)


	highScoreGroup = display.newGroup()
	highScoreGroup:insert(highscore,true)

	highscore.x = halfWidth
	highscore.y = maxHeight * scales[8]


	howButton = display.newImage("Resources/how.png", maxWidth * scales[8], maxHeight * scales[2])
	howGroup = display.newGroup()
	howGroup:insert(howButton,true)
	howButton.x = maxWidth * scales[8]
	howButton.y = maxHeight * scales[2]

	menuBall.isVisible = true

	composer.removeScene("game")
   
	group:addEventListener( "touch", buttonListener )
	highScoreGroup:addEventListener("touch", highScoreListener)
	howGroup:addEventListener("touch", howButtonListener)

 end

function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then

		--Removing Values
		go.isVisible = false
		highscore.isVisible = false
		howButton.isVisible = false


		go = 0
		highscore = 0
		howButton = 0
	
		ads.hide()


        -- Code here runs when the scene is on screen (but is about to go off screen)

    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
	
    end
end



function bounceBalls()

	transition.to(menuBall,{time=TRANSITION_TIME_BALLS, x=math.random(lowWidth,maxWidth), y=math.random(lowHeight,maxHeight), onComplete = bounceBalls})

end

local function adListener(event) 
	
	local message = event.response

		print("Ad Message: ", message)

	if event.isError then

		showAd("banner")

	end

end

ads.init(provider, appID, adListener )
ads.init(provider, interstitialID, adListener)

scene:addEventListener("create", scene)

scene:addEventListener("show", scene)


scene:addEventListener("hide", scene)


scene:addEventListener("destroy", scene)

return scene