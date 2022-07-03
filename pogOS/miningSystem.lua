-- IMPORTS
----------------------------------------------------------------
local utils = require("lib/utils")
local t = require("lib/turtle")
local miningConfigs = require("lib/configManager")

----------------------------------------------------------------
------ GLOBAL VARS

-- The operating system version
OS_VERSION = "v0.01"

TO_KEEP = { "ancient", "ore", "diamond", "gem", "dust", "lapis", "crystal", "redstone", "shard", "eode", "rune", "coal", "emerald", "gold", "raw", "iron" }

-- Tunnel volatile system configs and states
RUNNING = true

MODEM = null
S_CHANNEL = null
R_CHANNEL = null
DELIMITER = null

-----------------------------------------------------------------
------ FUNCTIONS

-- Drop rubbish from inventory
function cleanInv()
    for i = 2, 16 do
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

-- Gets defaults and wraps modem for wireless comms
function bootup()

    -- Get modem
    MODEM = peripheral.find("modem") or error("Failed to load modem! Add one and reboot!", 0)

    -- Load configs
    PATH = "/"..fs.getDir( shell.getRunningProgram() ).."/"
    miningConfigs.setTargetConfig(PATH .. "config/mining.conf")

    S_CHANNEL = tonumber(miningConfigs.fetch()["SEND_CHANNEL"])
    R_CHANNEL = tonumber(miningConfigs.fetch()["RECEIVE_CHANNEL"])
    DELIMITER = miningConfigs.fetch()["CONTENT_DELIMITER"]

end

-----------------------------------------------------------------
------ SCREENS 

-- Writes boot screen, version and logo (LOWER RES)
function startUpScreen() 
    term.clear()
    term.setCursorPos(1,1)
    print("-------------- POG OS (Mining) " .. OS_VERSION)
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
    print(" / | refuel")
    print(" ^ | exit")
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

    -- Refuel
    elseif input == "/" or input == "refuel" then t.refuel() mainScreen()

    -- Exit
    elseif input == "^" or input == "exit" then print("Shutting down :(") return

    -- Else, Try help?
    else print("Unknown command, try 'help' or '!'") mainScreen() end
end

-----------------------------------------------------------------
------ MAIN 

-- Set configs and load data
bootup()

-- Render start screen
startUpScreen()

-- Start main screen
mainScreen()
