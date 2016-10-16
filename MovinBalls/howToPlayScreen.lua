--[[ Programmer: Daniel Lopez
     SDK: Corona SDK
     Text Editor: Sublime Text 3
     Date Begun: June 17, 2016
]]


local composer = require( "composer" )
local data = require("myData")
local scene = composer.newScene()


local backButton = display.newImage("Resources/back.png", display.contentWidth*.8, display.contentHeight *.8)
local backGroup = display.newGroup()
local explainBall 

local explanationMessage = 
"When Beginning, One Ball Will Change Colors In A Few Seconds.\nKeep An Eye On The Ball And Pop It As Soon As You Can.\nA Few Moments After Popping The Ball It Will Re-Appear\nAt A Random Location  As The Same Color As The Rest Of The Balls.\nYou Must Stay Alert To Know Where It Spawned And Immediately Pop It. \n\n Good Luck." 
 
local explainText = display.newText(explanationMessage, display.contentWidth/2, display.contentHeight/2,"Resources/calibriz.ttf" , 35)
explainText:setFillColor(0,0,0)

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function createExplanation()
    print("CALLING CREATE EXPLANATION")
    explainBall = display.newImage("Resources/explain.png", display.contentWidth/2, display.contentHeight*.8)

    explainBall:toFront()
end

function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
end

function createBackButton ()

    backGroup:insert(backButton,true)
    backButton.x = display.contentWidth *.8
    backButton.y = display.contentHeight *.8
end

local backButtonListener = function(event)

    local group = event.target

    if "ended" == event.phase then

        composer.gotoScene("menu","fade", data.TRANSITION_TIME_SCREEN)
        backButton.isVisible = false

    return true

    end
end




-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        createExplanation()
        createBackButton()
        explainText.isVisible = true
        backButton.isVisbile = true
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

    end
end


-- hide()
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        explainText.isVisible = false
        explainBall.isVisible = false
        backButton.isVisible = false

    

    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
    end
end


-- destroy()
function scene:destroy( event )

    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view

end

backGroup:addEventListener("touch", backButtonListener)

-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
