---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by G_Seinfeld.
--- DateTime: 2019/4/19 8:50
---

--- 六合刀法
--- @param source unit 攻击方
--- @param target unit 受攻击方
et.game:event '单位-受攻击'(function(self, source, target)
    local p = source:get_owner()
    base.triggerPassive({
        attacker = source,
        attacked = target,
        spell_id = 'A02Q',
        shadow_id = 'A02P',
        order_id = 0xD00A0,
        possibility = p.luck / 50 + 10,
        mana_cost = 50
    })
end)