---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by G_Seinfeld.
--- DateTime: 2019/4/19 10:16
---

--- 当圈内敌人大于指定数值时失败
et.loop(10 * 1000, function()
    --- @param u unit
    local filter = function(u)
        return u:get_owner() == ATTACKER_PLAYER and u:is_alive() and u:get_type_id() == FINAL_BOSS_ID
    end
    local count = GAME_AREA:get_unit_count(filter)
    log.debug(('当前圈内最终BOSS数为%s'):format(count))
    if count <= 0 then
        force.send_message(("|CFFFF00B2碧血沙场%s的游戏总评分：%s分（胜利）"):format(base.version, GAME_POINT))
        force.send_message("|CFFFF00B2恭喜你们通关，游戏将在1分钟后结束\n游戏交流QQ群：1009188209\n关注武侠，让碧血沙场走得更远，期待你的参与，详情请在QQ群内交流")
        et.wait(60 * 1000, function()
            force.victory()
        end)
    end
end)