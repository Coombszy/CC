-- Client for the storage system
-----------------------------------------------------------

-- Imports
-----------------------------------------------------------
local Utils = require("lib/utils")
local ConfigManager = require("lib/configManager") -- Legacy

-- Shared
-----------------------------------------------------------
local version = "1.0"
local config = nil
local modem = nil

-- Easter egg messages
EA_STRINGS = { "Feeling Poggy Froggy", "No you", "Better that Applied Energistics", "Loser", "PogChamp!",
    "Twitch < Youtube... Kappa", "We're no strangers to love....", "I heard that Coombszy guy is pretty cool",
    "https://www.youtube.com/watch?v=dQw4w9WgXcQ", "E", "We are number one!", "Daf's a cheater",
    "Build the fucking aquarium", "Successfully De-0pped", "Do something better with your life", "Oppa gangnam style!",
    "You must construct additional pylons!", "Insufficient vespene gas", "Oof", "Is this a good use of your time?",
    "Ready? Player one", "Computer! Computer! Computer!", "Buttons!", "Look Book!", "oooOOOOohh COMPUTOR",
    "'I mined it'", "OOOooooo baby I love your way!", "Can't touch this!", "I find GladOS quite the inspiration",
    "I can't do that Dave", "I'M LEGALLY BLIIND", "Chompy is king", "Why is the rum always gone?",
    "May the force be with you", "OOoh Behave!", "I like it when you push my buttons", "I'm different",
    "Don't make lemonade", "Bonk!", "Kalm", "PANIK!", "Stonks", "Apes strong together", "AMC TO THE MOON!", "Now in HD!" }

-- Temporary States
STATES = {}
STATES["MISSING_AMOUNT_WARNED"] = false

-- Functions
----------------------------------------------------------------
-- modem.transmit(config["SERVER_PORT"], config["CLIENT_PORT"], { "STORE", {} })

-- Query the server for an item
-- @param {string} itemname - The name of the item to query
-- @return {boolean, list} - If the item was found, and a list of matches
function queryItem(itemname)
    -- Send query to server
    modem.transmit(config["SERVER_PORT"], config["CLIENT_PORT"], { "QUERY", itemname })
    -- Wait for response and decode
    local _, _, _, _, message, _ = os.pullEvent("modem_message")
    local status = message[1]
    local matches = message[2]

    -- Handle different message types
    if status == "FOUND" then
        return true, matches
    elseif status == "NOT FOUND" then
        return false, {}
    else
        error("Unknown status: " .. status)
    end
end

-- Retrieve an item from the server
-- @param {string} item_name - The name of the item to retrieve
-- @param {number} item_count - The amount of the item to retrieve
-- @return {string, number} -status, and the amount retrieved
function retrieveItem(item_name, item_count)
    -- Send query to server
    modem.transmit(config["SERVER_PORT"], config["CLIENT_PORT"], { "RETRIEVE", { item_name, item_count } })
    -- Wait for response and decode
    local _, _, _, _, message, _ = os.pullEvent("modem_message")
    local status = message[1]
    local amount_retrieved = message[2]

    return status, amount_retrieved
end

-- Store all items in the chest
-- @return {list, list} - A list of items stored, and a list of items failed to store
function storeItems()
    -- Send query to server
    modem.transmit(config["SERVER_PORT"], config["CLIENT_PORT"], { "STORE", {} })
    -- Wait for response and decode
    local _, _, _, _, message, _ = os.pullEvent("modem_message")
    local status = message[1]
    local stored = message[2][1]
    local failed = message[2][2]

    -- Handle different message types
    if status == "STORED" then
        return stored, failed
    else
        print("Unknown status: " .. status)
        return {}, {}
    end
end

-- Conditions
----------------------------------------------------------------

-- Is the parameters of the command correct for a search conditions
function isSearch(text)
    if string.sub(text, 0, 2) == '? ' then
        return true, string.sub(text, 3, string.len(text))
    elseif text:sub(0, 7) == "search " then
        return true, string.sub(text, 8, string.len(text))
    end

    return false, nil
end

-- Is the parameters of the command correct for a get conditions
function isGet(text)
    if string.sub(text, 0, 2) == '/ ' then
        return true, Utils.splitString(string.sub(text, 3, string.len(text)), " ")[1],
            Utils.splitString(string.sub(text, 3, string.len(text)), " ")[2]
    elseif text:sub(0, 4) == "get " then
        return true, Utils.splitString(string.sub(text, 5, string.len(text)), " ")[1],
            Utils.splitString(string.sub(text, 5, string.len(text)), " ")[2]
    end

    return false, nil, nil
end

-- Screens
----------------------------------------------------------------

-- Writes boot screen, version and logo
function startUpScreen()
    term.clear()
    term.setCursorPos(1, 1)
    print("-------------------------- pogOS (Client) " .. version)
    print("")
    print("")
    print("     ((((((((((         ((((((((((")
    print("     ((((((((((         ((((((((((")
    print("((((((((((((((((((((((((((((((((((")
    print("((((((((((((((((((((((((((((((((((")
    print("((((((((((     @@@@@((((     @@@@@")
    print("((((((((((     @@@@@((((     @@@@@")
    print("((((((((((((((((((((((((((((((((((")
    print("((((((((((((((((((((((((((((((((((")
    print("#####(((((########################")
    print("#####(((((########################")
    print("#####((((((((((((((((((((((((")
    print("#####((((((((((((((((((((((((")
    print("#############################")
    print("")
    print("type ! or help for command help.")
end

