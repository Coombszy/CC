-- BOOT CONFIG
RUN_DEBUG = false

-- WIPE
term.clear()
term.setCursorPos(1,1)

-- BOOT DEBUG CODE
if RUN_DEBUG then
    shell.run("StorageSystemDebug.lua")
end

-- BOOT STORAGE SYSTEM (POG OS)
print("BOOTING POG OS")
shell.run("StorageSystem.lua")