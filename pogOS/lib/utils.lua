-- Common/Shared functions
------------------------------------------------------------
local utils = {}
------------------------------------------------------------

-- Splits a string by a given delimiter string
function utils.splitString(s, delimiter)
    local result = {}
    for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
        table.insert(result, match)
    end
    return result
end

-- Does array contain item?
function utils.hasValue(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

-- Prints the contents of an Ipairs table
function utils.printIpairs(table)
    for index, value in ipairs(table) do
        print(index .. ":" .. value)
    end
end

-- Prints the contents of an pairs table
function utils.printPairs(table)
    for index, value in pairs(table) do
        print(index .. ":" .. value)
    end
end

------------------------------------------------------------
return utils
