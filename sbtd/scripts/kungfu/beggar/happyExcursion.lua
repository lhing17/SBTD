---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by G_Seinfeld.
--- DateTime: 2019/4/18 18:44
---


--逍遥游
--- @param source unit 攻击方
--- @param target unit 受攻击方
et.game:event '单位-受攻击'(function(self, source, target)
    local p = source:get_owner()
    base.triggerPassive({
        attacker = source,
        attacked = target,
        spell_id = 'A02Y',
        shadow_id = 'A02X',
        order_id = 0xD0216,
        possibility = p.luck / 50 + 7,
        mana_cost = 40
    })
end)