----------------------------------------------------------------
-- GLOBAL VARS

-- Id if the wired modem to access network
PERIPHERAL_ID = 2

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

-- Lists all peripherals and names


----------------------------------------------------------------
-- MAIN

-- Get modem
peripheralData = peripheral.getNames()
printIpairs(peripheralData)


-- print(ALL_ITEMS_DATA[1][1] .. "|" .. ALL_ITEMS_DATA[1][2][1])

-- for index, chestname in pairs(ALL_ITEMS_DATA[1][2][2]) do 
--     print(chestname)
-- end

