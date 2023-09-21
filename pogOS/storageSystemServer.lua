---@diagnostic disable: undefined-field, need-check-nil
-- Server for the storage system
-----------------------------------------------------------

-- Imports
-----------------------------------------------------------
local Utils = require("lib/utils")
local Storage = require("lib/storage")
local ConfigManager = require("lib/configManager") -- Legacy

-- Shared
-----------------------------------------------------------
local version = "1.0"
local config = nil
local modem = nil
local storage = nil

-- Functions
-----------------------------------------------------------

-- Handles a message from a client
-- @param {} event - The event that triggered this function
-- @param {} side - The side the message was sent from
-- @param {} freq - The frequency the message was sent on
-- @param {} replyFreq - The frequency to reply on
-- @param {} msg - The message
-- @param {} dist - The distance the message was sent from
function handleMessage(event, side, freq, replyFreq, msg, dist)
    -- Split message into parts
    local type = msg[1]
    local data = msg[2]

    -- Handle different message types
    if type == "DEBUG" then
        print(">DEBUG: " .. tostring(data))
    elseif type == "QUERY" then
        print(">QUERY (" .. replyFreq .. "): " .. data)
        storage:updateData()
        local found, matches = storage:searchItem(data, false)
        if found then
            modem.transmit(replyFreq, freq, { "FOUND", matches })
        else
            modem.transmit(replyFreq, freq, { "NOT FOUND", {} })
        end
    elseif type == "RETRIEVE" then
        print(">RETRIEVE (" .. replyFreq .. "): " .. data[1] .. "x" .. data[2])
        local item_name = data[1]
        local item_count = tonumber(data[2])
        storage:updateData()
        local found, matches = storage:searchItem(item_name, true)
        if found then
            local avaliable = 0
            for _, item in ipairs(matches) do
                avaliable = avaliable + item[2]
            end
            if avaliable < item_count then
                modem.transmit(replyFreq, freq, { "NOT ENOUGH", avaliable })
                storage:retrieveItem(item_name, avaliable)
                return
            else
                modem.transmit(replyFreq, freq, { "FOUND", item_count })
                storage:retrieveItem(item_name, item_count)
            end
        else
            modem.transmit(replyFreq, freq, { "NOT FOUND", 0 })
        end
    elseif type == "STORE" then
        print(">STORE (" .. replyFreq .. ")")
        local stored, failed = storage:storeAll()
        modem.transmit(replyFreq, freq, { "STORED", { stored, failed } })
    else
        print("UNKNOWN COMMAND")
        modem.transmit(replyFreq, freq, { "UNKNOWN COMMAND", {} })
    end
end

-- Main
-----------------------------------------------------------

term.clear()
term.setCursorPos(1, 1)
print("Booting pogOS Storage Server v" .. version)

-- Figure out which modem is the wireless one
for _, side in ipairs(rs.getSides()) do
    if peripheral.getType(side) == "modem" then
        modem = peripheral.wrap(side)
        if modem.isWireless() then
            break
        else
            modem = nil
        end
    end
end
if modem == nil then
    print("No wireless modem found! Fatal error")
    return
end

-- Start configs
ConfigManager.setTargetConfig("/" ..
    fs.getDir(shell.getRunningProgram()) .. "/config/storageServer.conf")
config = ConfigManager.fetch()
if config == nil then
    print("Config not found! Fatal error")
    return
end
print("...configs loaded")

-- Check if io chest is connected
if not peripheral.isPresent(config["IO_CHEST"]) then
    print("IO chest not found ('" .. config["IO_CHEST"] .. "')! Fatal error")
    return
end
print("...hardware found")

-- Start storage system
storage = Storage(peripheral.wrap(config["IO_CHEST"]), Utils.splitString(config["IGNORE_LIST"], ","))
print("...storage system loaded")

-- Log bootup progress
print("Initilization complete")
print("Starting server...")

-- Start server
modem.open(tonumber(config["PORT"]))
print("Server started!")

-- Main loop
local event, side, freq, replyFreq, msg, dist

repeat
    event, side, freq, replyFreq, msg, dist = os.pullEvent("modem_message")
    handleMessage(event, side, freq, replyFreq, msg, dist)
until false
