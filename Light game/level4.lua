-----------------------------------------------------------------------------------------
--
-- level4.lua
--
-----------------------------------------------------------------------------------------


local composer = require( "composer" )
local scene = composer.newScene()

local physics = require( "physics" )
physics.start()


local level1
local level2
local level3
local level4
local menu
local result4


local diskGfx = { "puck_yellow.png", "puck_green.png", "puck_red.png" }
local sky = display.newImage( "img/level4/bkg_clouds.png", 160, 195 )

-- Wall --
local leftWall = display.newRect(0, display.contentHeight/2, 1, display.contentHeight * 99)
physics.addBody( leftWall, "static", { friction=0.5, bounce=0.3 } )
local rightWall = display.newRect(display.contentWidth, display.contentHeight/2, 1, display.contentHeight * 99)
physics.addBody( rightWall, "static", { friction=0.5, bounce=0.3 } )

-- Ground --
local ground = display.newImage( "img/level4/ground.png", 160, 445 )
physics.addBody( ground, "static", { friction=0.5, bounce=0 } )


local crate = display.newImage( "img/level4/crate.png", 180, -50 )
crate.rotation = 5

physics.addBody( crate, "dynamic" )

count = 0

function spawnCrate()

		local crate = display.newImage( "img/level4/crate.png", 180, -50 )
		crate.rotation = 5

		physics.addBody( crate, "dynamic" )

		crate:addEventListener( "touch", bounceUp) -- click event available

	return true
end

function checkForAdd(count)
	if count == 30 then

		spawnCrate()

	elseif count == 90 then

		spawnCrate()
	elseif count == 120 then

		spawnCrate()
	end
end

function bounceUp( event )
	local t = event.target

	local lateral = 5 - math.random(0,10)

	t:applyForce( lateral, -6, t.x, t.y )

	count =  count + 1;

	checkForAdd(count)

	return true
end

local function gameOver()

	sky:removeSelf()
	crate:removeSelf()
	ground:removeSelf()

	local options = {
		effect = "fade",
		time = 300,
		params = {
			score = count,
			gameName = "Light Jump"
		}
	}

	count = 0
	-- go to menu.lua scene


	composer.removeScene( "result4", true)
	composer.loadScene( "result4", options )
	composer.gotoScene( "result4", options)

	return true	-- indicates successful touch
end


function onLocalCollision( self, event )


	if ( event.phase == "began" ) then

			gameOver()

		return true
	end
end


ground.collision = onLocalCollision
ground:addEventListener( "collision" )

crate:addEventListener( "touch", bounceUp)


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