--[[ Programmer: Daniel Lopez
     SDK: Corona SDK
     Text Editor: Sublime Text 3
     Date Begun: June 17, 2016
]]


local composer = require ("composer")
local data = require("myData")
local saveWriter = require("saveWriter")
local scene = composer.newScene()

local highScoreOne = saveWriter.getScore()


local backGroup = display.newGroup()
local backButton 


local maxWidth = display.contentWidth
local maxHeight = display.contentHeight


local musicName = "Lewis and Dekalb by Kevin Macleod"



local givingCredit = display.newText("Music: " .. musicName, display.contentWidth * .2, display.contentHeight* .2,"Resources/calibriz.ttf" ,25)

 givingCredit:setFillColor(0,0,0)


local highScoreText = display.newText("Loading High Score",
  display.contentWidth/2, display.contentHeight/2, "Resources/calibriz.ttf", 50)


 highScoreText:setFillColor(0,0,0)


function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
     backButton = display.newImage("Resources/back.png", display.contentCenterX, display.contentCenterY)
end


function update()
    local s = (maxWidth/4)/highScoreText.width

    highScoreText.text = "High Score:" .. saveWriter.getScore() 
    highScoreText:scale(s,s)
end

function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase


    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
   
    creatingBackButton()	

	highScoreText.isVisible = true

	givingCredit.isVisible = true 

    backButton.isVisible = true

    saveWriter.load()

    update()

    display.setDefault("background", 255, 255, 255)


    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen


    end
end

function scene:hide( event )
    
    local sceneGroup = self.view
    local phase = event.phase
    
    if ( phase == "will" ) then
	
		highScoreText.isVisible = false

		givingCredit.isVisible = false

        backButton.isVisible = false

    elseif ( phase == "did" ) then
    
    end
end


local backButtonListener = function(event)

    local group = event.target

    if "ended" == event.phase then

        composer.gotoScene("menu","fade", data.TRANSITION_TIME_SCENE)

    return true

    end
end

function creatingBackButton()
    
    backGroup:insert(backButton,true)

    backButton.x = maxWidth *.8

    backButton.y = maxHeight *.8

end

backGroup:addEventListener("touch", backButtonListener)

scene:addEventListener("create", scene)

scene:addEventListener("show", scene)


scene:addEventListener("hide", scene)


scene:addEventListener("destroy", scene)

return scene