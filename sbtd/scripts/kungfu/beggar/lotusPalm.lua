---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by G_Seinfeld.
--- DateTime: 2019/4/19 8:31
---

--- 莲花掌
--- @param u unit
--- @param id number
--- @param target unit|item|point|nil
et.game:event '单位-技能生效'(function(self, u, id, target)
    if id == base.string2id('A02M') then
        local g = et.selector():in_range(u:get_point(), 800):is_enemy(u):get()
        for _, v in ipairs(g) do
            base.dummy_issue_order({
                producer = u,
                target = v,
                ability_id = 'A02L',
                order_id = 0xD0207,
                ability_level = u:get_ability_level(id)
            })
        end
    end
end)
