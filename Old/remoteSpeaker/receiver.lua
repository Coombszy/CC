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
RUNNING = true
COMPUTER_ID = 10002

-----------------------------------------------------------------
------ MAIN 
MODEM_SIDE = getSide()
SPEAKER = peripheral.find("speaker")

-- Open connection
rednet.open(MODEM_SIDE)

-- Main application loop
while(RUNNING) do
    id,message = rednet.receive("RemoteSpeaker")
    print("==RECIEVED==> ", message)
    if (message == "quit remote") then
        RUNNING = false
    else
        SPEAKER.playSound(message, 3)
    end
end