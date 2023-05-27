-- VARS --
----------
SOURCE = "projecte:condenser_mk1_0"
TARGET = "rftoolsutility:crafter3_0"
MIN_AMOUNT = 1
ITEM = "alltheores:copper_ore_hammer"
SLEEP = 1

-- FUNC --
----------

-- Returns amount of item in peripheral
function remaining(p_name)
    local count = 0
    local data = peripheral.call(p_name, "list")
    for _slot, item_data in pairs(data) do
        if item_data["name"] == ITEM then
            count = count + item_data["count"]
        end
    end
    return count
end

-- Move if item is found
function move()

end

-- MAIN --
----------

s = peripheral.wrap(SOURCE)
t = peripheral.wrap(TARGET)

while true do
    local t_count = remaining(TARGET)
    local s_count = remaining(SOURCE)

    -- Check if target has enough
    if t_count >= MIN_AMOUNT then
        -- Do nothing
    else
        -- Check if source has enough to fill target, else fill as much as possible
        local to_move = MIN_AMOUNT - t_count
        if to_move > s_count then
            to_move = s_count
        end

        -- Move from available slots
        local remaining = to_move
        for slot, item_data in pairs(s.list()) do
            if item_data["name"] == ITEM then
                if item_data["count"] >= remaining then
                    s.pushItems(TARGET, slot, remaining)
                    remaining = 0
                else
                    s.pushItems(TARGET, slot, item_data["count"])
                    remaining = remaining - item_data["count"]
                end
            end
        end
    end
    sleep(SLEEP)
end
