-- Interface to storage devices
-- Version 0.0
------------------------------------------------------------
local Storage = {}
setmetatable(Storage, Storage)
Storage.__index = Storage

-- Imports
------------------------------------------------------------
local Utils = require("/pogOS/lib/utils")

-- Methods
------------------------------------------------------------

-- Initializes the storage system
-- @param {peripheral} io_chest - Chest peripheral for input and output
-- @param {string} list_delimiter - Delimiter for item lists
-- @param {table} ignore_list - List of chests/storage blocks to ignore
-- @return {storage} - Storage object
function Storage:__call(io_chest, ignore_list)
    -- Store vars in lib
    self.io_chest = io_chest
    -- storage.list_delimiter = list_delimiter
    self.ignore_list = ignore_list
    self.modem = peripheral.wrap("bottom")
    self.data = {}

    return self
end

-- Check that chest id exists
-- @param {number} chest_id - Chest id to check
-- @return {boolean} - True if chest exists, false otherwise
function Storage:chestExists(chest_id)
    -- Get all storage devices
    local storage_devices = self:getStorageDevices()

    -- Check if chest id exists
    return Utils.hasValue(storage_devices, chest_id)
end

-- Get all storage devices connected to the network
-- @return {list} - List of storage device ids
function Storage:getStorageDevices()
    -- Get all peripherals that are storage devices
    local storage_devices = self.modem.getNamesRemote()
    local storage_devices_filtered = {}

    -- Remove non storage devices
    for _, device in ipairs(storage_devices) do
        if self.modem.hasTypeRemote(device, "minecraft:chest") then
            table.insert(storage_devices_filtered, device)
        end
    end

    -- Remove ignored devices
    for i, device in ipairs(self.ignore_list) do
        if Utils.hasValue(storage_devices_filtered, device) then
            table.remove(storage_devices_filtered, i)
        end
    end

    -- Remove io chest
    for i, device in ipairs(storage_devices_filtered) do
        if device == peripheral.getName(self.io_chest) then
            table.remove(storage_devices_filtered, i)
        end
    end

    return storage_devices_filtered
end

-- Does item exist in storage system.
-- WARNING: Does not update data first
-- @param {string} item - Item to check
-- @return {boolean} - True if item exists, false otherwise
-- @return {number} - Index of item in storage system
-- @return {table} - Item metadata
function Storage:findItem(item_id)
    -- For each in storage system data
    for index, data in ipairs(self.data) do
        -- Get meta data for item
        local item_name = data[1]
        local item_meta = data[2]

        -- If item exists in data
        if item_name == item_id then
            return true, index, item_meta
        end
    end
    -- Item does not exist in data
    return false, nil, nil
end

