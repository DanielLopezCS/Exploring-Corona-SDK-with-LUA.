
local scoreScreen = {}

local ads = require("ads")

local data = require("myData")

scoreScreen.backGroup = display.newGroup()

scoreScreen.displayText = display.newText(0 , display.contentWidth/2, 0, "Resources/calibriz.ttf", 75)
scoreScreen.displayText:setFillColor(0,0,0)

scoreScreen.comboText = display.newText(0,display.contentWidth/2, 0, "Resources/calibriz.ttf", 45)
scoreScreen.comboText:setFillColor(0,0,1)


--local ballClone = {}
scoreScreen.maxWidth = display.contentWidth
scoreScreen.maxHeight = display.contentHeight

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

scoreScreen.scoreBackGround = display.newImage("Resources/scoreScreen.png", display.contentCenterX, display.contentCenterY)
scoreScreen.scoreBackGround:scale(scoreScreen.maxWidth, scoreScreen.maxHeight)
-- create()
    -- Code here runs when the scene is first created but has not yet appeared on screen

function scoreScreen:controlScreens()
     
		

	scoreScreen.displayText.text = "Popped: " .. data.latestScore
	scoreScreen.displayText:toFront()
  scoreScreen.comboText:toFront()
  scoreScreen.comboText.text = "Highest Combo X " ..data.highestCombo





end
-- show()  
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        --createBalls()

function scoreScreen:gonnaMake()
    
  scoreScreen.controlScreens()
  scoreScreen.scoreBackGround.isVisible = true 
  scoreScreen.displayText.isVisible = true
  scoreScreen.comboText.isVisible = true
  scoreScreen.comboText:toFront()

  transition.to(scoreScreen.displayText,{time= 1000, x = scoreScreen.maxWidth/2, y = scoreScreen.maxHeight/2})
  transition.to(scoreScreen.comboText,{time= 1000, x = scoreScreen.maxWidth/2, y = scoreScreen.maxHeight * .8})

end

-- hide()

   
        -- Code here runs when the scene is on screen (but is about to go off screen)
      
function scoreScreen:hidingScore()
     
      scoreScreen.displayText.isVisible = false
      scoreScreen.comboText.isVisible = false
      scoreScreen.scoreBackGround.isVisible = false
      

end

return scoreScreen

