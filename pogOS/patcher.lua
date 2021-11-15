-- IMPORTS
-----------------------------------------------------------------------
local configManager = require("lib/configManager")
local configManagerShared = require("lib/configManager")

local utils = require("lib/utils")

-- BOOT CONFIG
-----------------------------------------------------------------------
-- init configs
PATH = "/"..fs.getDir( shell.getRunningProgram() ).."/"

configManager.setTargetConfig(PATH .. "config/patcher.conf")
REPO = configManager.fetch()["REPO"]
UPDATE_FILES = configManager.fetch()["UPDATE_FILES"]
FILE_LIST_DELIMITER = configManager.fetch()["FILE_LIST_DELIMITER"]

configManagerShared.setTargetConfig(PATH .. "config/shared.conf")
POGOS_HOME = configManagerShared.fetch()["HOME"]

-- MAIN
-----------------------------------------------------------------------

local targetFiles = utils.splitString(UPDATE_FILES, FILE_LIST_DELIMITER)

-- For each file download
for i = 1, table.getn(targetFiles) do

    print("")
    print("Patching file: "..targetFiles[i])
    shell.run("rm "..POGOS_HOME.."/"..targetFiles[i])
    shell.run("wget "..REPO..targetFiles[i].." "..POGOS_HOME.."/"..targetFiles[i])

end
