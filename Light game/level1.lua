-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()

display.setDefault( "background", 1, 1, 1 )


-- needed var
local halfX = display.contentWidth *0.5
local halfY = display.contentHeight *0.5

local xMax = display.contentWidth
local yMax = display.contentHeight

local objectClear = false

local score = 0
local scoreNumber = display.newText(score, halfX, 30, native.systemFont, 50)
scoreNumber:setFillColor( 1, 0, 0 )





-- create objects
local myObject = display.newRect( 0, 0, 100, 100)
myObject.x = halfX
myObject.y = halfY
myObject:setFillColor( 0 )

	-- win zone objects
	local myCircle = display.newImage( "img/level1/circle_black.png" )
	local myTriangle = display.newImage("img/level1/triangle_black.png")
	local mySquare = display.newImage("img/level1/square_black.png")
	local myCross = display.newImage("img/level1/cross_black.png")
	-- position the win zone objects
	mySquare:translate( 50, 30 )
	myTriangle:translate(xMax - 50, 30)
	myCircle:translate( 50, yMax - 30)
	myCross:translate(xMax - 50, yMax - 30)
    --scale
    myCross:scale(0.2 , 0.2)
    myTriangle:scale(0.2 , 0.2)
    mySquare:scale(0.2 , 0.2)
    myCircle:scale(0.2 , 0.2)



-- create win zone
-- Coord to use for win condition
--[[
local myZoneTopLeft = display.newRect(50, 0, 100, 100)
myZoneTopLeft:setFillColor( 255 )

local myZoneTopRight = display.newRect(xMax - 50, 0, 100, 100)
myZoneTopRight:setFillColor( 255 )

local myZoneBtmLeft = display.newRect(50, yMax , 100, 100)
myZoneBtmLeft:setFillColor( 255 )

local myZoneBtmRight = display.newRect(xMax - 50, yMax , 100, 100)
myZoneBtmRight:setFillColor( 255 )
]]--

--[[ Timer test 
display.setStatusBar(display.HiddenStatusBar) _W = display.contentWidth _H = display.contentHeight number = 0
 
local txt_counter = display.newText( number, 0, 0, native.systemFont, 50 )
txt_counter.x = _W/2
txt_counter.y = _H/2
txt_counter:setTextColor( 255, 255, 255 )
function fn_counter()
number = number + 1
txt_counter.text = number
end
timer.performWithDelay(1000, fn_counter, 0)
]]--
--End timer test

local function updateScore()
score = score + 10
scoreNumber.text = score
objectClear = true
end


-- touch listener function
function myObject:touch( event )
    if event.phase == "began" then
	
        self.markX = self.x    -- store x location of object
        self.markY = self.y    -- store y location of object
	
    elseif event.phase == "moved" then
	
        local x = (event.x - event.xStart) + self.markX
        local y = (event.y - event.yStart) + self.markY
        myObject:setFillColor( 255, 0, 255 )
        
        self.x, self.y = x, y    -- move object based on calculations above


        -- game logique here ? 
        if self.x < 50 and self.y < 50 then
            myObject:removeSelf()
            updateScore()

            -- if The player have destructed the object we create a new one in ended section

        elseif objectClear == true then
            -- recreation of deleted object
            local myObject = display.newRect( 0, 0, 100, 100)
            myObject.x = halfX
            myObject.y = halfY
            myObject:setFillColor( 0 )


        end


        




    elseif event.phase == "ended" then
    	myObject:setFillColor( 0 )
    	self.x = halfX
    	self.y = halfY

    end
    
    return true
end

-- make 'myObject' listen for touch events
myObject:addEventListener( "touch", myObject )

return scene
