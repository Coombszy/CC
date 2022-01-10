-- BOOT CONFIG
-----------------------------------------------------------------------
-- init configs
PATH = "/"..fs.getDir( shell.getRunningProgram() ).."/"

POGOS_HOME = "/pogOS"
REPO_ROOT = "https://raw.githubusercontent.com/Coombszy/CC/master/"
REPO = "https://raw.githubusercontent.com/Coombszy/CC/master/pogOS/"
-- ^ These need to be updated if the repo ever changes. Normally this is handled
--   by the configs of the patcher. Since the configs don't exist yet it has to 
--   be hardcoded.

-- WIPE
-----------------------------------------------------------------------
term.clear()
term.setCursorPos(1,1)

-- DOWNLOAD PATCHER AND CREATE WORKSPACE
-----------------------------------------------------------------------
print("INSTALLING POG OS PATCHER")

shell.run("mkdir " .. POGOS_HOME)
shell.run("mkdir ".. POGOS_HOME .."/lib")
shell.run("mkdir ".. POGOS_HOME .."/config")

local targetFiles = {"lib/configManager.lua", "lib/utils.lua", "config/patcher.conf", "config/shared.conf", "patcher.lua", "config/tunnel.conf"}

-- For each file download
for i = 1, table.getn(targetFiles) do

    print("")
    print("Downloading file: "..targetFiles[i])
    shell.run("wget "..REPO..targetFiles[i].." "..POGOS_HOME.."/"..targetFiles[i])

end

-- INSTALLING 
-----------------------------------------------------------------------
print("INSTALLING POG OS")
shell.run(POGOS_HOME .. "/patcher.lua")
print("INSTALLING COMPLETE")

print("INSERTING STARTUP CATCH")
shell.run("wget "..REPO_ROOT.."startup.lua /startup.lua")

-- REBOOT(POG OS)
-----------------------------------------------------------------------
print("BOOTING POG OS")
shell.run("reboot")