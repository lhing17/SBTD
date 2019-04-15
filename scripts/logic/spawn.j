/*********************
 * 刷怪相关逻辑
 ********************/
globals
    /*
     * 配置常量
     */
    constant integer FIRST_WAVE_TIME = 1 // 开始刷怪时间
    constant integer SPAWN_FREQUENCY = 2 // 刷怪频率（几秒一个怪）
    constant integer WAVE_TIME = 40 // 每波刷怪时间
    constant integer WAVE_INTERVAL = 1 // 每波之间间隔的时间
    constant integer BOSS_WAVE_INTERVAL = 9 // 两个BOSS之间的波数

    integer array mob // 小兵
    integer array boss
    timer mobTimer // 刷兵的计时器
    timerdialog mobTimerDialog 
    timer bossTimer // 刷BOSS的计时器
    timerdialog bossTimerDialog
    integer wave = 0 // 波数
    integer array luck // 每个玩家的人品
    trigger spawnTrigger // 刷怪的触发器
    group attackerGroup // 进攻怪的单位组
endglobals

function initMobsAndBosses takes nothing returns nothing
    set mob[1]='h005'
    set mob[2]='u000'
    set mob[3]='h006'
    set mob[4]='e002'
    set mob[5]='o004'
    set mob[6]='u001'
    set mob[7]='n00H'
    set mob[8]='h007'
    set mob[9]='z000'
    set mob[10]='z001'
    set mob[11]='u002'
    set mob[12]='o005'
    set mob[13]='o006'
    set mob[14]='e003'
    set mob[15]='n00J'
    set mob[16]='u003'
    set mob[17]='e004'
    set mob[18]='e005'
    set mob[19]='u004'
    set mob[20]='n00K'
    set mob[21]='e006'
    set mob[22]='u005'
    set mob[23]='h008'
    set mob[24]='h009'
    set mob[25]='n00L'
    set mob[26]='n00M'
    set mob[27]='n00N'
    set mob[28]='n00O'
    set mob[29]='n00P'
    set mob[30]='n00Q'
    set mob[31]='u006'
    set mob[32]='o008'
    set mob[33]='h00A'
    set mob[34]='e007'
    set mob[35]='n00S'
    set mob[36]='u007'
    set mob[37]='o009'
    set mob[38]='n00T'
    set mob[39]='n00U'
    set mob[40]='n00V'
    set mob[41]='n00W'
    set mob[42]='u009'
    set mob[43]='e008'
    set mob[44]='u00A'
    set mob[45]='n00X'
    set boss[1]='N00I'
    set boss[2]='O007'
    set boss[3]='N00R'
    set boss[4]='U008'
    set boss[5]='U00B'
endfunction

function spawn takes nothing returns nothing
    set wave = wave + 1

    // 显示BOSS的倒计时
    if ModuloInteger(wave, BOSS_WAVE_INTERVAL) == 1 then
        call TimerStart(bossTimer, ( WAVE_TIME + WAVE_INTERVAL ) * BOSS_WAVE_INTERVAL, false, null)
        call TimerDialogDisplay(bossTimerDialog, true)
    endif
    
    call EnableTrigger(spawnTrigger)
    call TimerStart(mobTimer, WAVE_TIME + WAVE_INTERVAL, false, null)

    call YDWEPolledWaitNull(WAVE_TIME) //每波时间
    call DisableTrigger(spawnTrigger)    
endfunction

// 实际执行刷兵的动作
function doSpawn takes nothing returns nothing
    local location array loc
    local location array target
    local integer i= 0
	set loc[0]=GetRectCenter(gg_rct_spawn1)
	set loc[1]=GetRectCenter(gg_rct_spawn2)
	set loc[2]=GetRectCenter(gg_rct_spawn3)
	set loc[3]=GetRectCenter(gg_rct_spawn4)
    set target[0]=GetRectCenter(nodeRects[22])
	set target[1]=GetRectCenter(nodeRects[23])
	set target[2]=GetRectCenter(nodeRects[24])
	set target[3]=GetRectCenter(nodeRects[21])
	set i=0
	loop
		exitwhen i > 3
		if GetPlayerController(Player(i)) == MAP_CONTROL_USER and GetPlayerSlotState(Player(i)) == PLAYER_SLOT_STATE_PLAYING then
    	    call CreateNUnitsAtLoc(1, mob[wave], Player(5), loc[i], bj_UNIT_FACING)
            call GroupAddUnit(attackerGroup, bj_lastCreatedUnit)
    	    //第13波灵魂行者进入地图使用灵肉形态
    	    if GetUnitTypeId(bj_lastCreatedUnit) == 'o006' then
    	        call IssueImmediateOrderById(bj_lastCreatedUnit, $D020D)
    	    endif
            call IssuePointOrderByIdLoc(bj_lastCreatedUnit, 0xD0012, target[i])
            call RemoveLocation(target[i])
            call RemoveLocation(loc[i])
            set target[i] = null
    	    set loc[i]=null
    	endif
		set i=i + 1
	endloop
endfunction

function initSpawn takes nothing returns nothing
    local integer i = 1
    local trigger t = CreateTrigger()

    // 初始化小兵和BOSS
    call initMobsAndBosses()

    set attackerGroup = CreateGroup()

    // 刷小兵计时器
    set mobTimer = CreateTimer()
    call TimerStart(mobTimer, FIRST_WAVE_TIME, false, null) // 开始刷怪
    set mobTimerDialog = CreateTimerDialogBJ(mobTimer, "下一波进攻")
    call TimerDialogDisplay(mobTimerDialog, true)

    // BOSS计时器，仅用于展示
    set bossTimer = CreateTimer()
    set bossTimerDialog = CreateTimerDialogBJ(bossTimer, "下一个BOSS剩余：")

    call TriggerRegisterTimerExpireEvent(t, mobTimer)
    call TriggerAddAction(t, function spawn)

    // 实际执行刷怪的触发器
    set spawnTrigger = CreateTrigger()
    call DisableTrigger(spawnTrigger)
    call TriggerRegisterTimerEventPeriodic(spawnTrigger, SPAWN_FREQUENCY)
    call TriggerAddAction(spawnTrigger, function doSpawn)


endfunction