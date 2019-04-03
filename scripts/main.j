/*
 * 引入相关库文件
 */
#include "lib/DzAPI.j"
#include "lib/BlizzardAPI.j"
#include "lib/najitest.j"

/*
 * 逻辑代码
 */
#include "logic/enemyMove.j"
#include "logic/spawn.j"


function init takes nothing returns nothing
    call initEnemyMove()
    call initSpawn()
endfunction


