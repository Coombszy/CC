-- BOOT CONFIG
-----------------------------------------------------------------------
-- init configs
PATH = "/" .. fs.getDir(shell.getRunningProgram()) .. "/"

MUSIC_HOME = "/music"
REPO = "https://raw.githubusercontent.com/Coombszy/CC/master/misc/music/"
-- ^ These need to be updated if the repo ever changes. Normally this is handled
--   by the configs of the patcher. Since the configs don't exist yet it has to
--   be hardcoded.

-- WIPE
-----------------------------------------------------------------------
term.clear()
term.setCursorPos(1, 1)

-- DOWNLOAD PATCHER AND CREATE WORKSPACE
-----------------------------------------------------------------------
print("INSTALLING MUSIC")

local targetFiles = { "bee", "laugh", "pikmin", "rehehehe", "sadmeow", "seashanty2" }


shell.run("wget " .. REPO .. "play.lua" .. " " .. MUSIC_HOME .. "/" .. "play.lua")

-- For each file download
for i = 1, table.getn(targetFiles) do
    print("")
    print("Downloading file: " .. targetFiles[i])
    shell.run("wget " .. REPO .. targetFiles[i] .. ".dfpwm " .. MUSIC_HOME .. "/" .. targetFiles[i] .. ".dfpwm")
end

