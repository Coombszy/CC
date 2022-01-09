----------------------------------------------------------------
-- GLOBAL VARS

-- The operating system version
OS_VERSION = "v0.2"

DISTANCE_TO_DIG = 0
TO_KEEP = { "ancient", "ore", "diamond", "gem", "dust", "lapis", "crystal", "redstone", "shard", "eode", "rune", "coal", "emerald", "gold" }
TO_KEEP_FILLER = { "cobble", "netherrack" }

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
function queryRefuel()
    -- Does it have enough fuel, if not allow consumption
    if ((DISTANCE_TO_DIG * 2) >= turtle.getFuelLevel()) then
        print("INSUFFICIENT FUEL")
        print("CONSUME FUEL (Y/N): ")
        input = read()
        if (input == "Y") then
            refuel()
            if ((DISTANCE_TO_DIG * 2) >= turtle.getFuelLevel()) then
                queryRefuel()
            end
        else
            error("INSUFFICIENT FUEL")
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
    print("CURRENT FUEL: " .. turtle.getFuelLevel())
    print("DISTANCE TO DIG: ")
    DISTANCE_TO_DIG = tonumber(read())
    print("THIS WILL COST " .. (DISTANCE_TO_DIG * 2) .. " FUEL" )

    -- Get some fuel
    queryRefuel()

    -- Dig to players specified distance
    print("STARTING MINING")
    DISTANCE_TRAVELLED = 0
    while(DISTANCE_TRAVELLED < DISTANCE_TO_DIG) do
        digForward()
        turtle.forward()
        DISTANCE_TRAVELLED = DISTANCE_TRAVELLED + 1
        digDown()
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

-- Old mining code (straight line)
function digArea()

    -- WARNING
    print("PLEASE KEEP NETHERRACK IN SLOT 1") 

    -- Write system data and get distance to dig
    print("CURRENT FUEL: " .. turtle.getFuelLevel())
    print("DISTANCE TO DIG (LENGTH): ")
    DISTANCE_TO_DIG_X = tonumber(read())
    print("DISTANCE TO DIG (WIDTH): ")
    DISTANCE_TO_DIG_Y = tonumber(read())
    print("THIS WILL COST " .. (DISTANCE_TO_DIG_X * DISTANCE_TO_DIG_Y) .. " FUEL" )

    -- Get some fuel
    queryRefuel()

    -- Dig to players specified distance
    print("STARTING MINING")
    DISTANCE_TRAVELLED = 0
    while(DISTANCE_TRAVELLED < DISTANCE_TO_DIG_X) do
        digForward()
        turtle.forward()
        DISTANCE_TRAVELLED = DISTANCE_TRAVELLED + 1
        digDown()
        digUp()
        if((DISTANCE_TRAVELLED % 6) == 0) then
            cleanInv()
        end
    end

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
    print(" help    | Brings up this help menu.")
    print(" digline | Dig in a straight line.")
    print(" exit    | Exit to base OS.")
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
    elseif input == "digline" then digStraight()

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
