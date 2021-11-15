-- IMPORTS
-----------------------------------------------------------------------
configManager = require("lib/configManager")

-- BOOT CONFIG
-----------------------------------------------------------------------
-- init configs
PATH = "/"..fs.getDir( shell.getRunningProgram() ).."/"
configManager.setTargetConfig(PATH .. "config/patcher.conf")

REPO = configManager.fetch()["REPO"]

-- MAIN
-----------------------------------------------------------------------

print("target repo: ".. REPO)
