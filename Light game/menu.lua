
-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "widget" library
local widget = require "widget"

--------------------------------------------

-- forward declarations and other locals
local level1
local level2
local level3
local level4
local result4


-- 'onRelease' event listener for level1
local function onlevel1Release()
	
	-- go to level1.lua scene
	composer.gotoScene( "level1", "fade", 500 )
	
	return true	-- indicates successful touch
end

-- 'onRelease' event listener for level2
local function onlevel2Release()
	
	-- go to level2.lua scene
	composer.gotoScene( "level2", "fade", 500 )
	
	return true	-- indicates successful touch
end

-- 'onRelease' event listener for level3
local function onlevel3Release()
	
	-- go to level3.lua scene
	composer.gotoScene( "level3", "fade", 500 )
	
	return true	-- indicates successful touch
end

-- 'onRelease' event listener for level14
local function onlevel4Release()
	
	-- go to level4.lua scene
	composer.removeScene("level4")
	composer.loadScene("level4")
	composer.gotoScene( "level4", "fade", 500 )
	
	return true	-- indicates successful touch
end


function scene:create( event )
	local sceneGroup = self.view

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	-- display a background image
	local background = display.newImageRect( "img/home/fong.jpg", display.contentWidth, display.contentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x, background.y = 0, 0
	
	-- create/position logo/title image on upper-half of the screen
	local titleLogo = display.newImageRect( "img/home/logo.png", 150, 138 )
	titleLogo.x = display.contentWidth * 0.5
	titleLogo.y = 75
	
	-- create a widget button (which will loads level1.lua on release)
	level1 = widget.newButton{
		label="Spotlight",
		labelColor = { default={255}, over={128} },
		default="img/home/button.png",
		over="img/home/button-over.png",
		width=154, height=40,
		onRelease = onlevel1Release	-- event listener function
	}
	level1.x = display.contentWidth*0.5
	level1.y = display.contentHeight - 300
	
	-- create a widget button (which will loads level1.lua on release)
	level2 = widget.newButton{
		label="Escape Light",
		labelColor = { default={255}, over={128} },
		default="img/home/button.png",
		over="img/home/button-over.png",
		width=154, height=40,
		onRelease = onlevel2Release	-- event listener function
	}
	level2.x = display.contentWidth*0.5
	level2.y = display.contentHeight - 250	
	
	-- create a widget button (which will loads level1.lua on release)
	level3 = widget.newButton{
		label="Light Dodge",
		labelColor = { default={255}, over={128} },
		default="img/home/button.png",
		over="img/home/button-over.png",
		width=154, height=40,
		onRelease = onlevel3Release	-- event listener function
	}
	level3.x = display.contentWidth*0.5
	level3.y = display.contentHeight - 200	
	
	-- create a widget button (which will loads level1.lua on release)
	level4 = widget.newButton{
		label="Light Jump",
		labelColor = { default={255}, over={128} },
		default="img/home/button.png",
		over="img/home/button-over.png",
		width=154, height=40,
		onRelease = onlevel4Release	-- event listener function
	}
	level4.x = display.contentWidth*0.5
	level4.y = display.contentHeight - 150		
	
	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert( titleLogo )
	sceneGroup:insert( level1 )
	sceneGroup:insert( level2 )
	sceneGroup:insert( level3 )
	sceneGroup:insert( level4 )
	
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	
	if level1 then
		level1:removeSelf()	-- widgets must be manually removed
		level1 = nil
	end
	if level2 then
		level1:removeSelf()	-- widgets must be manually removed
		level1 = nil
	end
	if level3 then
		level1:removeSelf()	-- widgets must be manually removed
		level1 = nil
	end
	if level4 then
		level1:removeSelf()	-- widgets must be manually removed
		level1 = nil
	end
	
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------


return scene

