---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lhing17.
--- DateTime: 2018/11/2 9:47
---

local common_util = require 'jass.util.common_util'
local rect = {}

--- @class j_rect
local mt = {}
rect.__index = mt

mt.type = 'rect'
mt.min_x = -1024
mt.max_x = 1024
mt.min_y = -1024
mt.max_y = 1024

function rect:__tostring()
    return self.min_x .. ',' .. self.min_y .. ',' .. self.max_x ..',' .. self.max_y
end

function mt:contains_unit(u)
    return u:get_x() > self.min_x and u:get_x() < self.max_x and u:get_y() > self.min_y and u:get_y() < self.max_y
end

function mt:remove()
    rect[self.handle_id] = nil
end

function mt:set(min_x, min_y, max_x, max_y)
    self.min_x = min_x
    self.min_y = min_y
    self.max_x = max_x
    self.max_y = max_y
end

function mt:move_to(center_x, center_y)
    local delta_x = center_x - (self.min_x + self.max_x) / 2
    local delta_y = center_y - (self.min_y + self.max_y) / 2
    self.min_x = self.min_x + delta_x
    self.min_y = self.min_y + delta_y
    self.max_x = self.max_x + delta_x
    self.max_y = self.max_y + delta_y
end

function mt:get_center_x()
    return (self.min_x + self.max_x) / 2
end
function mt:get_center_y()
    return (self.min_y + self.max_y) / 2
end

function mt:get_min_x()
    return self.min_x
end

function mt:get_min_y()
    return self.min_y
end

function mt:get_max_x()
    return self.max_x
end

function mt:get_max_y()
    return self.max_y
end

function rect.create(min_x, min_y, max_x, max_y)
    local r = setmetatable({}, rect)
    r.handle_id = common_util.generate_handle_id()
    r.min_x = min_x
    r.min_y = min_y
    r.max_x = max_x
    r.max_y = max_y
    rect[r.handle_id] = r
    return r
end

return rect