---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by G_Seinfeld.
--- DateTime: 2019/4/16 14:13
---

--- 杀怪加声望
---@param killer unit
---@param killed unit
et.game:event '单位-死亡'(function(self, killer, killed)
    -- TODO 杀小兵和英雄加的声望数不同
    if killed:get_owner() == ATTACKER_PLAYER and et.tower.all_towers[killer] then
        --- @type tower
        local tower = et.tower.all_towers[killer]
        tower.reputation = tower.reputation + 1
    end
end)