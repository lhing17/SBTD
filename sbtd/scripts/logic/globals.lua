---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by G_Seinfeld.
--- DateTime: 2019/4/12 14:25
---

-----------------------
--- 配置参数
-----------------------

--- 失败时圈内怪物数量
FAIL_COUNT = 20

--- 游戏区域
GAME_AREA = et.rect.new(-4224, -4160, 4256, 4192)
--- 各玩家游戏开始点
GAME_START_POINT = {
    et.point(-2290, 1500),
    et.point(-1670, -2300),
    et.point(2290, -1500),
    et.point(1670, 2300),
}

--- 游戏难度 1-简单 2-中等 3-困难 4-自虐
GAME_DIFFICULTY = 1 --默认难度为简单
GAME_DIFFICULTY_TEXT = { '简单', '中等', '困难', '自虐' }

--- 最大福缘
MAX_LUCK = 5000

-----------------------
--- 防御塔相关
-----------------------
--- 塔表
towers = {}

towers.junior = { 'I027', 'I028', 'I02F', 'I02G', 'I02P', 'I02Q', 'I02R', 'I02X', 'I02Y' } -- 初级塔物品ID

towers.normal = { 'I029', 'I02A', 'I02B', 'I02H', 'I02I', 'I02J', 'I02S', 'I02T', 'I02Z', 'I030', 'I031', 'I032', 'I033' } -- 中级塔物品ID

towers.senior = { 'I02C', 'I02D', 'I02K', 'I02L', 'I02M', 'I02U', 'I02V', 'I034', 'I035' } -- 高级塔物品ID

towers.hero = { 'I02E', 'I02N', 'I02O', 'I02W', 'I036', 'I037', 'I038' } -- 英雄塔物品ID

-----------------------
--- 玩家常量
--------------------------

-- 进攻怪的玩家
ATTACKER_PLAYER = et.player[6]

--- 物品等级表
--- @type table<string, number>
ITEM_LOOKUP = {
    I01Z = 1,
    I020 = 2,
    I021 = 3,
    I022 = 4,
}