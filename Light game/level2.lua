-----------------------------------------------------------------------------------------
--
-- level2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local math = require( "math" )
local scene = composer.newScene()

display.setStatusBar(display.HiddenStatusBar)

local physics = require("physics")
physics.start()
physics.setDrawMode( 'normal' )
local physicsData = (require "collision-lvl2").physicsData(1.0)
local boule
local obstacle1

-- FUNCTION DRAG & DROP
local function startDrag( event )
	local t = event.target

	local phase = event.phase
	if "began" == phase then
		display.getCurrentStage():setFocus( t )
		t.isFocus = true

		-- Store initial position
		t.x0 = event.x - t.x
		t.y0 = event.y - t.y
		
		-- Make body type temporarily "kinematic" (to avoid gravitional forces)
		event.target.bodyType = "kinematic"
		
		-- Stop current motion, if any
		event.target:setLinearVelocity( 0, 0 )
		event.target.angularVelocity = 0

	elseif t.isFocus then
		if "moved" == phase then
			t.x = event.x - t.x0
			t.y = event.y - t.y0

		elseif "ended" == phase or "cancelled" == phase then
			display.getCurrentStage():setFocus( nil )
			t.isFocus = false
		end
	end
	-- Stop further propagation of touch event!
	return true
end


function onLocalCollision( self, event )
	if ( event.phase == "began" ) then
			gameOver()
			print("perdu")
			print(self.y)
		return true
	end
end


function gameOver() 
	--if event.phase == "will" then
	Runtime:removeEventListener("enterFrame", obstacle1)
		composer.removeScene("level2", "fade", 500)
		composer.gotoScene( "result2", "fade", 500 )
	--end
	return true	-- indicates successful touch
end


local vitesse = 10

function scrollObstacle(self,event)
	if math.fmod(self.y,8000) == 0 then
		vitesse = vitesse * 1.2
		print("blbl")
	end
	if self.y > 400 then 
		self.y = - 8000
	else
		self.y = self.y + vitesse
	end
end


function scene:create( event )
	local sceneGroup = self.view

	boule = display.newImage("img/level2/boule.png")
	boule.width = 50
	boule.height = 50
	boule.x = (display.contentWidth) * 0.5; boule.y = (display.contentHeight) * 0.9
	boule.myName = "boule"
	physics.addBody( boule, "static", physicsData:get("boule") )


	obstacle1 = display.newImage("img/level2/obstacle.png");
	obstacle1.anchorX = 0
	obstacle1.anchorY = 0
	obstacle1.width = display.contentWidth
	obstacle1.height = 8000

	obstacle1.myName = "obstacle"

	-- set the shape
	physics.addBody( obstacle1,physicsData:get("obstacle"))	

	obstacle1.x = 0
	obstacle1.y = -9500

	-- add scroll
	obstacle1.enterFrame = scrollObstacle
	Runtime:addEventListener("enterFrame", obstacle1)

	boule:addEventListener( "touch", startDrag )

	-- add collision handler
    obstacle1.collision = onLocalCollision
    obstacle1:addEventListener( "collision" , obstacle1)
    boule.collision = onLocalCollision
    boule:addEventListener( "collision" , boule)

end 


function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
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
	
	if obstacle1 then
		obstacle1:removeSelf()	-- widgets must be manually removed
		obstacle1 = nil
	end
	if boule then
		boule:removeSelf()	-- widgets must be manually removed
		boule = nil
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