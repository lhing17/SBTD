---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by G_Seinfeld.
--- DateTime: 2019/4/11 19:47
---

local tower = {}
tower.all_towers = {}
tower.hero_towers = {}
et.tower = tower

---@class tower
local mt = {}
tower.__index = mt

--- @type unit
mt.unit = nil

--- @type number 声望
mt.reputation = 0

function tower:__tostring()
    return ('%s'):format(self.id)
end

--- 创建塔
--- @param u unit
--- @return tower
function tower.create(u)
    local t = setmetatable({}, tower)
    t.unit = u
    tower.all_towers[t.unit] = t
    if u:is_hero() then
        tower.hero_towers[u:get_owner()] = tower.hero_towers[u:get_owner()] or {}
        table.insert(tower.hero_towers[u:get_owner()], t)
    end
    return t
end

--- 创建塔的对象
--- @param u unit
--- @param r rect
et.game:event '单位-进入区域'(function(game, u, r)
    -- TODO 增加是不是塔的判断
    if r == GAME_AREA and u:get_owner():is_player() then
        tower.create(u)
    end
end)