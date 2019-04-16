---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lhing17.
--- DateTime: 2019/4/15 14:35
---

require 'logic.globals'
require 'logic.stone'
require 'logic.fail'
require 'logic.gift'
require 'logic.check'

-- 玩家1选择游戏难度
local function selectDifficulty()
    et.wait(1000, function()
        et.dialog.create(et.player[1], '请选择游戏难度', GAME_DIFFICULTY_TEXT)
        --- @param b j_button
        ---@param d dialog
        ---@param p player
        et.game:event '对话框-按钮点击'(function(self, b, d, p)
            log.debug('点击了对话框按钮' .. jass.GetHandleId(b))
            for i = 1, #GAME_DIFFICULTY_TEXT do
                if b == d.buttons[GAME_DIFFICULTY_TEXT[i]] then
                    force.send_message(("玩家一选择%s难度"):format(GAME_DIFFICULTY_TEXT[i]))
                    GAME_DIFFICULTY = i
                end
            end
        end)
    end)
end

-- 初始化玩家工人、玩家人口等
local function initWorkers()
    for i = 1, et.player.countAlive() do
        -- TODO 修改工人的ID
        local worker = et.player[i]:create_unit('u00C', GAME_START_POINT[i])
        worker:add_item('I039')
        -- 设置初始人口
        et.player[i]:set_food(30)
    end
end

local function init()
    force.send_message('等待玩家一选择难度')
    selectDifficulty()
    initWorkers()
end

init()

