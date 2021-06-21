-- CONSUME ALL FUEL AND RETURN TO SLOT 1
---------------------------------------------------

for i = 1, 16 do
    turtle.select(i)
    if turtle.refuel(0) then
        turtle.refuel(turtle.getItemCount(i))
    end
end

turtle.select(1)