-- Write the help screen
function helpScreen()
    print("")
    print("All commands have a single character alias to speed up system usage.")
    print("")
    print(" ! | help")
    print("   | Brings up this help menu.")
    print(" ? | search 'TEXT'")
    print("   | Searches for an item, returns quantity.")
    print(" / | get 'TEXT' 'QUANTITY'")
    print("   | Moves QUANTITY of item to IO chest.")
    print(" < | store")
    print("   | Moves contents of IO chest into storage.")
    print(" ^ | exit")
    print("   | Close pogOS. Return to base computer OS.")
    print("")

    mainScreen()
end

-- Search screen
function searchScreen(text)
    -- Search for items
    local found_any, matches = queryItem(text)

    -- If item was found, write it out
    if found_any then
        print("")
        print("Found " .. #matches .. " item(s):")

        for _, item_meta in pairs(matches) do
            print(" - '" .. item_meta[1] .. "' x " .. tostring(item_meta[2]))
        end
    else
        -- No items found in the data store
        print("No items found with a name containing '" .. text .. "'.")
    end

    mainScreen()
end

-- Get items screen
function getScreen(item, count)
    -- Search for items
    local status, item_count = retrieveItem(item, count)

    -- If item was found, write it out
    if status == "NOT FOUND" and item_count == 0 then
        print("No items found with a name '" .. item .. "'.")
        mainScreen()
    end

    -- If more than one item with the same name was found
    if status == "BE SPECIFIC" then
        print("Multiple items containing '" .. item .. "' were found!")
        print("Please be more specific")
        mainScreen()
    end

    -- If not enough items were found
    if status == "NOT ENOUGH" and count ~= nil then
        print("Not enough items found with a name '" .. item .. "'.")
        print("Only " .. tostring(item_count) .. " were found and withdrawn.")
        mainScreen()
    end

    -- If count is null, grab a stack of the item
    if count == nil then
        if not (STATES["MISSING_AMOUNT_WARNED"]) then
            print("You did not specify how many to withdraw. E.g:")
            print("> get cobble 64")
            print("Will withdraw a stack instead! Or the next avaliable amount!")
            print("This error will appear after next reboot.")
            print("")
            STATES["MISSING_AMOUNT_WARNED"] = true
        end
    end

    print("Withdrawn successfully!")
    mainScreen()
end

-- store screen
function storeScreen()
    -- write warning to user
    print("Storing all items in IO chest...")

    -- Store items from IO test
    local stored, failed = storeItems()

    print("")
    print("Stored:")

    -- List item storing results
    for _, item_data in pairs(stored) do
        print(" - '" .. item_data[1] .. "' x " .. tostring(item_data[2]))
    end

    -- Only list failed if greater than 0
    if #failed > 0 then
        print()
        print("")
        print("Failed to store:")

        -- List failed item storing results
        for _, item_data in pairs(failed) do
            print(" - '" .. item_data[1] .. "' x " .. tostring(item_data[2]))
        end
    end

    print("")
    mainScreen()
end

-- easter egg screen
function easterEggScreen()
    -- Get random number generator and shuffle a few
    -- math.randomseed(os.time())
    math.random(); math.random(); math.random()

    -- Print a random message from EA_STRINGS
    print(EA_STRINGS[math.random(#EA_STRINGS)])

    -- Return to main screen
    mainScreen()
end

-- Handle normal user input
function mainScreen()
    -- Write terminal characters
    term.write("> ")

    -- Get user inputs
    local input = string.lower(read())
    local searchBool, searchClipped = isSearch(input)
    local getBool, getClipped, getCount = isGet(input)

    -- Help
    if input == "!" or input == "help" then
        helpScreen()

        -- Search
    elseif searchBool == true then
        searchScreen(searchClipped)

        -- Get
    elseif getBool == true then
        getScreen(getClipped, getCount)

        -- Store
    elseif input == "<" or input == "store" then
        storeScreen()

        -- Exit
    elseif input == "^" or input == "exit" then
        print("Shutting down :(")
        return

        -- HIDDEN FEATURES!

        -- Feeling froggy
    elseif input == "pog" or input == "poggy" then
        easterEggScreen()

        -- Else, Try help?
    else
        print("Unknown command, try 'help' or '!'")
        mainScreen()
    end
end

-- Main
-----------------------------------------------------------

term.clear()
term.setCursorPos(1, 1)
print("Booting pogOS Storage Client v" .. version)

-- Figure out which modem is the wireless one
for _, side in ipairs(rs.getSides()) do
    if peripheral.getType(side) == "modem" then
        modem = peripheral.wrap(side)
        if modem.isWireless() then
            break
        else
            modem = nil
        end
    end
end
if modem == nil then
    print("No wireless modem found! Fatal error")
    return
end
print("...hardware found")

-- Start configs
ConfigManager.setTargetConfig("/" ..
    fs.getDir(shell.getRunningProgram()) .. "/config/storageClient.conf")
config = ConfigManager.fetch()
if config == nil then
    print("Config not found! Fatal error")
    return
end
print("...configs loaded")

-- Log bootup progress
print("Initilization complete")
print("Starting server...")

-- Start server
config["SERVER_PORT"] = tonumber(config["SERVER_PORT"])
config["CLIENT_PORT"] = tonumber(config["CLIENT_PORT"])
modem.open(config["CLIENT_PORT"])
print("Client started!")
-- Sleep for a second to let the server start
os.sleep(0.5)
term.clear()
term.setCursorPos(1, 1)

-- Main loop
startUpScreen()
mainScreen()
