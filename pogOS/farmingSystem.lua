-- Farming Program
-- Will bounce between two block types either clockwise or anti clockwise
-- Comes with programmable 'Override function'
--
-- Current setup is for Infernium Crops
--
------------------------------------------------

-- CONFIGS
CLOCK = "minecraft:sand"
ANTICLOCK = "minecraft:cobblestone"
HOME = "minecraft:granite"
PLANT = "mysticalagriculture:inferium_seeds"
OFFLOAD = true
RUN_FOREVER = true
WAIT_TIME = 60
-- CONFIGS
------------------------------------------------

-- USER ALTERATIONS HERE
-- Each movement the turtle will call override
function override()
  local do_harvest, do_plant = ready()
  if do_harvest == true then
    harvest()
  end
  if do_plant == true then
    plant()
  end
end

function harvest()
  turtle.digDown()
end

function plant()
  local found_plant = false
  local slot = 1
  for i = 1, 16 do
    local item_data = turtle.getItemDetail(i)
    if item_data then -- Make sure that there is actual item data
      if (item_data.name == PLANT) then
        found_plant = true
        slot = i
        break
      end
    end
  end
  if found_plant == true then
    turtle.select(slot)
    turtle.placeDown()
  else
    print("Cannot plant!")
  end
end

function ready()
  local success, data = turtle.inspectDown()
  if success == false then
    return false, true -- No harvest but plant
  end
  if data.state.age == 7 then
    return true, true-- Harvest and plant
  end
  return false, false -- Do nothing
end

function offload()
  print("Offloading...")
  turtle.turnLeft()
  turtle.turnLeft()
  local skipped = false
  for i = 1, 16 do 
    local item_data = turtle.getItemDetail(i)
    if item_data then -- make sure that there is actual item data
      if (item_data.name == PLANT and skipped == false) then -- Skip first plant stack
        skipped = true
      else
        turtle.select(i)
        if turtle.refuel(0) == false then -- Dump non fuel
          turtle.drop()
        end
      end
    end
  end
  turtle.turnLeft()
  turtle.turnLeft()
end
-- USER ALTERATIONS HERE
------------------------------------------------

-- SHARED VARS
LAST_IS_ANTI = true -- Assuming you start in the front left
-- SHARED VARS
------------------------------------------------

-- CORE FUNCTIONS
function clockwise()
  -- OVERRIDE ACTION HERE
  override()
  -- OVERRIDE ACTION HERE 
  turtle.turnRight()
  turtle.forward()
  turtle.turnRight()
end

function anti_clockwise()
  -- OVERRIDE ACTION HERE
  override()
  -- OVERRIDE ACTION HERE
  turtle.turnLeft()
  turtle.forward()
  turtle.turnLeft()
end

function return_home()
  if (LAST_IS_ANTI == true) then
    turtle.turnLeft()
    while(not(turtle.detect())) do
      turtle.forward()
    end
    turtle.turnLeft()
    while(not(turtle.detect())) do
      turtle.forward()
    end
    turtle.turnLeft()
    turtle.turnLeft()
  else -- Not anti
    turtle.turnRight()
    while(not(turtle.detect())) do
      turtle.forward()
    end
    turtle.turnRight()
    -- while(not(turtle.detect())) do
    --   turtle.forward()
    -- end
    -- turtle.turnLeft()
    -- turtle.turnLeft()
  end
end

function move_till_detect()
  while(not(turtle.detect())) do
    -- OVERRIDE ACTION HERE
    override()
    -- OVERRIDE ACTION HERE
    turtle.forward()
  end
  return turtle.inspect()
end

function main()
  refuel()
  -- Move and perform OVERRIDE ACTION
  local success, data = move_till_detect()
  -- clockwise
  if (data.name == CLOCK) then
    LAST_IS_ANTI = false
    clockwise()
    main()
  -- anti clockwise
  elseif (data.name == ANTICLOCK) then
    LAST_IS_ANTI = true
    anti_clockwise()
    main()
  -- home
  else
    -- OVERRIDE ACTION HERE
    override()
    -- OVERRIDE ACTION HERE
    return_home()
    if OFFLOAD == true then offload() end
    print('Circuit complete!')
  end
end

function refuel()
    for i = 1, 16 do
      local item_data = turtle.getItemDetail(i)
      if item_data then -- make sure that there is actual item data
        turtle.select(i)
        if turtle.refuel(0) then
            turtle.refuel(turtle.getItemCount(i))
        end
      end
    end
    turtle.select(1)
end

-- CORE FUNCTIONS
------------------------------------------------
print("Starting circuit!")
main()
if RUN_FOREVER == true then 
  while true do
    print("Sleeping...")
    os.sleep(WAIT_TIME)
    print("Starting circuit!")
    main()
  end
end
