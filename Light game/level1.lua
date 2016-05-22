-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()

display.setDefault( "background", 0, 0, 0 )


local physics = require("physics")
physics.start()

-- needed var
local halfX = display.contentWidth *0.5
local halfY = display.contentHeight *0.5

local xMax = display.contentWidth
local yMax = display.contentHeight

local object =0
count = 0



	local scoreNumber = display.newText(count, halfX, 30, native.systemFont, 50)
	scoreNumber:setFillColor( 1, 1, 1 )


	-- win zone objects
	myCircle = display.newCircle( 200, 200, 50 )
	myCircle:setFillColor( 0.2,0.3,0.7)
	myCircle.x = (display.contentWidth) * 0
	myCircle.y = (display.contentHeight) * 0
	myCircle.name = "blue"


	myTriangle = display.newCircle( 200, 200, 50)
	myTriangle:setFillColor( 0.5, 0.1,0.2 )
	myTriangle.x = (display.contentWidth) * 1
	myTriangle.y = (display.contentHeight) * 0
	myTriangle.name = "red"


	mySquare = display.newCircle( 200, 200, 50 )
	mySquare:setFillColor( 0.8, 0.1,0.7 )
	mySquare.x = (display.contentWidth) * 0
	mySquare.y = (display.contentHeight) * 1
	mySquare.name = "green"


	myCross = display.newCircle( 200, 200, 50 )
	myCross:setFillColor( 0.2, 0.9,0.5 )
	myCross.x = (display.contentWidth) * 1
	myCross.y = (display.contentHeight) * 1
	myCross.name = "pink"



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
		--event.target:setLinearVelocity( 0, 0 )
		--event.target.angularVelocity = 0

	elseif t.isFocus then
		if "moved" == phase then
			t.x = event.x - t.x0
			t.y = event.y - t.y0
				
		elseif "ended" == phase or "cancelled" == phase then
			display.getCurrentStage():setFocus( nil )
			t.isFocus = false
			print(t.x, t.y)
			
			if ( (t.x < 30 and t.y < 30) or (t.x > 300 and t.y < 30) or (t.x < 30 and t.y > 450) or (t.x > 300 and t.y > 450)  ) then 
				verificationCouleur()
			end
		end
	end
	-- Stop further propagation of touch event!
	return true
end




function newforme()	
	rand = math.random( 100 )
	object = object + 1
	print(object)
	
if (object == 5) then 
	gameOver()
end
	
	if (rand < 25) then
		myObject = display.newCircle( 200, 200, 50 )
		myObject:setFillColor( 0.2,0.3,0.7)
		myObject.x = halfX + math.random(50)
		myObject.y = halfY + math.random(50)
		myObject.name = "blue"
		
	elseif (rand > 25 and rand < 50) then
		myObject = display.newCircle( 200, 200, 50)
		myObject:setFillColor( 0.5, 0.1,0.2 )
		myObject.x = halfX + math.random(50)
		myObject.y = halfY + math.random(50)
		myObject.name = "red"
		
	elseif (rand > 50 and rand < 75) then
		myObject = display.newCircle( 200, 200, 50 )
		myObject:setFillColor( 0.8, 0.1,0.7 )
		myObject.x = halfX + math.random(50)
		myObject.y = halfY + math.random(50)		
		myObject.name = "green"
	
	else
		myObject = display.newCircle( 200, 200, 50 )
		myObject:setFillColor( 0.2, 0.9,0.5  )		
		myObject.x = halfX + math.random(50)
		myObject.y = halfY + math.random(50)
		myObject.name = "pink"
		
	end	
	-- make 'myObject' listen for touch events
	myObject:addEventListener( "touch", startDrag )
	
end

newForme = timer.performWithDelay( 1000, newforme, 100 )

function verificationCouleur () 
		if (myObject.name == "blue" or myObject.name == "red" or myObject.name == "green" or myObject.name == "pink") then
			myObject:removeSelf()
		 	updateScore()
		object = object - 1
		else 
			gameOver()
		end
end
	
function updateScore()
	count = count + 10
	scoreNumber.text = count
end


function gameOver() 
	
	timer.pause( newForme )
	
	local options = {
		effect = "fade",
		time = 300,
		params = {
			score = count,
			gameName = "Escape Light"
		}
	}
	count = 0
	
	--if event.phase == "will" then
		composer.removeScene("level1", true)
		myObject:removeSelf()
	myObject:removeSelf()
	myObject:removeSelf()
	myObject:removeSelf()
	myObject:removeSelf()
		myCircle:removeSelf()
		myTriangle:removeSelf()
		myCross:removeSelf()
		mySquare:removeSelf()
		composer.loadScene( "result1", options )
		composer.gotoScene( "result1", options )
	--end
	return true	-- indicates successful touch
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.

end



return scene
