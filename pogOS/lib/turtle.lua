-- Turtle functions
------------------------------------------------------------
local turt = {}
------------------------------------------------------------
-- CONSTANTS
DIG_WAIT = 0.05
------------------------------------------------------------
-- DIGGING
-- Dig up till empty
function turt.digUp()
    while(turtle.detectUp()) do
        turtle.digUp()
        sleep(DIG_WAIT)
    end
end

-- Dig down till empty
function turt.digDown()
    while(turtle.detectDown()) do
        turtle.digDown()
        sleep(DIG_WAIT)
    end
end

-- Dig forward till empty
function turt.digForward()
    while(turtle.detect()) do
        turtle.dig()
        sleep(DIG_WAIT)
    end
end
------------------------------------------------------------
-- MOVEMENT
-- move Forward x amount
function turt.moveForward(count)
    for i=0, count do
        turtle.forward()
    end
end

-- move Back x amount
function turt.moveBack(count)
    for i=0, count do
        turtle.back()
    end
end

-- move Up x amount
function turt.moveUp(count)
    for i=0, count do
        turtle.up()
    end
end
------------------------------------------------------------
-- GENERIC
-- Refuel 
function turt.refuel()
    for i = 1, 16 do
        turtle.select(i)
        if turtle.refuel(0) then
            turtle.refuel(turtle.getItemCount(i))
        end
    end
    turtle.select(1)
end
------------------------------------------------------------
return turt