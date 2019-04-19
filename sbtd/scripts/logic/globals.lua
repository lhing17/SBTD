---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by G_Seinfeld.
--- DateTime: 2019/4/12 14:25
---

-----------------------
--- 配置参数
-----------------------

--- 失败时圈内怪物数量
FAIL_COUNT = 100

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

-- towers.hero = { 'I02E', 'I02N', 'I02O', 'I02W', 'I036', 'I037', 'I038' } -- 英雄塔物品ID
towers.hero = { 'I02W' } -- 英雄塔物品ID

-- 塔的技能表
towers.abilities = {
    n00A = {},
    n029 = {},
    n02A = {},
    n02B = {},
    n02C = {},
    n02D = {},
    n02E = {},
    N00G = {},
}

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

--- 技能与order对照表，用于自动施法
ORDER_LOOKUP = {
    A02I = 0xD0080, -- 太祖长拳
    A02R = 0xD00DE, -- 铜锤手
    A02S = 0xD007F, -- 铜锤手马甲
    A031 = 0xD006B, -- 丐帮心法
    A032 = 0xD0251, -- 降龙十八掌
    A033 = 0xD024C, -- 降龙十八掌马甲
    A02M = 0xD006B, -- 莲花掌
    A02N = 0xD00DE, -- 青竹镖

}

--- 万能属性系统的奖励类型
BONUS_TYPE = {
    LIFE = 0,
    MANA = 1,
    ARMOR = 2,
    ATTACK = 3,
}
