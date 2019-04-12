local jass = require 'jass.common'

local stone = {}

--- 杀怪掉落武魂石
--- 1. 掉落物品
--- 2. 福缘减少
local function registerDropStone()
    local t = jass.CreateTrigger()
    jass.TriggerRegisterPlayerUnitEvent(t, ATTACKER_PLAYER, jass.EVENT_PLAYER_UNIT_DEATH, nil)
    jass.TriggerAddAction(t, function()
        local u = jass.GetTriggerUnit()
        ---@type player
        local p = et.player(jass.GetOwningPlayer(u))
        if jass.GetRandomInt(0, 1000) < p.luck then
            -- TODO 修改掉落表
            local drop_table = {
                AAAA = 20,
                BBBB = 20,
                CCCC = 20,
                DDDD = 20
            }
            local it = jass.CreateItem(base.string2id(base.getRandomDropFromTable(drop_table)), jass.GetUnitX(u), jass.GetUnitY(u))
            local id = base.id2string(jass.GetItemTypeId(it))
            local level = base.getItemLevel(id)
            p.luck = p.luck - level * 100
            p.luck = p.luck > 0 and p.luck or 0
        end
    end)
end

--- 武魂石变为塔的物品
local function registerStoneToTowerItem()

end

local function init()
    registerDropStone()
    registerStoneToTowerItem()
end

init()
return stone
