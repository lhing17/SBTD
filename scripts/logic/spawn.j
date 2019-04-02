/*********************
 * 刷怪相关逻辑
 ********************/
globals
    region array nodes // 怪物移动的节点
    rect array nodeRects 
    constant integer NODE = 0xFFEE
    hashtable YDHT = InitHashtable()
endglobals

/**
 * 向哈希表中注册下一个可能的节点，最少有一个可能节点，多有三个可能节点，假设哈希表为全局变量
 * @param whichNode 要注册的节点
 * @param choice0 第一个可能节点
 * @param choice1 第二个可能节点
 * @param choice2 第三个可能节点
 */
function registerNextNodeChoice takes region whichNode, region choice0, region choice1, region choice2 returns nothing
    call SaveRegionHandle(YDHT, GetHandleId(whichNode), 0, choice0)
    if choice1 != null then
        call SaveRegionHandle(YDHT, GetHandleId(whichNode), 1, choice1)
    endif
    if choice2 != null then
        call SaveRegionHandle(YDHT, GetHandleId(whichNode), 2, choice2)
    endif
endfunction

/*
 * 从两个区域中随机选择一个
 */
function getRandomRegion takes region choice0, region choice1 returns region
    if choice1 == null or GetRandomInt(0, 100) <= 50 then
        return choice0
    endif
    return choice1
endfunction

/* 
 * 刷怪逻辑中获取下一个区域
 * @param currentNode 当前进入的区域
 * @param previousNode 单位来源的区域
 */
function chooseNextNodeForRegion takes region currentNode, region previousNode returns region
    local region choice0 = LoadRegionHandle(YDHT, GetHandleId(currentNode), 0)
    local region choice1 = LoadRegionHandle(YDHT, GetHandleId(currentNode), 1)
    local region choice2 = LoadRegionHandle(YDHT, GetHandleId(currentNode), 2)
    if previousNode == null then
        return choice0
    endif
    if GetHandleId(choice0) == GetHandleId(previousNode) then
        return getRandomRegion(choice1, choice2)        
    endif
    if GetHandleId(choice1) == GetHandleId(previousNode) then
        return getRandomRegion(choice0, choice2)        
    endif
    if choice2 != null and GetHandleId(choice2) == GetHandleId(previousNode) then
        return getRandomRegion(choice0, choice1)
    endif
    return choice0
endfunction

/**
 * 移动到下一个节点
 */
function moveToNextNode takes unit whichUnit, region whichNode returns nothing
    local rect r = LoadRectHandle(YDHT, GetHandleId(whichNode), 0)
    call IssuePointOrderById(whichUnit, 0xD0012, GetRectCenterX(r), GetRectCenterY(r))
    set r = null
endfunction

function isEnemy takes nothing returns boolean
    return IsUnitEnemy(GetTriggerUnit(), Player(0))
endfunction

function chooseNextNode takes nothing returns nothing
    local region currentNode = GetTriggeringRegion()
    local unit u = GetEnteringUnit()
    local region previousNode = LoadRegionHandle(YDHT, GetHandleId(u), NODE)
    local region nextNode = chooseNextNodeForRegion(currentNode, previousNode)
    call moveToNextNode(u, nextNode)
    call SaveRegionHandle(YDHT, GetHandleId(u), NODE, currentNode)
    set currentNode = null
    set u = null
    set previousNode = null
    set nextNode = null
endfunction

function initSpawn takes nothing returns nothing
    local trigger t = null
    // 为nodes初始化
    local integer i = 1
    loop
        exitwhen i >= 24
        set nodes[i] = CreateRegion()
        call RegionAddRect(nodes[i], nodeRects[i])
        call SaveRectHandle(YDHT, GetHandleId(nodes[i]), 0, nodeRects[i])
        set i = i + 1
    endloop
    

    // 为nodes注册可能的下一个节点

    set i = 1
    loop
        exitwhen i >= 24
        call TriggerRegisterEnterRegionSimple(t, nodes[i])
        set i = i + 1
    endloop
    call TriggerAddCondition(t, Condition(function isEnemy))
    call TriggerAddAction(t, function chooseNextNode)
    
endfunction