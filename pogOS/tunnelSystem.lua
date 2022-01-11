-- IMPORTS
----------------------------------------------------------------
local utils = require("lib/utils")
local t = require("lib/turtle")
local tunnelConfigs = require("lib/configManager")

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
WAIT_DURATION = null

-----------------------------------------------------------------
------ FUNCTIONS

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

-- Gets defaults and wraps modem for wireless comms
function bootup()

    -- Get modem
    MODEM = peripheral.find("modem") or error("Failed to load modem! Add one and reboot!", 0)

    -- Load configs
    PATH = "/"..fs.getDir( shell.getRunningProgram() ).."/"
    tunnelConfigs.setTargetConfig(PATH .. "config/tunnel.conf")

    S_CHANNEL = tonumber(tunnelConfigs.fetch()["SEND_CHANNEL"])
    R_CHANNEL = tonumber(tunnelConfigs.fetch()["RECEIVE_CHANNEL"])
    DELIMITER = tunnelConfigs.fetch()["CONTENT_DELIMITER"]
    WAIT_DURATION = tonumber(tunnelConfigs.fetch()["WAIT_DURATION"])

end

-- Run os as a node (digger)
function runNode()

    print("Node started! Waiting for data...")

    -- Start listening on configured channel
    MODEM.open(R_CHANNEL)

    -- Define vars
    local event, side, channel, replyChannel, message, distance

    while(RUNNING) do

        -- Receive message
        event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")

        -- Handle message
        ingest(message)

    end

    -- Soft restart!
    bootup()
    startUpScreen()
    mainScreen()
end

-- Run os as a host (player pusher)
function runHost()

    print("How far to dig?")
    term.write("> ")

    -- Get user inputs
    local distance = tonumber(read())

    print("What pattern? (1/3Y)")
    term.write("> ")

    -- Get user inputs
    local pattern = read()

    print("Enable player push? (Y/N)")
    term.write("> ")

    -- Get user inputs
    local push = string.lower(read())

    for i=1, distance do

        print("Sending Command: ")
        MODEM.transmit(R_CHANNEL, S_CHANNEL, "DIG".. DELIMITER .. pattern)

        sleep(WAIT_DURATION)

        if push == "y" then
            t.moveForward(1)
        end
    end

end

-- Ingest action
function ingest(content)

    command = utils.splitString(content, DELIMITER)[1]
    data = utils.splitString(content, DELIMITER)[2]

    if command == "PING" then

        response = "PING_RECEIVED"

        print("R:PING S:" .. response)
        MODEM.transmit(S_CHANNEL, R_CHANNEL, response)
        return response

    -- DIG with pattern
    elseif command == "DIG" then

        if data == "3Y" then
            print("R:" .. command .. "/" .. data)
            t.digForward()
            t.moveForward(1)
            t.digUp()
            t.digDown()
        else
            print("R:" .. command .. "/" .. data)
            t.digForward()
            t.moveForward(1)
        end

    -- STOP the loop
    elseif command == "STOP" then
        RUNNING = false

    -- CATCH all others
    else
        print("R:" .. command .. " ?")
        return "UNKNOWN_COMMAND"
    end

end

-----------------------------------------------------------------
------ SCREENS 

-- Writes boot screen, version and logo (LOWER RES)
function startUpScreen() 
    term.clear()
    term.setCursorPos(1,1)
    print("-------------- POG OS (Tunnel) " .. OS_VERSION)
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
    print(" h | start as host")
    print(" n | start as node")
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

    -- Host
    elseif input == "h" or input == "host" then runHost()

    -- Node
    elseif input == "n" or input == "node" then runNode()

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
