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
COMPUTER_ID = 10001

-----------------------------------------------------------------
------ MAIN 
MODEM_SIDE = getSide()

-- Open connection
rednet.open(MODEM_SIDE)

print("type quit close the application, quit remote to close the remote")

-- Main application loop
while(RUNNING) do
    userInput = read()
    userInput = "minecraft:" .. userInput
    if (userInput == "quit") then
        RUNNING = false
    else
        rednet.broadcast(userInput, "RemoteSpeaker")
    end
end

rednet.close(MODEM_SIDE)