-- BOOT CONFIG
BOOT_ITEM = 1
BOOT_DIR = "pogOS/"

-- WIPE
term.clear()
term.setCursorPos(1,1)

-- BOOT STORAGE SYSTEM (POG OS)
print("BOOTING POG OS")

if BOOT_ITEM == 1 then
    shell.run(BOOT_DIR .. "StorageSystem.lua")
elseif BOOT_ITEM == 2 then
    shell.run(BOOT_DIR .. "DiggingSystem.lua")
end