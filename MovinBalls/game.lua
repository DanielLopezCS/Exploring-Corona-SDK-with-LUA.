


-- declaring requirements
local composer = require ("composer")
local scene = composer.newScene()
local saveWriter = require("saveWriter")
local data = require("myData")
local myScoreScreen = require("scoreScreen")
local mySound = require("mySound")
local ads = require("ads")

display.setStatusBar( display.HiddenStatusBar )

--declaring instance variables
local visibleCheck = false
local centerX = display.contentCenterX
local centerY = display.contentCenterY

local touchCount = 0

local maxHeight =  display.contentHeight
local maxWidth = display.contentWidth

local maxFace = data.maxFace

local gameOver = false
local currentCombo = false

local currentHealth = 1500
local startingHealth = 1500
local maximumHealth =  1750	
local healthBar

local healRate  =  250
local damageRate  = 12
local ballSpeed = 1025


local highScore = data.var1

local globalHighScoreOne = 0
local globalHighScoreTwo = 0
local globalHighScoreThree = 0

local comboCount = 0
local totalCombo = 0
local popCount = 0
local highestCombo = 0
local timer1, timer2, timer3, timer4

local healthBarScaleOne = 1
local healthBarScaleTwo = 3

local miliListenerTimer = 100
local secondListenerTimer = 1000
local minuteListenerTimer = 8000

local MAX_TIME = 100000000

local backGroup = display.newGroup()
local backButton 

local comboText = display.newText("Combo X ".. comboCount, display.contentWidth * .9, display.contentHeight * .2, "Resources/calibriz.ttf", 50)
comboText:setFillColor(0,0,1)

local countText = display.newText("Score: ".. touchCount, display.contentWidth * .2, display.contentHeight * .8, "Resources/calibriz.ttf", 50)
countText:setFillColor(1,1,1)


local resultText = display.newText("Result: ", display.contentWidth * .6, display.contentHeight * .2, "Resources/calibriz.ttf", 90)
resultText:setFillColor(0,1,0)

healthBar = display.newImage("Resources/healthBar.png", display.contentWidth/2, display.contentHeight*.1)
healthBar:scale(healthBarScaleOne, healthBarScaleTwo)
healthBar.width = currentHealth

local scales = {}

function initScales()
	for i = 1, 10, 1 do
		scales[i] = i * .1
	end
end


function expandHealth()

	if healRate <= healRate + ((healRate * scales[7])) then

		healRate = healRate  + (healRate * scales[2])

	end

	if damageRate <= (damageRate + (damageRate * scales[7])) then
		damageRate = damageRate  + (damageRate * scales[1])
	end

	if ballSpeed <= ballSpeed * scales[7] then
		ballSpeed = ballSpeed  * scales[9]

	end
end
-- health bar module
    --healthBar = display.newImage("healthBar.png", display.contentWidth/2, display.contentHeight*.2)
--function to play sound after hitting a circle

--function to increase health after hitting a circle
function heal()
	if currentHealth <= maximumHealth then

	currentHealth = currentHealth + healRate

	healthBar.width = currentHealth
	--[[whiteBar.width = startingHealth - currentHealth

	whiteBar.x = healthBar.x - (healthBar.width/2-whiteBar.width/2)
	--]]
	end
end

function beforeScoreScreen()

      if timer1 ~= nil then
      	timer.cancel(timer1)
      end
      if timer2 ~= nil then
      	timer.cancel(timer2)
      end

      if timer3 ~= nil then
      	timer.cancel(timer3)
      end

      healthBar.isVisible = false

      makeScoreScreen()
   


end

--function to decrease health and update the white bar
function takeDamage()
	
	currentHealth = currentHealth - damageRate
	
	--whiteBar.width = startingHealth - currentHealth

	--whiteBar.x = healthBar.x - (healthBar.width/2-whiteBar.width/2)
	healthBar.width = currentHealth

	if currentHealth <= 0 then 
		if gameOver == false then
			gameOver = true
			data.latestScore = popCount
			data.highestCombo = highestCombo
			beforeScoreScreen()
			createBackButton()
			scoreResults()
			countText:setFillColor(0,1,0)

--composer.gotoScene("menu","fromTop",300) 
		
		end
	end
end


--creating myhealthbar



-- a very simple sprite sheet for a 2 frame animation to give the player a notice of the starting circle
local sheetData = 
{
	width = 100,
	height = 100,
	numFrames = 2,
	sheetContentWidth = 200,
	sheetContentHeight = 100

}
local mySheet = graphics.newImageSheet("Resources/starting.png",sheetData)

