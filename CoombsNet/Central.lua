-- CENTRAL SERVER CODE, HANDLES QUEUE AND SUBSCRIPTION CODE FOR COOMBSNET
-------------------------------------------------------------------------

-----------------------------------------------------------------
------ CONSTANTS

RUNNING = true
HOST_SERVER_MODEM_ID = 60001 

-----------------------------------------------------------------
------ FUNCTIONS

-- Does array contain item?
function hasValue(tab, val)
    print("HAS VALUE CODE:")
    for index, value in ipairs(tab) do
        print(index .. ":" .. value)
        if value == val then
            print("VALUE FOUND")
            return true
        end
    end
    print("VALUE NOT FOUND")
    return false
end

-- Insert item under and index, within table
function insertItem(tab, index, item)
    tempTable = tab
    if(hasValue(tab, index)) then
        indexArray = tab[index]
        tempTable[index] = insertItemAtEnd(indexArray, item)
        
    else
        tempTable[index] = { item }
    end
    return tempTable
end

-- Inserts item at the end of an table
function insertItemAtEnd(tab, item)
    tempTable = tab
    print ("TAB SIZE:" .. table.getn(tempTable))
    tempTable[( table.getn(tab) + 1) ] = item
    return tempTable
end

-----------------------------------------------------------------
------ MAIN

-- TESTING --

client1Name = "Dave"
client1Msg1 = "Hello"
client1Msg2 = "There"

client2Name = "Geoff"
client2Msg1 = "You're"
client2Msg2 = "Fired"

newTable = {}

newTable = insertItem(newTable, client1Name, client1Msg1 )
newTable = insertItem(newTable, client1Name, client1Msg2 )

print(newTable[client1Name][1])

print(newTable[client1Name][2])

-- TESTING --