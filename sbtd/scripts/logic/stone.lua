local jass = require 'jass.common'

local stone = {}
local ATTACKER_PLAYER = jass.Player(5)

local function getRandomDropFromTable(drop_table)
    local total = 100
    for id, possibility in pairs(drop_table) do
        if (jass.GetRandomInt(0, total) < possibility) then
            return base.string2id(id)
        end
        total = total - possibility
    end
    return 0
end

--- 杀怪掉落武魂石
function stone.registerDropStone()
    local t = jass.CreateTrigger()
    jass.TriggerRegisterPlayerUnitEvent(t, ATTACKER_PLAYER, jass.EVENT_PLAYER_UNIT_DEATH, nil)
    jass.TriggerAddAction(t, function()
        local u = jass.GetTriggerUnit()
        local drop_table = {
            AAAA = 20,
            BBBB = 20,
            CCCC = 20,
            DDDD = 20
        }
        jass.CreateItem(getRandomDropFromTable(drop_table), jass.GetUnitX(u), jass.GetUnitY(u))
    end)
end
return stone