local sequences_Starter = 
{	
	{
	name = "normal",
	start = 1,
	count = 2,
	time = 4000,
	loopCount = 1,
	loopDirection = "forward"
	}
}

local sheetDataBlop = 
{
	width = 154.25,
	height = 105,
	numFrames = 4,
	sheetContentWidth =  617,
	sheetContentHeight = 105

}
local mySheetBlop = graphics.newImageSheet("Resources/blopanim.png", sheetDataBlop)

local sequences_StarterBlop = 
{	
	{
	name = "normal",
	start = 1,
	count = 4,
	time = 200,
	loopCount = 1,
	loopDirection = "forward"
	}
}


local blopAnimation = display.newSprite( mySheetBlop, sequences_StarterBlop)

blopAnimation.isVisible = false

--creating the balls
local ballClone = {}

local scaleBall	

local timerID = 0
local allTime = 0
local myClock = 0
local comboClock = 0

local displayText = display.newText("Time:"..allTime, display.contentWidth *.2, 200, "Resources/calibriz.ttf", 50)



-- RESPOND TO TOUCH EVENTS 

local function playBlopAnimation()
	blopAnimation.x = ballClone[1].x
	blopAnimation.y = ballClone[1].y
	blopAnimation.isVisible = true
	blopAnimation:play()

end 

local function spriteListener(event)
	if (event.phase == "ended") then
		blopAnimation.isVisible = false
	end

end
	blopAnimation:addEventListener("sprite", spriteListener)
local buttonListener = function(event)


	local group = event.target

	if "ended" == event.phase then
		if gameOver ~= true then

			mySound.playBlop()
			playBlopAnimation()

			touchCount = touchCount + 1
			popCount = popCount + 1

			heal()
	
			countText.text =  "Score: "..touchCount

			comboCount = comboCount + 1

			totalCombo = totalCombo + 1

			currentCombo = true



			if allTime >= 3 then
				timerID = 0
				ballClone[1].isVisible = false

		
			end

		return true
		end
	end
end

local group 

local backButtonListener = function(event)

    local group = event.target

    if "ended" == event.phase then

    composer.gotoScene("menu","fade", data.TRANSITION_TIME_SCENE)
	backButton.isVisible = false

    return true

    end
end

function createBackButton ()

    backGroup:insert(backButton,true)
    backButton.x = maxWidth *.8
    backButton.isVisible = true
    backButton.y = maxHeight *.8

end

local function listener(event)

	if currentCombo == true then
		comboClock = comboClock + 1
	end

	print("CURRENTE DAMAGE RATE: " .. damageRate )

	if currentCombo == true then

	if comboClock >= 2 and comboCount < 1 then
		currentHealth = currentHealth + (totalCombo * 5)
		healthBar.width = currentHealth
		touchCount = math.round((touchCount + (totalCombo/3.0))*10)*.1
	if totalCombo > highestCombo then
		highestCombo = totalCombo
	end

	countText.text = "Score: " .. touchCount
	comboClock = 0
	comboCount = 0
	totalCombo = 0
	currentCombo = false
	comboText.isVisible = false
	

	elseif comboClock >= 2 and comboCount >= 1 then
		comboText.isVisible = true
		comboText.text = "Combo X ".. totalCombo
		comboCount = 0
		comboClock = 0	

	end
end

if gameOver ~= true then
	timerID = timerID + 1
	allTime = allTime + 1
	displayText.text = "Time:"..allTime


	if timerID == 1  then
		if visibleCheck == false then
			group:insert(ballClone[1],true)
			ballClone[1]:scale(scaleBall,scaleBall)
			moveBalls()
			visibleCheck = true
			
		end
	end

 if allTime == 3 then

	ballClone[1]:setFrame(2)

 end
	if timerID == 2 then

		if gameOver == false then
			ballClone[1].isVisible = true
			timerID = 0
		end

	end

end


if gameOver == true then
	timer.cancel(event.source)
end

end

function scoreResults()
	local myLatestScore = data.latestScore
	local resultOne = 15
	local resultTwo = 30
	local resultThree = 50
	local resultFour = 70

	local messageOne = "F. No Points."
	local messageTwo = "D+. Could Be Better."
	local messageThree = "C. Not Bad, Not Great."
	local messageFour = "B+. Impressive."
	local messageFive = "A+. Excellent. "
	local messageSix = "S~. Impossible..."

	if myLatestScore == 0 then
		resultText.text = messageOne 

	elseif myLatestScore > 0 and myLatestScore <= resultOne then
		resultText.text = messageTwo

	elseif myLatestScore > resultOne and myLatestScore <= resultTwo then
		resultText.text = messageThree
	
	elseif myLatestScore > resultTwo and myLatestScore <= resultThree then

		resultText.text = messageFour

	elseif myLatestScore > resultThree and myLatestScore <= resultFour then
		resultText.text = messageFive

	elseif myLatestScore > resultFour then
		resultText.text = messageSix

	end 

	resultText:toFront()
	resultText.isVisible = true

