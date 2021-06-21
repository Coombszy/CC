----------------------------------------------------------------
-- GLOBAL VARS

-- Id if the wired modem to access network
PERIPHERAL_ID = 1

-- Stores all data withing the network
--    ITEM NAME   COUNT   ofLOCATIONS IN NETWORK
-- { Iron_ingot | {125, { CHEST1|32, CHEST2|19 }      } }
ALL_ITEMS_DATA = {}

OUTPUT_CHEST_NAME = "minecraft:chest_7"


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
    for slot, item in pairs(chestContents) do
        print(("%dx%s in slot %d"):format(item.count, item.name, slot))
    end
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

-- Using a modem, update the ALL_ITEM_DATA with the connected chests
function updateNetworkData(modem)

    -- Sample ALL_ITEMS_DATA
    -- ALL_ITEMS_DATA = { {"TEST_ITEM1", {64, {"CHEST0|25", "CHEST1|21"} } }, {"minecraft:planks", {0, {"CHEST0|1", "CHEST1|5"} } } }

    -- Reset ALL_ITEMS_DATA for population
    ALL_ITEMS_DATA = {}

    -- For each Chest
    local names = modem.getNamesRemote()
    for id, chestname in pairs(names) do

        -- Get Chest Inventory
        local chestInventory = modem.callRemote(chestname, "list")
        
        -- For each item in chest
        for slot, item in pairs(chestInventory) do

            -- Does ALL_ITEMS_DATA contain item?
            local found, index, metadata = findItem(ALL_ITEMS_DATA, item.name)
            
            -- If the all item data already contains an item
            if (found) then
                -- Add found item count to existing entry
                metadata[1] = metadata[1] + item.count
                -- Add chest/peripheral to existing metadata
                metadata[2][#metadata[2]+1] = chestname .. "|".. slot
            -- Otherwise, add a new item entry
            else
                -- create new entry and append to end of table
                local newitem = {item.name, {item.count, {chestname .. "|".. slot} }}
                -- #ALL_ITEMS_DATA = Size of table
                ALL_ITEMS_DATA[#ALL_ITEMS_DATA+1] = newitem
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
            local targetitemdata = inventory.getItemMeta(tonumber(invslot))

            -- Calculate movement
            -- If enough in inventory, take remaining
            if(remaining <= targetitemdata["count"]) then
                inventory.pushItems(OUTPUT_CHEST_NAME, tonumber(invslot), remaining)
                remaining = 0
                requestcomplete = true
                break
            -- Otherwise, Take as much as possible and move on
            else
                inventory.pushItems(OUTPUT_CHEST_NAME, tonumber(invslot), targetitemdata["count"])
                remaining = remaining - targetitemdata["count"]
            end

        end
    end    
end

----------------------------------------------------------------
-- MAIN

-- Get modem
peripheralData = peripheral.getNames()
modem = peripheral.wrap(peripheralData[PERIPHERAL_ID])

updateNetworkData(modem)

-- print(ALL_ITEMS_DATA[1][1] .. "|" .. ALL_ITEMS_DATA[1][2][1])

-- for index, chestname in pairs(ALL_ITEMS_DATA[1][2][2]) do 
--     print(chestname)
-- end

moveitem("minecraft:planks", 22, "left")
