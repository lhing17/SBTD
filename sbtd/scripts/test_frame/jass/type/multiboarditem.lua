---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by G_Seinfeld.
--- DateTime: 2018/11/17 0017 10:21
---

local common_util = require 'jass.util.common_util'
local multiboarditem = {}
multiboarditem.all_items = {}

local mt = {}
multiboarditem.__index = mt
mt.type = 'multiboarditem'
mt.row = 0
mt.column = 0
mt.value = ''
mt.value_color = {128, 128, 128, 128}
mt.icon = ''
mt.show_value = true
mt.show_icon = true
mt.width = 0.05

function mt:set_style(show_value, show_icon)
    self.show_value = show_value
    self.show_icon = show_icon
end

function mt:set_value(value)
    self.value = value
end

function mt:set_icon(icon)
    self.icon = icon
end

function mt:set_width(width)
    self.width = width
end

function mt:set_value_color(r, g, b, a)
    self.value_color = {r, g, b, a}
end

function mt:destroy()
    multiboarditem.all_items[self.handle_id] = nil
end

function mt:release()
    self.loader:release_item(self)
end

function multiboarditem.create(mb, row, column)
    local mbi = setmetatable({}, multiboarditem)
    mbi.handle_id = common_util.generate_handle_id()
    mbi.row = row
    mbi.column = column
    mbi.loader = mb
    mbi.show_value = mb.items_show_value
    mbi.show_icon = mb.items_show_icon
    mbi.value = mb.items_value
    mbi.value_color = mb.items_value_color
    mbi.icon = mb.items_icon
    mbi.width = mb.items_width
    multiboarditem.all_items[mbi.handle_id] = mbi
    return mbi
end

return multiboarditem