-- Update data about all storage devices
function Storage:updateData()
    -- Get all storage devices
    local storage_devices = self:getStorageDevices()

    -- Wipe data
    self.data = {}

    -- Get data for each storage device
    for _, device in ipairs(storage_devices) do
        -- Get items in device
        local device_inventory = self.modem.callRemote(device, "list")

        -- For each item in chest
        for slot, item in pairs(device_inventory) do
            -- Does item already exist in data
            local item_exists, _, item_meta = self:findItem(Utils.splitString(item.name, ":")[2])

            -- If item exists
            if item_exists then
                -- Add found item count to existing item count
                item_meta[1] = item_meta[1] + item.count
                -- Add chest/peripheral id to existing meta data
                item_meta[2][#item_meta[2] + 1] = device .. "|" .. slot
            else
                -- Create new entry for item
                local new_item = { Utils.splitString(item.name, ":")[2], { item.count, { device .. "|" .. slot } } }
                -- Add new item to data
                self.data[#self.data + 1] = new_item
            end
        end
    end
end

-- Get item details from specific device
-- @param {string} device - Device to get item from
-- @param {number} slot - Slot to get item data from
-- @return {table} - Item data
function Storage:getItemDetails(device, slot)
    -- Get item data from device
    local item_data = self.modem.callRemote(device, "getItemDetail", tonumber(slot))

    -- Return item data
    return item_data
end

-- Search for item in storage system.
-- If exact is true, only return exact matches, if no exact matches, returns similar matches
-- If exact is false, returns all similar or more matches
-- WARNING: Does not update data first
-- @param {string} item - Item to search for
-- @param {boolean} exact - If true, only return exact matches
-- @return {list} - List of items that match search
function Storage:searchItem(item, exact)
    -- List of items that match search
    local matches = {}
    local foundOne = false

    -- For each item in storage system data
    for _, data in pairs(self.data) do
        -- Get meta data for item
        local item_name = data[1]
        local item_meta = data[2]
        local item_count = item_meta[1]

        -- If item matches search
        if string.find(item_name, item) then
            foundOne = true
            table.insert(matches, { item_name, item_count })

            -- If name exactly matches search and exact is true
            if item_name == item and exact then
                -- Reset matches and return only exact match
                matches = {}
                table.insert(matches, { item_name, item_count })
                break
            end
        end
    end
    return foundOne, matches
end

-- Retrieve item from storage system
-- NOT SAFE: Does not check if item exists in storage system or if there is enough of the item
-- WARNING: Does not update data first or after
-- @param {string} item - Item to extract
-- @param {number} amount - Amount of item to extract
function Storage:retrieveItem(item, amount)
    -- Amount of item left to extract
    local amount_left = amount

    -- Get item data from storage system
    local _, _, item_meta = self:findItem(item)

    -- Loop incase item is in multiple devices/slots
    while (amount_left ~= 0) do
        -- for each meta data entry
        for _, device_data in pairs(item_meta[2]) do
            -- Get device and slot from meta data
            local device = peripheral.wrap(Utils.splitString(device_data, "|")[1])
            local slot = Utils.splitString(device_data, "|")[2]

            -- Get item data from device
            local item_data = device.getItemDetail(tonumber(slot))

            -- If enough items in slot, take remaining amount
            if (amount_left <= item_data["count"]) then
                device.pushItems(peripheral.getName(self.io_chest), tonumber(slot), amount_left)
                amount_left = 0
                break
                -- Otherwise, take as much as possible
            else
                device.pushItems(peripheral.getName(self.io_chest), tonumber(slot), item_data["count"])
                amount_left = amount_left - item_data["count"]
            end
        end
    end
end

-- Add single slot to existing slots in storage system
-- @param {string} item_slot - Item slot in io chest
-- @param {table} system_metadata - Metadata for item in storage system
-- @param {number} amount - Amount of item to add
-- @return {boolean, number} - True if item was added, false otherwise and amount left
function Storage:addToExisting(item_slot, system_metadata, amount)
    -- Amount of item left to add
    local amount_left = amount

    -- For each device in system metadata of item
    for i = 1, #system_metadata[2] do
        -- Get target chest and slot
        local device = peripheral.wrap(Utils.splitString(system_metadata[2][i], "|")[1])
        local slot = Utils.splitString(system_metadata[2][i], "|")[2]

        -- Get item data from device
        local item_data = device.getItemDetail(tonumber(slot))
        local item_max_stack = item_data["maxCount"]
        local item_existing_count = item_data["count"]

        -- Calculate how much space there is and how much to move
        local space_left = item_max_stack - item_existing_count
        local amount_to_move = 0
        if space_left >= amount_left then
            amount_to_move = amount_left
        else
            amount_to_move = space_left
        end

        -- Move items from io chest to device
        device.pullItems(peripheral.getName(self.io_chest), tonumber(item_slot), amount_to_move, tonumber(slot))
        amount_left = amount_left - amount_to_move

        if amount_left <= 0 then
            return true, 0
        end
    end
    -- Assume item was not completely added
    return false, amount_left
end

-- Add item to storage system in empty slot
-- @param {string} item_slot - Item slot in io chest
-- @param {number} amount - Amount of item to add
-- @return {boolean} - True if item was added, false otherwise
function Storage:addAtEmpty(item_slot, amount)
    -- For each device in storage system
    local storage_devices = self:getStorageDevices()
    for _, device in pairs(storage_devices) do
        -- Get device inventory and size
        local device_inventory = self.modem.callRemote(device, "list")
        local device_size = self.modem.callRemote(device, "size")

        -- Stores each slot that already has an item in it
        local slots_taken = {}

        -- For each item in device
        for slot, _ in pairs(device_inventory) do
            table.insert(slots_taken, slot)
        end

        -- For each slot in device
        for slot_index = 1, device_size do
            -- If slot is not taken
            if not (Utils.hasValue(slots_taken, slot_index)) then
                -- Move item into empty slot
                self.io_chest.pushItems(device, tonumber(item_slot), amount, tonumber(slot_index))
                return true
            end
        end
    end
    return false
end

-- Store item in storage system from io chest slot
-- WARNING: Automatically calls updateData()
-- @param {string} item - Item to store
-- @param {number} slot - Item slot in io chest
-- @return {boolean} - True if item was completely stored, false otherwise
function Storage:storeItem(item, slot)
    -- Update storage system data
    -- TODO(LiamC): Do we actually need to call this every time? Its expensive
    self:updateData()

    -- Amount of item left to store
    local item_name = Utils.splitString(item, ":")[2]
    local amount_left = self.io_chest.getItemDetail(slot)["count"]
    local found, _, system_metadata = self:findItem(item_name)
    local complete = false

    -- If item exists in storage system
    if found then
        complete, amount_left = self:addToExisting(slot, system_metadata, amount_left)
    end

    -- If item was not completely added
    if not (complete) then
        complete = self:addAtEmpty(slot, amount_left)
    end

    return complete
end

-- Store all items in io chest in storage system
-- WARNING: Automatically calls updateData()
-- @return {list, list} - List of items that were stored, list of items that were not stored
function Storage:storeAll()
    -- Item lists
    local stored_items = {}
    local not_stored_items = {}

    local io_chest_inventory = self.io_chest.list()
    for slot, item in pairs(io_chest_inventory) do
        local item_name = Utils.splitString(item.name, ":")[2]
        local item_count = item.count

        -- If item was stored
        if self:storeItem(item.name, tonumber(slot)) then
            -- Add item to stored items
            stored_items[#stored_items + 1] = { item_name, item_count }
        else
            -- Add item to not stored items
            not_stored_items[#not_stored_items + 1] = { item_name, item_count }
        end
    end

    return stored_items, not_stored_items
end

------------------------------------------------------------
return Storage
