----------------------------------------------------------------
-- CONFIGS
-- TO BE CHANGE PER INSTALLATION

-- Id if the wired modem to access network
PERIPHERAL_ID = 1

-- Where to output items from the storage system
OUTPUT_CHEST_NAME = "minecraft:chest_10"

----------------------------------------------------------------
-- GLOBAL VARS

-- Stores all data withing the network
--    ITEM NAME   COUNT   ofLOCATIONS IN NETWORK
-- { Iron_ingot | {125, { CHEST1|32, CHEST2|19 }      } }
ALL_ITEMS_DATA = {}

-- Global modem variable
MODEM = nil

-- The operating system version
OS_VERSION = "v1.52"

-- Easter egg messages
EA_STRINGS = {"Feeling Poggy Froggy", "No you", "Better that Applied Energistics", "Loser", "PogChamp!", "Twitch < Youtube... Kappa", "We're no strangers to love....", "I heard that Coombszy guy is pretty cool", "https://www.youtube.com/watch?v=dQw4w9WgXcQ", "E", "We are number one!", "Daf's a cheater", "Build the fucking aquarium", "Successfully De-0pped", "Do something better with your life", "Oppa gangnam style!", "You must construct additional pylons!", "Oof", "Is this a good use of your time?", "Ready? Player one", "Computer! Computer! Computer!", "Buttons!", "Look Book!", "oooOOOOohh COMPUTOR", "'I mined it'", "OOOooooo baby I love your way!", "Can't touch this!", "I find GladOS quite the inspiration", "I can't do that Dave", "I'M LEGALLY BLIIND", "Chompy is king", "Why is the rum always gone?", "May the force be with you", "OOoh Behave!", "I like it when you push my buttons", "I'm different", "Don't make lemonade", "Bonk!", "Kalm", "PANIK!", "Stonks","Apes strong together", "AMC TO THE MOON!"} 

----------------------------------------------------------------
-- FUNCTIONS

-- Split string by delimiter
function splitString(s, delimiter)
    local result = {}
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end

