base = base or {}
local jass = require 'jass.common'

--- 根据掉落表获取随机掉落的物品ID
--- @param drop_table table<string|table, number> 掉落表
--- @return number 物品ID
function base.getRandomDropFromTable(drop_table)
    local total = 100
    for id, possibility in pairs(drop_table) do
        log.debug(('获取随机物品，概率为:%s, 总概率为:%s'):format(possibility, total))
        if (jass.GetRandomInt(0, total) < possibility) then
            if type(id) == 'string' then
                return base.string2id(id)
            elseif type(id) == 'table' then
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

--- 触发被动技能
--- @param params {attacker:unit, attacked:unit, spell_id:string, shadow_id:string, order_id:number, possibility:number, mana_cost:number}
--- @return boolean
function base.triggerPassive(params)
    if jass.GetRandomInt(0, 100) <= params.possibility and params.attacker:has_ability(params.spell_id) and params.attacker:get_mana() >= params.mana_cost then
        local p = params.attacker:get_owner()
        local dummy = p:create_unit('e009', params.attacker)
        dummy:show(false)
        dummy:add_ability(params.shadow_id, params.attacker:get_ability_level(params.spell_id))
        dummy:issue_order(params.order_id)
        dummy:issue_order(params.order_id, params.attacked)
        dummy:issue_order(params.order_id, params.attacked:get_point())
        dummy:set_lifetime(20)
        params.attacker:set_mana(params.attacker:get_mana() - params.mana_cost)
        p.luck = p.luck - 5
        return true
    end
    p.luck = p.luck + 1
    return false
end

--- 被动技能伤害公式，计算当前技能伤害 伤害控制在50~10000
--- @param source unit 造成伤害的单位
--- @param target unit 受到伤害的单位
--- @param ability_id string 技能ID
function base.passiveDamageFormula(source, target, ability_id)
    -- 伤害基数
    local base_damage = 50
    -- 单位等级加成
    local level_addition = 1 + source:get_level() / 500
    -- 技能等级 按功勋升级
    local ability_level = source:get_ability_level(ability_id)
    -- 英雄加成
    local hero = source:is_hero() and 2 or 1
    -- 额外加成（门派秘学、武器、武学搭配）
    local addition = 0

end



