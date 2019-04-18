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

--- 马甲单位施放技能
--- @param tab {producer unit, target unit, point point, unit_id number|string, ability_id number, ability_level number, order_id number, lifetime number, shown boolean}
function base.dummy_issue_order(tab)
    local point = tab.point or tab.target:get_point()
    local dummy = tab.producer:get_owner():create_dummy(tab.unit_id or 'e009', point)
    dummy.producer = tab.producer
    dummy:show(not not shown)
    if tab.ability_id then
        dummy:add_ability(tab.ability_id, tab.ability_level or 1)
    end
    if tab.order_id then
        dummy:issue_order(tab.order_id)
        dummy:issue_order(tab.order_id, tab.target)
        dummy:issue_order(tab.order_id, point)
    end
    dummy:set_lifetime(tab.lifetime or 20)
end

--- 触发被动技能
--- @param params {attacker:unit, attacked:unit, spell_id:string, shadow_id:string, order_id:number, possibility:number, mana_cost:number}
--- @return boolean
function base.triggerPassive(params)
    if params.attacker:has_ability(params.spell_id) and params.attacker:get_mana() >= params.mana_cost then
        local p = params.attacker:get_owner()
        if jass.GetRandomInt(0, 100) <= params.possibility then
            base.dummy_issue_order({
                producer = params.attacker,
                target = params.attacked,
                ability_id = params.shadow_id,
                order_id = params.order_id,
                ability_level = params.attacker:get_ability_level(params.spell_id)
            })
            params.attacker:set_mana(params.attacker:get_mana() - params.mana_cost)
            p.luck = p.luck - 5
            return true
        else
            p.luck = p.luck + 1
            return false
        end
    end
    return false
end

--- 判断值是否存在于表中
--- @param value any
--- @param tab table
function base.is_include(value, tab)
    for _, v in ipairs(tab) do
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
    local profound
    for k, v in pairs(kungfu.profound) do
        if (base.is_include(ability_id, v)) then
            profound = k
        end
    end
    if profound then
        local heroes = et.tower.hero_towers[p]
        for _, v in ipairs(heroes) do
            if v.unit:has_ability(profound) then
                return math.floor(v.reputation / 100) * 0.1
            end
        end
    end
    return 0
end

--- 被动技能伤害公式，计算当前技能伤害 伤害控制在50~10000
--- @param source unit 造成伤害的单位
--- @param target unit 受到伤害的单位
--- @param ability_id string 技能ID
function base.damageFormula(source, target, ability_id, default_base_damage)
    if source:is_dummy() then
        source = source.producer
    end
    -- 伤害基数
    local base_damage = default_base_damage or 50
    -- 单位等级加成
    local level_addition = source:get_level() / 100 or 0
    -- 技能等级 按功勋升级
    local ability_level = source:get_ability_level(ability_id) or 1
    -- 英雄加成
    local hero_addition = source:is_hero() and 1 or 0
    -- 额外加成（门派秘学、武器、武学搭配）
    local addition = getProfoundAddition(source:get_owner(), ability_id) or 0
    log.debug(('触发了技能：%s，伤害公式参数为：\n基础伤害：%s\n等级加成：%s\n技能等级：%s\n英雄加成：%s\n额外加成：%s')
            :format(jass.GetObjectName(base.string2id(ability_id)) or '', base_damage or '', level_addition or '', ability_level or '', hero_addition or '', addition or ''))
    local damage = base_damage * ability_level * (1 + level_addition + hero_addition + addition)
    return damage
end

--- @param source unit
--- @param target unit
--- @param damage number
--- @param critical boolean
function base.apply_damage(source, target, damage, critical)
    if damage == 0 then
        et.tag.create("MISS", target:get_point(), 11, 0, 255, 0, 0, 30, 0.65, 400, base.random(80, 100))
        return
    end
    if critical then
        et.tag.create(math.floor(damage), target:get_point(), 14, 0, 100, 100, 0, 30, 0.65, 400, base.random(80, 100))
    else
        et.tag.create(math.floor(damage), target:get_point(), 11, 0, 100, 100, 100, 30, 0.65, 400, base.random(80, 100))
    end
    jass.UnitDamageTarget(source.handle, target.handle, damage, true, false, jass.ATTACK_TYPE_MAGIC, jass.DAMAGE_TYPE_NORMAL, jass.WEAPON_TYPE_WHOKNOWS)
end

function base.float_equal(x, v)
    local EPSILON = 0.000001
    return ((v - EPSILON) < x) and (x < (v + EPSILON))
end

function base.random(m, n)
    return jass.GetRandomReal(m, n)
end

function base.random_int(m, n)
    return jass.GetRandomInt(m, n)
end

--- 被动技能范围伤害
--- @param params {attacker unit, attacked unit, spell_id string, range number, damage number, effect string, possibility number, mana_cost number }
function base.passiveRangeDamage(params)
    local p = params.attacker:get_owner()
    if base.random(0, 100) <= params.possibility and params.attacker:get_mana() >= params.mana_cost then
        params.attacker:set_mana(params.attacker:get_mana() - params.mana_cost)
        local g = et.selector():in_range(params.attacked:get_point(), params.range):is_enemy(params.attacker):get()
        for _, u in ipairs(g) do
            base.apply_damage(params.attacker, u, params.damage)
            et.effect.add_to_point(params.effect, u:get_point()):destroy()
        end
        p.luck = p.luck - 5
    else
        p.luck = p.luck + 5
    end
end





