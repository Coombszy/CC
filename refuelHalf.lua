-- CONSUME HALF OF ALL FUEL AND RETURN TO SLOT 1
---------------------------------------------------

for i = 1, 16 do
    turtle.select(i)
    if turtle.refuel(0) then
        local halfStack = math.ceil(turtle.getItemCount(i)/2)
        turtle.refuel(halfStack)
    end
end

turtle.select(1)