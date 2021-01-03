TO_KEEP = { "shard", "ore", "diamond", "gem", "dust", "lapis", "crystal", "redstone" }

for i = 1, 16 do
    if(turtle.getItemCount(i) > 0) then
        keepMe = false
        for index,keyword in pairs(TO_KEEP) do
            if (not(string.find(turtle.getItemDetail(i)["name"], keyword) == nil)) then
                keepMe = true
            end
        end
        if(not keepMe) then
            turtle.select(i)
            turtle.drop()
        end
    end
end

turtle.select(1)