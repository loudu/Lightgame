-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

display.setStatusBar(display.HiddenStatusBar)
local physics= require("physics")
physics.start()
physics.setDrawMode("normale")



halfW=display.contentWidth*0.5
halfH=display.contentHeight*0.5


motionx = 0;
speed =2;







local background=display.newImage("level3/background.png")

score=0 
scoreText = display.newText(score,halfW,10)

--local star=display.newImage("level3/star.png")
--physics.addBody(star,"dymanic")
--star.x= display.contentWidth/2
--star:scale(0.5,1)



local stickman=display.newImage("level3/stickman.png")
physics.addBody(stickman,"static",{ friction=1, bounce=1})
stickman.y = display.contentHeight-260
stickman:scale(1,1)


local leftWall = display.newRect(0, display.contentHeight/2, 1, display.contentHeight * 60)
physics.addBody( leftWall, "static", { friction=0.5, bounce=0.3 } )

local rightWall = display.newRect(display.contentWidth, display.contentHeight/2, 1, display.contentHeight * 99)
physics.addBody( rightWall, "static", { friction=0.5, bounce=0.3 } )



local floor = display.newImage("level3/plateforme.png",true)
floor.y = display.contentHeight - 600
physics.addBody(floor,"static")


local left = display.newImage ("level3/fleche2.png")
 left.x = 130; left.y = 550;
 left.rotation = 180;
-- Add right joystick button
 local right = display.newImage ("level3/fleche2.png")
 right.x = 200; right.y = 390;

-- When left arrow is touched, move character left
 function left:touch()
 motionx = -speed;
 end
 left:addEventListener("touch",left)
-- When right arrow is touched, move character right
 function right:touch()
 motionx = speed;
 end
 right:addEventListener("touch",right)

-- Move character
 local function moveguy (event)
 stickman.x = stickman.x + motionx;
 end
 Runtime:addEventListener("enterFrame", moveguy)

 local function stop (event)
 if event.phase =="ended" then
 motionx = 0;
 end
 end
 Runtime:addEventListener("touch", stop )


local spawnTimer
local spawnedObjects = {}

local spawnParams = {
    xMin = 50,
    xMax = 750,
    yMin = 0,
    yMax = 1100,
    spawnTime = 100,
    spawnOnTimer = 12,
    spawnInitial = 4
}

-- Spawn an item
local function spawnItem( bounds )
 
    -- create sample item
    local item = display.newCircle( 0, 0, 20 )
    item:setFillColor( 1 )
	
    -- position item randomly within set bounds
    item.x = math.random( bounds.xMin, bounds.xMax )
    item.y = math.random( bounds.yMin, bounds.yMax )
 
    -- add item to spawnedObjects table for tracking purposes
    spawnedObjects[#spawnedObjects+1] = item
end



local function spawnController( start, spawnParams )
	 if ( spawnTimer and ( action == "start" or action == "stop" ) ) then
        timer.cancel( spawnTimer )
    end
    if ( action == "start" ) then
 
        -- gather/set spawning bounds
        local spawnBounds = {}
        spawnBounds.xMin = params.xMin or 0
        spawnBounds.xMax = params.xMax or display.contentWidth
        spawnBounds.yMin = params.yMin or 0
        spawnBounds.yMax = params.yMax or display.contentHeight
        -- gather/set other spawning params
        local spawnTime = params.spawnTime or 1000
        local spawnOnTimer = params.spawnOnTimer or 50
        local spawnInitial = params.spawnInitial or 0
      if ( spawnInitial > 0 ) then
            for n = 1,spawnInitial do
                spawnItem( spawnBounds )
            end
        end
         if ( spawnOnTimer > 0 ) then
            spawnTimer = timer.performWithDelay( spawnTime,
                function() spawnItem( spawnBounds ); end,
            spawnOnTimer )
        end
           elseif ( action == "pause" ) then
        timer.pause( spawnTimer )
 
    -- Resume spawning
    elseif ( action == "resume" ) then
        timer.resume( spawnTimer )
    end
end