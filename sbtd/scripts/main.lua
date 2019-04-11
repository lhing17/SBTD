require 'scripts.utility'
require 'scripts.native'
require 'scripts.runtime'

local console = require 'jass.console'

console.write("hello juezhan")

-- 塔
towers = {}

towers.junior = {} -- 初级塔
towers.intermediate = {} -- 中级塔
towers.senior = {} -- 高级塔
towers.hero = {} -- 英雄塔
