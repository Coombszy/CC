------------
-- Vars
local NOTE = tonumber(os.getComputerLabel())
local R_CHANNEL = 6000 + NOTE
local DELIMITER = "/"
local RUNNING = true

------------
-- Functions

-- Splits a string by a given delimiter string
function splitString(s, delimiter)
    local result = {}
    for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
        table.insert(result, match)
    end
    return result
end

function play_sound(data)
    if data[1] == "1" then
        redstone.setOutput("back", data[2] == "true")
    elseif data[1] == "2" then
        redstone.setOutput("right", data[2] == "true")
    elseif data[1] == "3" then
        redstone.setOutput("front", data[2] == "true")
    end
end

------------
-- Runtime

local modem = peripheral.find("modem") or error("No modem attached", 0)
modem.open(R_CHANNEL) -- Open 1 so we can receive replies

print("Note: " .. NOTE)

while (RUNNING)
do
    local _, _, _, _, content, _ = os.pullEvent("modem_message")
    play_sound(splitString(content, DELIMITER))
end
