--[[ Programmer: Daniel Lopez
     SDK: Corona SDK
     Text Editor: Sublime Text 3
     Date Begun: June 17, 2016
]]


-- the main function of the project. begins the application by transitioning to the 'menu' scene

local composer = require ("composer")


display.setStatusBar(display.HiddenStatusBar)
composer.gotoScene( "menu", "fade", 400 )