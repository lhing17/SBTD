---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by G_Seinfeld.
--- DateTime: 2019/4/16 10:46
---

local base = {}
--- 根据掉落表获取随机掉落的物品ID
--- @param drop_table table<string|table, number> 掉落表
--- @return number 物品ID
function base.getRandomDropFromTable(drop_table)
    local total = 100
    for id, possibility in pairs(drop_table) do
        if (math.random(0, total) < possibility) then
            if type(id) == 'string' then
                return id
            elseif type(id) == 'table' then
                return base.getRandomDropFromTable(id)
            end
        end
        total = total - possibility
    end
    return 0
end
local drop_table = {
    I01Z = 25,
    I020 = 25,
    I021 = 25,
    I022 = 25
}

local result = base.getRandomDropFromTable(drop_table)
print(result)

local i = 0xD026B
print(i)
