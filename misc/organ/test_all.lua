--------------
-- Vars
local S_CHANNEL = 6000
local ARGS = { ... }

--------------
-- Runtime
local modem = peripheral.find("modem") or error("No modem attached", 0)

for octave = 1, 3 do
    for note = 1, 12 do
        print("o=" .. octave)
        print("n=" .. note)
        modem.transmit(S_CHANNEL + note, 0, octave .. "/" .. "true")
        sleep(tonumber(ARGS[1]))
        modem.transmit(S_CHANNEL + note, 0, octave .. "/" .. "false")
    end
end

sleep(tonumber(ARGS[1]))

for octave = 3, 1, -1 do
    for note = 12, 1, -1 do
        print("o=" .. octave)
        print("n=" .. note)
        modem.transmit(S_CHANNEL + note, 0, octave .. "/" .. "true")
        sleep(tonumber(ARGS[1]))
        modem.transmit(S_CHANNEL + note, 0, octave .. "/" .. "false")
    end
end
