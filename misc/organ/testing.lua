--------------
-- Vars
local S_CHANNEL = 6000
local SLEEP = 1

--------------
-- Runtime
local modem = peripheral.find("modem") or error("No modem attached", 0)

while true do
    modem.transmit(S_CHANNEL + 12, 0, 1 .. "/" .. "true")
    modem.transmit(S_CHANNEL + 1, 0, 2 .. "/" .. "false")
    sleep(SLEEP)
    modem.transmit(S_CHANNEL + 12, 0, 1 .. "/" .. "false")
    modem.transmit(S_CHANNEL + 1, 0, 2 .. "/" .. "true")
    sleep(SLEEP)
end