-- Does array contain item?
function hasValue(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

-- Prints the contents of an Ipairs table
function printIpairs(table)
    for index, value in ipairs(table) do
        print(index .. ":" .. value)
    end
end

-- Prints the contents of an Ipairs table
function printPairs(table)
    for index, value in pairs(table) do
        print(index .. ":" .. value)
    end
end

-- Prints the contents of an array
function printMethodTable(table)
    for method in pairs(table) do
        print(method)
    end
end

-- Prints the contents of a chest
function printChestContents(data) 
    for slot, item in pairs(data) do
        print(("%dx%s in slot %d"):format(item.count, item.name, slot))
    end
end

-- Gets item details using chest name and slot
function getItemDetails(chestname, slot)
    -- Get chest and item data
    local targetchestobject = peripheral.wrap(chestname)
    return targetchestobject.getItemDetail(tonumber(slot))
end

-- Does ALL_ITEMS_DATA contain item, Returns index and metadata
function findItem(data, val)
    -- For each in ALL_ITEMS_DATA
    for index, itemdata in pairs(data) do
        -- Get meta data out of ALL_ITEMS_DATA entry
        itemname = itemdata[1]
        metadata = itemdata[2]

        -- If itemname matches searched value
        if itemname == val then
            -- Return true and the item index, and the item metadata
            return true, index, metadata
        end

    end
    -- Return false and nil
    return false, nil, nil
end

-- Search item name in ALL_ITEMS_DATA, Returns bool and {itemname, itemcount}
function searchItems(data, val)

    local found = {}
    local foundOne = false

    -- For each in ALL_ITEMS_DATA
    for index, itemdata in pairs(data) do
        -- Get meta data out of ALL_ITEMS_DATA entry
        itemname = itemdata[1]
        metadata = itemdata[2]
        itemcount = metadata[1]

        -- If itemname matches searched value
        if string.find(itemname, val) then

            -- Return true and the item index, and the item metadata
            table.insert(found, {itemname, itemcount})
            foundOne = true

            -- If name exact matches, return the one
            if itemname == val then

                -- Reset to get the exact item matched item
                found = {}
                table.insert(found, {itemname, itemcount})
                foundOne = true
                break
            end
        end

    end
    -- Return false and nil
    return foundOne, found
end

-- Search item name in ALL_ITEMS_DATA, Returns bool and {itemname, itemcount}
function searchItemsNoExactMatch(data, val)

    local found = {}
    local foundOne = false

    -- For each in ALL_ITEMS_DATA
    for index, itemdata in pairs(data) do
        -- Get meta data out of ALL_ITEMS_DATA entry
        itemname = itemdata[1]
        metadata = itemdata[2]
        itemcount = metadata[1]

        -- If itemname matches searched value
        if string.find(itemname, val) then

            -- Return true and the item index, and the item metadata
            table.insert(found, {itemname, itemcount})
            foundOne = true

        end

    end
    -- Return false and nil
    return foundOne, found
end

-- Using a modem, update the ALL_ITEM_DATA with the connected chests
function updateNetworkData(modem)

    -- Sample ALL_ITEMS_DATA
    -- ALL_ITEMS_DATA = { {"TEST_ITEM1", {64, {"CHEST0|25", "CHEST1|21"} } }, {"minecraft:planks", {0, {"CHEST0|1", "CHEST1|5"} } } }

    -- Reset ALL_ITEMS_DATA for population
    ALL_ITEMS_DATA = {}

    -- For each Chest
    local names = modem.getNamesRemote()
    for id, chestname in pairs(names) do

        -- If not the output chest
        if OUTPUT_CHEST_NAME ~= chestname then

            -- Get Chest Inventory
            local chestInventory = modem.callRemote(chestname, "list")

            -- For each item in chest
            for slot, item in pairs(chestInventory) do

                -- Does ALL_ITEMS_DATA contain item?
                local found, index, metadata = findItem(ALL_ITEMS_DATA, splitString(item.name,":")[2])
                
                -- If the all item data already contains an item
                if (found) then
                    -- Add found item count to existing entry
                    metadata[1] = metadata[1] + item.count
                    -- Add chest/peripheral to existing metadata
                    metadata[2][#metadata[2]+1] = chestname .. "|".. slot
                -- Otherwise, add a new item entry
                else
                    -- create new entry and append to end of table
                    local newitem = {splitString(item.name,":")[2], {item.count, {chestname .. "|".. slot} }}
                    -- #ALL_ITEMS_DATA = Size of table
                    ALL_ITEMS_DATA[#ALL_ITEMS_DATA+1] = newitem
                end
            end
        end
    end
end

-- Using ALL_ITEMS_DATA, move item(s) from storage cluster to target inventory
-- ALL_ITEMS_DATA should be updated after item movement
function moveitem(itemname, count, destinationInv)

    -- Amount left to move
    local remaining = count

    -- While request not satisfied
    local requestcomplete = false

    -- Get item and data
    local found, index, metadata = findItem(ALL_ITEMS_DATA, itemname)

    -- Loop incase requested quantity is 
    while(not requestcomplete) do

        -- for each metadata entry
        for index, invdata in pairs(metadata[2]) do 
            -- Split string by delimiter
            local dataSplit = splitString(invdata, "|")

            -- Define vars about item in chest
            local invname = dataSplit[1]
            local invslot = dataSplit[2]

            -- Inventory to pull from
            local inventory = peripheral.wrap(invname)
            local targetitemdata = inventory.getItemDetail(tonumber(invslot))

            -- Calculate movement
            -- If enough in inventory, take remaining
            if(remaining <= targetitemdata["count"]) then
                inventory.pushItems(destinationInv, tonumber(invslot), remaining)
                remaining = 0
                requestcomplete = true
                break
            -- Otherwise, Take as much as possible and move on
            else
                inventory.pushItems(destinationInv, tonumber(invslot), targetitemdata["count"])
                remaining = remaining - targetitemdata["count"]
            end

        end
    end    
end

-- Using ALL_ITEMS_DATA, store item(s) to storage cluster
-- ALL_ITEMS_DATA should be updated after item movement
function storeItems()

    -- Items that were not able to be stored
    local failedItems = {}
    -- Items that were successfully stored
    local successfulItems = {}

    -- Update network data before pushing items in
    updateNetworkData(MODEM)

    -- Get Chest Inventory
    local chestInventory = MODEM.callRemote(OUTPUT_CHEST_NAME, "list")

    -- For each item in chest
    for slot, item in pairs(chestInventory) do

        -- Set default conditions
        local complete = false
        local remaining = item.count

        -- Does ALL_ITEMS_DATA contain item?
        local itemname = splitString(item.name,":")[2]
        local found, index, metadata = findItem(ALL_ITEMS_DATA, itemname)

        -- If item was found try store
        if found then

            -- if completed moving item
            complete, remaining = addToExisting(slot, itemname, metadata, remaining)
            
        end

        -- If still not found after adding to empty slot
        if not(complete) then

            -- Add to next empty space
            complete, remaining = addAtEmpty(slot, itemname, metadata, remaining, remaining)

        end

        -- Item was not able to be stored
        if not(complete) then

            -- Add itme to failed items list 
            failedItems[itemname] = remaining

        -- Report item storage success
        else 
            -- Set 0 to allow adding
            if successfulItems[itemname] == nil then
                successfulItems[itemname] = 0
            end
            -- Add total of same item stored
            successfulItems[itemname] = item.count + successfulItems[itemname]
        end

        -- Update network data again for next item in loop
        updateNetworkData(MODEM)

    end

    return successfulItems, failedItems
end

-- Add to empty space
function addAtEmpty(inputslot, itemname, metadata, itemamount)

    -- Set states
    local complete = false
    local remaining = itemamount

    -- Inventory to pull from
    local outputchest = peripheral.wrap(OUTPUT_CHEST_NAME)

    -- For each chest
    local names = MODEM.getNamesRemote()
    for id, chestname in pairs(names) do

        -- If not the output chest
        if OUTPUT_CHEST_NAME ~= chestname then

            -- Get Chest Inventory and size
            local chestInventory = MODEM.callRemote(chestname, "list")
            local chestSize = MODEM.callRemote(chestname, "size")

            -- Stores each slot that is already got an item in
            local takenSlots = {}
            
            -- For each item in chest
            for slot, item in pairs(chestInventory) do
                table.insert(takenSlots, slot)
            end

            -- For each chest slot
            for i = 1, chestSize do

                -- If slot is empty
                if not(hasValue(takenSlots, i)) then

                    -- While no failures
                    local failed = false

                    -- Move item into empty slot
                    outputchest.pushItems(chestname, inputslot, remaining, tonumber(i))

                    -- Set new values and break
                    remaining = 0
                    complete = true
                    break
                end
            end
        end

        -- If complete, break from for loop
        if complete then
            break
        end
    end

    return complete, remaining
end

-- Add to existing space
function addToExisting(inputslot, itemname, metadata, itemamount)

    -- Set states
    local complete = false
    local remaining = itemamount

    -- Inventory to pull from
    local outputchest = peripheral.wrap(OUTPUT_CHEST_NAME)

    -- For each chest in metadata of item
    for i = 1, #metadata[2] do

        -- Get target data from metadata
        local targetchest = splitString(metadata[2][i],"|")[1]
        local targetchestslot = splitString(metadata[2][i],"|")[2]

        -- Get chest and item data
        local targetchestobject = peripheral.wrap(targetchest)
        local itemdetails = targetchestobject.getItemDetail(tonumber(targetchestslot))
        local itemmaxstack = itemdetails.maxCount
        local itemcount = itemdetails.count

        -- Calculate amount to move
        local maxmoveableamount = itemmaxstack - itemcount

        -- Get the amount to actually move into chest
        local moveableamount = 0
        if maxmoveableamount >= remaining then
            moveableamount = remaining

        else
            moveableamount = maxmoveableamount
        end

        -- Move moveable amount
        outputchest.pushItems(targetchest, inputslot, moveableamount, tonumber(targetchestslot))

        -- Update remaining
        remaining = remaining - moveableamount 

        -- If all items have been moved
        if remaining <= 0 then
            complete = true
            break
        end
        
    end

    return complete, remaining
end

----------------------------------------------------------------
-- CONDITIONS

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
        return true, splitString(string.sub(text, 3, string.len(text)), " ")[1], splitString(string.sub(text, 3, string.len(text)), " ")[2]

    elseif text:sub(0, 4) == "get " then
        return true, splitString(string.sub(text, 5, string.len(text)), " ")[1], splitString(string.sub(text, 5, string.len(text)), " ")[2]
    end

    return false, nil, nil
end


----------------------------------------------------------------
-- SCREENS

-- Writes boot screen, version and logo
function startUpScreen() 
    term.clear()
    term.setCursorPos(1,1)
    print("-------------------------- POG OS (Storage) " .. OS_VERSION)
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
    print("All commands have a single command alias to speed up system usage.")
    print("")
    print(" ! | help")
    print("     Brings up this help menu.")
    print(" ? | search 'TEXT'")
    print("     Searches for an item, returns quantity.")
    print(" / | get 'TEXT' 'QUANTITY'")
    print("     Moves QUANTITY of item to IO chest.")
    print(" < | store")
    print("     Moves contents of IO chest into storage.")
    print(" ^ | exit")
    print("     Close POG OS. Return to base computer OS.")
    print("")

    mainScreen()
end

-- Search screen
function searchScreen(text)

    -- Update network data for search
    updateNetworkData(MODEM)

    -- Search for items
    local foundAny, itemdata = searchItemsNoExactMatch(ALL_ITEMS_DATA, text)

    -- If item was found, write it out
    if foundAny then
        print("")
        print("Found " .. #itemdata .. " item(s):")

        for index, itemmeta in pairs(itemdata) do 
            
            print(" - '" .. itemmeta[1] .."' x " .. tostring(itemmeta[2]))
        end

    -- No items found in the data store 
    else
        print ("No items found with a name containing '".. text .."'.")
    end

    mainScreen()
end

-- Get items screen
function getScreen(item, count) 

    -- Update network data
    updateNetworkData(MODEM)

    -- Search for item
    local foundAny, itemdata = searchItems(ALL_ITEMS_DATA, item)

    -- If item was found, write it out
    if not(foundAny) then
        print ("No items found with a name containing '".. item .."'.")
        mainScreen()
    end

    -- If more than one item with the same name was found
    if #itemdata > 1 then
        print("Multiple items containing '" .. item .. "' were found!")
        print("Found " .. #itemdata .. " item(s):")

        for index, itemmeta in pairs(itemdata) do 
            print(" - '" .. itemmeta[1] .."' x " .. tostring(itemmeta[2]))
        end

        print("")
        print("Please be more specific")
        mainScreen()
    end

    -- If count is null, grab a stack of the item
    if count == nil then
        print("You did not specify how many to withdraw. E.g:")
        print("> get cobble 64")
        print("Will withdraw a stack instead! Or the next avaliable amount!")
        print("")

        -- Get the item metadata from system
        local found, index, metadata = findItem(ALL_ITEMS_DATA, itemname)

        -- Get the current amount
        local storedAmount = tonumber(itemdata[1][2])

        -- Get sample data to find the max stack size of item
        local samplechest = splitString(metadata[2][1], "|")[1]
        local sampleslot = splitString(metadata[2][1], "|")[2]
        
        -- Get max stack size for item
        local maxStackSize = getItemDetails(samplechest,sampleslot).maxCount

        -- Get the amount to actually move into chest
        if maxStackSize >= storedAmount then
            count = storedAmount
        else
            count = maxStackSize
        end

    end

    -- Get found items meta data
    local itemmeta = itemdata[1]

    -- If more than one item with the same name was found
    if tonumber(itemmeta[2]) < tonumber(count) then

        print("You are trying to withdraw more items than the system contains.")
        print(" - '" .. itemmeta[1] .."' x " .. tostring(itemmeta[2]))
        mainScreen()
    end

    -- Withdraw items!
    moveitem(itemmeta[1], tonumber(count), OUTPUT_CHEST_NAME)
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
    for itemname, itemcount in pairs(stored) do 
        print(" - '" .. itemname .."' x " .. tostring(itemcount))
    end

    -- Only list failed if greater than 0
    if #failed > 0 then 
        print()
        print("")
        print("Failed to store:")

        -- List failed item storing results
        for itemname, itemcount in pairs(failed) do 
            print(" - '" .. itemname .."' x " .. tostring(itemcount))
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
    if input == "!" or input == "help" then helpScreen()

    -- Search
    elseif searchBool == true then searchScreen(searchClipped)

    -- Get
    elseif getBool == true then getScreen(getClipped, getCount)

    -- Store
    elseif input == "<" or input == "store" then storeScreen()

    -- Exit
    elseif input == "^" or input == "exit" then print("Shutting down :(") return

    -- HIDDEN FEATURES!

    -- Feeling froggy
    elseif input == "pog" or input == "poggy" then easterEggScreen()

    -- Else, Try help?
    else print("Unknown command, try 'help' or '!'") mainScreen() end
end

----------------------------------------------------------------
-- MAIN

-- Render boot screen
startUpScreen()

-- Get modem and build initial data
peripheralData = peripheral.getNames()
MODEM = peripheral.wrap(peripheralData[PERIPHERAL_ID])

updateNetworkData(MODEM)

-- Render main menu
mainScreen()