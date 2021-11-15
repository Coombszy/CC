-- Hook to start pogOS
--------------------------------------------------

-- WIPE
term.clear()
term.setCursorPos(1,1)

shell.run("/pogOS/bootloader.lua")