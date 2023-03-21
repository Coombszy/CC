--------------
-- Vars
local S_CHANNEL = 6000
local ARGS = { ... }

--------------
-- Runtime
local modem = peripheral.find("modem") or error("No modem attached", 0)

for octave = 1, 3 do
    for note = 1, 12 do
        modem.transmit(S_CHANNEL + note, 0, octave .. "/" .. "false")
    end
end
