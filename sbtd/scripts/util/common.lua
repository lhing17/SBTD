base = base or {}
local jass = require 'jass.common'

--- 根据掉落表获取随机掉落的物品ID
--- @param drop_table table<string|table, number> 掉落表
--- @return string 物品ID
function base.getRandomDropFromTable(drop_table)
    local total = 100
    for id, possibility in pairs(drop_table) do
        if (jass.GetRandomInt(0, total) < possibility) then
            if type(id) == string then
                return id
            elseif type(id) == table then
                return base.getRandomDropFromTable(id)
            end
        end
        total = total - possibility
    end
    return 0
end

--- 获取物品等级
--- @param id string 物品ID
--- @return number 物品等级
function base.getItemLevel(id)
    return ITEM_LOOKUP[id] or 1
end