end

local function minuteListener(event)
	if gameOver ~= true then
		expandHealth()
	end
end
	
local function healthBarListener(event)
		takeDamage()
	if gameOver == true then
		timer.cancel(event.source)
	end
end

function moveBalls()




	if gameOver ~= true then
-- 950
		transition.to(ballClone[1],{time=ballSpeed, x=math.random(80,maxWidth), y=math.random(60,maxHeight), onComplete = moveBalls})
	end


	for i = 2, maxFace, 1 do

		transition.to(ballClone[i],{time=ballSpeed, x=math.random(80,maxWidth), y=math.random(60,maxHeight)})

	end

	end

function scene:hide( event )

   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
      -- Called when the scene is on screen (but is about to go off screen).
      -- Insert code here to "pause" the scene.
	 
	  
    comboText.isVisible = false
	if touchCount >=  data.var1 then
		data.var1 = touchCount
		if touchCount > saveWriter.getScore() then
				saveWriter.set(data.var1)
				saveWriter.save()
		end

	end
	 
	for i = 1, maxFace, 1 do
		ballClone[i].isVisible = false
	end
	
	displayText.isVisible = false
	countText.isVisible = false
	healthBar.isVisible = false
	backButton.isVisible = false
	resultText.isVisible = false

	myScoreScreen.hidingScore()
 
   elseif ( phase == "did" ) then
      backButton.isVisible = false

      if timer1 ~= nil then
      	timer.cancel(timer1)
      end
      if timer2 ~= nil then
      	timer.cancel(timer2)
      end

      if timer3 ~= nil then
      	timer.cancel(timer3)
      end

    countText.isVisible = false
   end
end
 
function makeScoreScreen()
	myScoreScreen.gonnaMake()

end

function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase
	
	    display.setDefault("background", data.gameBackGroundColorOne, data.gameBackGroundColorTwo, data.gameBackGroundColorThree)
		
		myScoreScreen.hidingScore()
		backButton.isVisible = false

    if ( phase == "will" ) then

		print("MEMORY: " .. collectgarbage("count"))

		comboText.isVisible = false
		resultText.isVisible = false

	 for i = 1, maxFace, 1 do
		ballClone[i].isVisible = true

		end
		displayText.isVisible = true
		countText.isVisible = true
		healthBar.isVisible = true

		--Re-Initializing Variables
		allTime = 0
		timerID = 0
		touchCount = 0
		myClock = 0
		gameOver = false
		healRate  = 250
		damageRate  = 12
		ballSpeed = 1025
	
	
    elseif ( phase == "did" ) then
		data.timesPlayed = data.timesPlayed + 1
		ads.hide()

		timer1 = timer.performWithDelay(secondListenerTimer,listener, MAX_TIME)
    	timer2 = timer.performWithDelay(miliListenerTimer,healthBarListener, MAX_TIME )
   		timer3 = timer.performWithDelay(minuteListenerTimer,minuteListener, MAX_TIME)

    	currentHealth = 1500
    end
end

function scene:create( event )
 
   local sceneGroup = self.view
   createGame()	
   initScales()

end

function createGame()

	backButton = display.newImage("Resources/back.png",maxWidth*.8, maxHeight*.8)
	ballClone[1] = display.newSprite(mySheet,sequences_Starter)
	ballClone[1].x = display.contentWidth/2
	ballClone[1].y = display.contentHeight/2

	for i = 2, maxFace, 1 do
		ballClone[i] = display.newImage("Resources/ball.png",display.contentCenterX, display.contentCenterY)
		ballClone[i].x = maxWidth/2
		ballClone[i].y = maxHeight/2
	end

scaleBall = (display.contentWidth/8)/ballClone[4].width

for i = 1, maxFace,1 do
	ballClone[i]:scale(scaleBall,scaleBall) 
end

group = display.newGroup()

displayText:setFillColor(1,1,1)
displayText:scale(scaleBall,scaleBall)

backGroup:addEventListener("touch", backButtonListener)
group:addEventListener( "touch", buttonListener )

end

function scene:destroy( event )
   local sceneGroup = self.view
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene


		