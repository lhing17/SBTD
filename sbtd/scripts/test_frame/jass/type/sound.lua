---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by G_Seinfeld.
--- DateTime: 2018/11/5 10:46
---
local common_util = require 'jass.util.common_util'
local sound = {}
setmetatable(sound, sound)

local mt = {}
sound.__index = mt

mt.filename = 'sound.mp3'
mt.label = '声音'
mt.fade_in_rate = 20
mt.fade_out_rate = 20
mt.looping = false
mt._3D = false
mt.stop_when_out_of_range = false
mt.eax_setting = ''

mt.duration = 60

mt.channel = 1

mt.volume = 100

mt.pitch = 1.0

mt.x = 0
mt.y = 0
mt.z = 0

function sound:__tostring()
    return self.label
end

function mt:set_label(label)
    self.label = label
end

function mt:set_duration(duration)
    self.duration = duration
end

function mt:set_channel(channel)
    self.channel = channel
end

function mt:set_volume(volume)
    self.volume = volume
end

function mt:set_pitch(pitch)
    self.pitch = pitch
end

function mt:set_position(x, y, z)
    self.x = x
    self.y = y
    self.z = z
end

function sound.create(filename, label, looping, is3D, stop_when_out_of_range, fade_in_rate, fade_out_rate, eax_setting)
    local s = {}
    setmetatable(s, sound)
    s.handle_id = common_util.generate_handle_id()
    s.filename = filename
    s.label = label
    s.looping = looping
    s._3D = is3D
    s.stop_when_out_of_range = stop_when_out_of_range
    s.fade_in_rate = fade_in_rate
    s.fade_out_rate = fade_out_rate
    s.eax_setting = eax_setting
    return s
end

return sound