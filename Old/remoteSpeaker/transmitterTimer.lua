-----------------------------------------------------------------
------ FUNCTIONS

-- Does array contain item?
function hasValue(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

-- Get side of modem
function getSide()
    print("Which side is the modem? ");
    input = read()

    correct_inputs = {"left", "right", "top", "bottom", "front", "back" }

    if (hasValue(correct_inputs, input)) then
        return input
    else
        print("Invalid!")
        return getSide()
    end
end

-----------------------------------------------------------------
------ CONSTANTS

MODEM_SIDE = ""
MESSAGE = ""
TIMER = 0
RUNNING = true
COMPUTER_ID = 10001

-----------------------------------------------------------------
------ MAIN 
MODEM_SIDE = getSide()

-- Get message
print("Message to transmit: ")
MESSAGE = read()
MESSAGE = "minecraft:" .. MESSAGE

-- Get message
print("Time between transmission: ")
TIMER = read()

-- Open connection
rednet.open(MODEM_SIDE)

-- Main application loop
while(RUNNING) do
    sleep(tonumber(TIMER))
    rednet.broadcast(MESSAGE, "RemoteSpeaker")
end

rednet.close(MODEM_SIDE)