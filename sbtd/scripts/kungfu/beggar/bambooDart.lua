---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by G_Seinfeld.
--- DateTime: 2019/4/19 8:45
---

--- 青竹镖
--- @param u unit
--- @param id number
--- @param target unit|item|point|nil
et.game:event '单位-技能生效'(function(self, u, id, target)
    if id == base.string2id('A02N') then
        base.dummy_issue_order({
            producer = u,
            target = target,
            ability_id = 'A02O',
            order_id = 0xD007F,
            ability_level = u:get_ability_level(id)
        })
    end
end)
--- 青竹镖伤害
--- @param source unit
--- @param target unit
--- @param damage number
et.game:event '单位-受到伤害'(function(self, source, target, damage)
    if base.float_equal(damage, 0.14) then
        local real_damage = base.damageFormula(source, target, 'A02N',500)
        base.apply_damage(source, target, real_damage)
    end
end)
