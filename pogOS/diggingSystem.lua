----------------------------------------------------------------
-- GLOBAL VARS

-- The operating system version
OS_VERSION = "v0.34"

DISTANCE_TO_DIG = 0
TO_KEEP = { "ancient", "ore", "diamond", "gem", "dust", "lapis", "crystal", "redstone", "shard", "eode", "rune", "coal", "emerald", "gold", "raw", "iron" }
NEXT_SPOT_DELTA = 3

-----------------------------------------------------------------
------ FUNCTIONS

-- Does array contain item?
function hasValue(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

-- Consumes half avaliable fuel
function refuel()
    for i = 1, 16 do
        turtle.select(i)
        if turtle.refuel(0) then
            local halfStack = math.ceil(turtle.getItemCount(i)/2)
            turtle.refuel(halfStack)
        end
    end
    turtle.select(1)
end

-- Asks the user if it should consume fuel
function queryRefuel(fuelrequired)
    -- Does it have enough fuel, if not allow consumption
    if ((fuelrequired) >= turtle.getFuelLevel()) then
        print("INSUFFICIENT FUEL")
        print("CONSUME FUEL (Y/N): ")
        input = read()
        if (input == "Y") then
            refuel()
            if ((fuelrequired) >= turtle.getFuelLevel()) then
                queryRefuel(fuelrequired - turtle.getFuelLevel())
            end
        else
            error("INSUFFICIENT FUEL. REBOOT ME!")
        end
    end
end

-- Dig up till empty
function digUp()
    while(turtle.detectUp()) do
        turtle.digUp()
    end
end

-- Dig down till empty
function digDown()
    while(turtle.detectDown()) do
        turtle.digDown()
    end
end

-- Dig forward till empty
function digForward()
    while(turtle.detect()) do
        turtle.dig()
    end
end

-- Drop rubbish from inventory
function cleanInv()
    for i = 1, 16 do
        if(turtle.getItemCount(i) > 0) then
            keepMe = false
            for index,keyword in pairs(TO_KEEP) do
                if (not(string.find(turtle.getItemDetail(i)["name"], keyword) == nil)) then
                    keepMe = true
                end
            end
            if(not keepMe) then
                turtle.select(i)
                turtle.drop()
            end
        end
    end
    turtle.select(1)
end

-- Drop rubbish from inventory
function cleanInvFiller()
    for i = 1, 16 do
        if(turtle.getItemCount(i) > 0) then
            keepMe = false
            for index,keyword in pairs(TO_KEEP) do
                if (not(string.find(turtle.getItemDetail(i)["name"], keyword) == nil)) then
                    keepMe = true
                end
            end
            if(not keepMe) then
                turtle.select(i)
                turtle.drop()
            end
        end
    end
    turtle.select(1)
end

-- Old mining code (straight line)
function digStraight()

    -- Write system data and get distance to dig
    print("RUNNING LEGACY DIGLINE CODE!")
    print("CURRENT FUEL: " .. turtle.getFuelLevel())
    print("DISTANCE TO DIG: ")
    DISTANCE_TO_DIG = tonumber(read())
    print("THIS WILL COST " .. (DISTANCE_TO_DIG * 2) .. " FUEL" )

    -- Get some fuel
    queryRefuel(DISTANCE_TO_DIG * 2)

    -- Dig to players specified distance
    print("STARTING MINING")
    DISTANCE_TRAVELLED = 0
    while(DISTANCE_TRAVELLED < DISTANCE_TO_DIG) do
        digForward()
        turtle.forward()
        DISTANCE_TRAVELLED = DISTANCE_TRAVELLED + 1
        digDown()
        digUp()

        if((DISTANCE_TRAVELLED % 6) == 0) then
            cleanInv()
        end
    end

    -- Return Home
    print("RETURNING HOME")
    while(DISTANCE_TRAVELLED > 0) do
        turtle.back()
        DISTANCE_TRAVELLED = DISTANCE_TRAVELLED - 1
    end

    -- Go back to main screen
    mainScreen()

end

-- Old mining code UPDATED (With return loop)
function digLoop()

    -- Write system data and get distance to dig
    print("RUNNING LEGACY DIGLOOP CODE!")
    print("CURRENT FUEL: " .. turtle.getFuelLevel())
    print("DISTANCE TO DIG: ")
    DISTANCE_TO_DIG = tonumber(read())
    print("THIS WILL COST " .. ((DISTANCE_TO_DIG * 2) + 2) .. " FUEL" )

    -- Get some fuel
    queryRefuel((DISTANCE_TO_DIG * 2) + 2)

    -- Dig to players specified distance
    print("STARTING MINING")
    DISTANCE_TRAVELLED = 0
    while(DISTANCE_TRAVELLED < DISTANCE_TO_DIG) do
        digForward()
        turtle.forward()
        DISTANCE_TRAVELLED = DISTANCE_TRAVELLED + 1
        digDown()
        digUp()

        if((DISTANCE_TRAVELLED % 6) == 0) then
            cleanInv()
        end
    end

    -- Rotate at the end
    turtle.turnRight()
    digForward()
    turtle.forward()
    digDown()
    digUp()
    turtle.turnRight()

    -- Return Home
    print("RETURNING HOME")
    while(DISTANCE_TRAVELLED > 0) do
        
        digForward()
        turtle.forward()
        digDown()
        digUp()

        DISTANCE_TRAVELLED = DISTANCE_TRAVELLED - 1
    end

    -- Rotate to home
    turtle.turnRight()
    turtle.forward()
    turtle.turnRight()

    -- Go back to main screen
    mainScreen()

end

-- Moves over to next mining postion
function nextSpot(direction)

    turtle.back()

    -- turn to next spot direction
    if direction == "right" then
        turtle.turnRight()
    else -- left
        turtle.turnLeft()
    end

    for i=1, NEXT_SPOT_DELTA do
        digUp()
        digDown()
        digForward()
        turtle.forward()
    end

    -- turn to original direction
    if direction == "right" then
        turtle.turnLeft()
    else -- left
        turtle.turnRight()
    end

    -- get into position
    digForward()
    turtle.forward()

    -- Go back to main screen
    mainScreen()

end

-----------------------------------------------------------------
------ SCREENS 

-- Writes boot screen, version and logo (LOWER RES)
function startUpScreen() 
    term.clear()
    term.setCursorPos(1,1)
    print("-------------- POG OS (Digging) " .. OS_VERSION)
    print("")
    print("  (((((((       (((((")
    print("((((((((((((((((((((((")
    print("((((     @@((((     @@")
    print("((((((((((((((((((((((")
    print("##((##################")
    print("##((##################")
    print("##((((((((((((((((((")
    print("")
    print("type ! or help for command help.")
end

-- Write the help screen
function helpScreen()
    print("")
    print("All commands and descriptions.")
    print("")
    print(" ! | help")
    print("   | Brings up this help menu.")
    print(" - | digline")
    print("   | Dig in a straight line.")
    print(" o | digloop")
    print("   | Dig in a straight loop.")
    print(" > | moveright")
    print("   | Move right to next digging spot (will break blocks).")
    print(" < | moveleft")
    print("   | Move left to next digging spot (will break blocks).")
    print(" / | refuelhalf")
    print("   | Consume half of avaliable fuel.")
    print(" ^ | exit")
    print("   | Exit to base OS.")
    print("")

    mainScreen()
end

-- Handle normal user input
function mainScreen()

    -- Write terminal characters
    term.write("> ")

    -- Get user inputs
    local input = string.lower(read())

    -- Help
    if input == "!" or input == "help" then helpScreen()

    -- Dig straight line
    elseif input == "-" or input == "digline" then digStraight()

    -- Dig straight loop
    elseif input == "o" or input == "digloop" then digLoop()

    -- Move to new spot right
    elseif input == ">" or input == "moveright" then nextSpot("right")

    -- Move to new spot right
    elseif input == "<" or input == "moveleft" then nextSpot("left")

    -- Consume half of fuel
    elseif input == "/" or input == "refuelhalf" then refuel() mainScreen()

    -- Exit
    elseif input == "^" or input == "exit" then print("Shutting down :(") return

    -- Else, Try help?
    else print("Unknown command, try 'help' or '!'") mainScreen() end
end

-- 

-----------------------------------------------------------------
------ MAIN 

-- Render start screen
startUpScreen()

-- Start main screen
mainScreen()
