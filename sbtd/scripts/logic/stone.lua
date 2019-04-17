local jass = require 'jass.common'

local stone = {}

--- 杀怪掉落武魂石
--- 1. 掉落物品
--- 2. 福缘减少
local function registerDropStone()
    log.debug("登记杀怪掉落武魂石的函数")
    ---@param killer unit
    ---@param killed unit
    et.game:event '单位-死亡'(function(game, killer, killed)
        if not killer then
            return
        end
        local p = killer:get_owner()
        -- TODO 修改掉落表
        local drop_table = {
            I01Z = 25,
            I020 = 25,
            I021 = 25,
            I022 = 25
        }
        if jass.GetRandomInt(0, MAX_LUCK) <= p.luck then
            local item = et.item:new(base.getRandomDropFromTable(drop_table), killed:getX(), killed:getY())
            p:send_message('人品爆发，杀怪掉落了物品：' .. item:get_name())
            -- 福缘减少
            p.luck = p.luck - base.getItemLevel(item) * 100
            p.luck = p.luck > 0 and p.luck or 0
        else
            p.luck = p.luck + 1
        end
    end)
end

--- 武魂石变为塔的物品
local function registerStoneToTowerItem()
    log.debug('登记武魂石变为塔的函数')
    --- @param u unit
    --- @param it item
    et.game:event '单位-使用物品'(function(game, u, it)
        log.debug(('%s|%s'):format(tostring(u), tostring(it)))
        -- 武魂石对应塔的级别
        local level_table = {
            I01Z = 'junior',
            I020 = 'normal',
            I021 = 'senior',
            I022 = 'hero'
        }
        -- 点击对应级别的武魂石变成塔
        local id = it:get_id()
        if level_table[base.id2string(id)] then
            local tower_list = towers[level_table[base.id2string(id)]]
            local index = jass.GetRandomInt(1, #tower_list)
            u:add_item(tower_list[index])
        end
    end)
end

--- 登记赌博武魂石的事件
local function registerGambleStone()
    log.debug('登记赌博武魂石的函数')
    --- @param u unit 单位
    ---@param it item 捡起的物品
    et.game:event '单位-捡起物品'(function(self, u, it)
        if it:get_id() == base.string2id('I03A') then
            local drop_table = {
                I01Z = 40,
                I020 = 30,
                I021 = 20,
                I022 = 10
            }
            u:add_item(base.getRandomDropFromTable(drop_table))
        end
    end)
end

local function init()
    registerDropStone()
    registerStoneToTowerItem()
    registerGambleStone()
end
init()
return stone
