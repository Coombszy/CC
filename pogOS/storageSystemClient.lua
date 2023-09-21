-- Server for the storage system
-----------------------------------------------------------

-- Imports
-----------------------------------------------------------
local Utils = require("lib/utils")
local Storage = require("lib/storage")
local ConfigManager = require("lib/configManager") -- Legacy

-- Shared
-----------------------------------------------------------
local version = "0.1"
local config = nil
local modem = nil

-- Functions
-----------------------------------------------------------

-- Main
-----------------------------------------------------------

term.clear()
term.setCursorPos(1, 1)
print("Booting pogOS Storage Client v" .. version)

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
print("...hardware found")

-- Start configs
ConfigManager.setTargetConfig("/" ..
    fs.getDir(shell.getRunningProgram()) .. "/config/storageClient.conf")
config = ConfigManager.fetch()
if config == nil then
    print("Config not found! Fatal error")
    return
end
print("...configs loaded")

-- Log bootup progress
print("Initilization complete")
print("Starting server...")

-- Start server
config["SERVER_PORT"] = tonumber(config["SERVER_PORT"])
config["CLIENT_PORT"] = tonumber(config["CLIENT_PORT"])
modem.open(config["CLIENT_PORT"])
print("Client started!")

-- Main loop
-- modem.transmit(config["SERVER_PORT"], config["CLIENT_PORT"], { "DEBUG", "aaaa" })
-- modem.transmit(config["SERVER_PORT"], config["CLIENT_PORT"], { "QUERY", "dirt" })
-- modem.transmit(config["SERVER_PORT"], config["CLIENT_PORT"], { "RETRIEVE", { "dirt", 200 } })
modem.transmit(config["SERVER_PORT"], config["CLIENT_PORT"], { "STORE", {} })
