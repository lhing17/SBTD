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

--- 判断值是否存在于表中
--- @param value any
--- @param tab table
function base.is_include(value, tab)
    for _,v in ipairs(tab) do
        if v == value then
            return true
        end
    end
    return false
end


--- 获取某玩家奥义对某技能的加成
--- @param p player 某玩家
--- @param ability_id string 技能ID
local function getProfoundAddition(p, ability_id)
    for k, v in pairs(kungfu.profound) do
        
    end
end

--- 被动技能伤害公式，计算当前技能伤害 伤害控制在50~10000
--- @param source unit 造成伤害的单位
--- @param target unit 受到伤害的单位
--- @param ability_id string 技能ID
function base.passiveDamageFormula(source, target, ability_id)
    -- 伤害基数
    local base_damage = 50
    -- 单位等级加成
    local level_addition = source:get_level() / 100
    -- 技能等级 按功勋升级
    local ability_level = source:get_ability_level(ability_id)
    -- 英雄加成
    local hero_addition = source:is_hero() and 1 or 0
    -- 额外加成（门派秘学、武器、武学搭配）
    local addition = 0

    local damage = base_damage * ability_level * (1 + level_addition + hero_addition + addition)
    return damage

end

--- @param source unit
--- @param target unit
--- @param damage number
--- @param critical boolean
function base.apply_damage(source, target, damage, critical)
    if damage == 0 then
        et.tag.create("MISS", target:get_point(), 11, 0, 255, 0, 0, 30, 0.65, 400, commonutil.random(80, 100))
        return
    end
    if critical then
        et.tag.create(math.floor(damage), target:get_point(), 14, 0, 100, 100, 0, 30, 0.65, 400, commonutil.random(80, 100))
    else
        et.tag.create(math.floor(damage), target:get_point(), 11, 0, 100, 100, 100, 30, 0.65, 400, commonutil.random(80, 100))
    end
    jass.UnitDamageTarget(source.handle, target.handle, damage, true, false, jass.ATTACK_TYPE_MAGIC, jass.DAMAGE_TYPE_NORMAL, jass.WEAPON_TYPE_WHOKNOWS)
end



