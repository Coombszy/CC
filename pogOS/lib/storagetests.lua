-- Debug new storage lib
------------------------------------------------------------
local Utils = require("utils")
local Storage = require("storage")
print("TESTING START!")
local item_name = "dirt"
local item_count = 5
print("Testing item is " .. item_name)

local s = Storage(peripheral.wrap("minecraft:chest_13"), {})
s:updateData()

print("---- List all items in chest ----")
for _, item in ipairs(s.data) do
    print(item[1])
end

print("---- Look for `iron` ----")
local found, matches = s:searchItem("iron", false)
print(found)
for _, item in ipairs(matches) do
    Utils.printIpairs(item)
end

print("---- Look for `" .. item_name .. "` exactly ----")
local found, matches = s:searchItem(item_name, true)
print(found)
for _, item in ipairs(matches) do
    Utils.printIpairs(item)
end

print("---- Retrieve item `" .. item_name .. "` ----")
local found, matches = s:searchItem(item_name, true)
if not (found) then
    print("Item not found for test!")
end
s:retrieveItem(item_name, item_count)

print("---- Store all items in chest ----")
local stored, failed = s:storeAll()
print("Stored:")
for _, item in pairs(stored) do
    print(item[1] .. ":" .. item[2])
end
print("Failed:")
if #failed == 0 then
    print("None!")
end
for _, item in pairs(failed) do
    print(item[1] .. ":" .. item[2])
end

print("TESTING END!")
