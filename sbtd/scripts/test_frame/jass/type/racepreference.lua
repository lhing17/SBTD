---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by G_Seinfeld.
--- DateTime: 2018/11/06 11:47
---

local racepreference = {}

local mt = {}
racepreference.__index = mt

mt.type = 'racepreference'
mt.name = ''

function racepreference.init()
	local racepreference_names={}
	for i = 1, #racepreference_names do
		local ra = {}
		ra.name = racepreference_names[i]
		setmetatable(ra, racepreference)
		table.insert(racepreference, ra)
	end
end

return racepreference