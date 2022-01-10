-- IMPORTS
----------------------------------------------------------------
local utils = require("lib/utils")
local t = require("lib/turtle")
local tunnelConfigs = require("lib/configManager")

----------------------------------------------------------------
------ GLOBAL VARS

-- The operating system version
OS_VERSION = "v0.01"

-- Tunnel volatile system configs and states
HOST = false
RUNNING = true

MODEM = null
S_CHANNEL = null
R_CHANNEL = null
DELIMITER = null

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

end

-- Ingest action
function ingest(content)

    command = utils.splitString(content, DELIMITER)[1]
    data = utils.splitString(content, DELIMITER)[2]

    if command == "PING" then

        response = "PING_RECEIVED"

        print("R: PING S:" .. response)
        MODEM.transmit(S_CHANNEL, R_CHANNEL, response)
        return response
    else
        print("R: " .. command .. " ?")
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
    print(" / | refuel (DISABLED)")
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
