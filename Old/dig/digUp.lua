-- DIGS STRAIGHT UP AND RETURNS
---------------------------------------------------

print("FUEL: " .. turtle.getFuelLevel())
TARGET_HEIGHT = tonumber(read())
HEIGHT = 0

-- GO UP AND DIG
while(HEIGHT < tonumber(TARGET_HEIGHT)) do
    turtle.digUp()
    turtle.up()
    HEIGHT = HEIGHT + 1
end

-- COME BACK DOWN
while(HEIGHT > 0) do
   turtle.down()
   HEIGHT = HEIGHT - 1 
end

