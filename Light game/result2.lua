-----------------------------------------------------------------------------------------
--
-- result2.lua
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
local menu


-- 'onRelease' event listener for level3
local function onMenuRelease()

    -- go to level3.lua scene
    composer.gotoScene( "menu", "fade", 500 )

    return true	-- indicates successful touch
end

-- 'onRelease' event listener for level14
local function onReplayRelease()

    -- go to level4.lua scene
    composer.gotoScene( "level2", "fade", 500 )

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


    local scoreDisplay = display.newText(event.params.score, 100, 200, native.systemFont, 16)
    scoreDisplay.x = display.contentWidth*0.5
    scoreDisplay.y = display.contentHeight - 250



    local gameName = display.newText('Escape Light', 100, 200, native.systemFont, 16)
    gameName.x = display.contentWidth*0.5
    gameName.y = display.contentHeight - 300



    -- create a widget button (which will loads level1.lua on release)
    menu = widget.newButton{
        label="Return menu",
        labelColor = { default={255}, over={128} },
        default="img/home/button.png",
        over="img/home/button-over.png",
        width=154, height=40,
        onRelease = onMenuRelease	-- event listener function
    }
    menu.x = display.contentWidth*0.5
    menu.y = display.contentHeight - 200

    -- create a widget button (which will loads level1.lua on release)
    level4 = widget.newButton{
        label="Replay",
        labelColor = { default={255}, over={128} },
        default="img/home/button.png",
        over="img/home/button-over.png",
        width=154, height=40,
        onRelease = onReplayRelease	-- event listener function
    }
    level4.x = display.contentWidth*0.5
    level4.y = display.contentHeight - 150

    -- all display objects must be inserted into group
    sceneGroup:insert( background )
    sceneGroup:insert( titleLogo )
    sceneGroup:insert( gameName )
    sceneGroup:insert( scoreDisplay )
    sceneGroup:insert( level4 )
    sceneGroup:insert( menu )

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

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene


