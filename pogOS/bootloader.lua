-- IMPORTS
-----------------------------------------------------------------------
configManager = require("lib/configManager")


-- BOOT CONFIG
-----------------------------------------------------------------------
-- init configs
PATH = "/"..fs.getDir( shell.getRunningProgram() ).."/"
configManager.setTargetConfig(PATH .. "config/shared.conf")

BOOT_ITEM = tonumber(configManager.fetch()["AUTO_BOOT"])
AUTO_UPDATE = tonumber(configManager.fetch()["AUTO_UPDATE"])

-- WIPE
-----------------------------------------------------------------------
term.clear()
term.setCursorPos(1,1)

-- PATCHING 
-----------------------------------------------------------------------
if AUTO_UPDATE == 1 then
    print("PATCHING POG OS")
    shell.run(PATH .. "patcher.lua")

    print("PATCHING COMPLETE")
end

-- BOOT MENU(POG OS)
-----------------------------------------------------------------------
print("BOOTING POG OS")

if BOOT_ITEM == 1 then
    shell.run(PATH .. "storageSystem.lua")
elseif BOOT_ITEM == 2 then
    shell.run(PATH .. "diggingSystem.lua")
elseif BOOT_ITEM == 3 then
    shell.run(PATH .. "tunnelSystem.lua")
elseif BOOT_ITEM == 4 then
    shell.run(PATH .. "miningSystem.lua")
elseif BOOT_ITEM == 5 then
    shell.run(PATH .. "farmingSystem.lua")
end