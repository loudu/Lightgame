-----------------------------------------------------------------------------------------
--
-- level2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

display.setStatusBar(display.HiddenStatusBar)

local physics = require("physics")
physics.start()

local physicsData = (require "collision-lvl2").physicsData(1.0)


local boule = display.newImage("img/level2/boule.png")
boule.width = 100
boule.height = 100
boule.x = (display.contentWidth) * 0.5; boule.y = (display.contentHeight) * 0.9
boule.myName = "boule"
physics.addBody( boule, "static", physicsData:get("boule") )

function scrollObstacle(self,event)
	self.y = self.y + 3
end

function newObstacle()
-----------------
	-- Erreur de nom : light-game-menu = obstacle-1
	-----------------
	local name = { "light-game-menu" ,"obstacle-2", "obstacle-3" }
	
	local name = names[math.random(#names)];
	
	obstacle = display.newImage("img/level2/"..name..".png");

	obstacle.width = 200
	obstacle.height = display.contentHeight
	obstacle.x = (display.contentWidth) * 0.3
	obstacle.y = 0
	
	-- remember object's type
	obstacle.myName = name	
	
	-- set the shape
	physics.addBody( obstacle, physicsData:get(name))	
	
	-- random start location
	obstacle.x = 60 + math.random( 160 )
	obstacle.y = -100
	
	-- add collision handler
    obstacle.collision = onLocalCollision
    obstacle:addEventListener( "collision", obj )
	
	obstacle.enterFrame = scrollObstacle
	Runtime:addEventListener("enterFrame", obstacle)
end

local function onLocalCollision( self, event )
    
    -- retrieve fixture names from physics data
    local selfFixtureId = physicsData:getFixtureId(self.myName, event.selfElement)
    local otherFixtureId = physicsData:getFixtureId(event.other.myName, event.otherElement)
    
    -- print collision information
    print( 
        self.myName .. ":" .. selfFixtureId ..
        " collision "..event.phase.." with " .. 
        event.other.myName .. ":" .. otherFixtureId
        )
end






---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene