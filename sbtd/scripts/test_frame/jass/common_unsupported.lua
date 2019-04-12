---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by G_Seinfeld.
--- DateTime: 2018/11/5 8:51
---


--
--// Creates a new or reads in an existing game cache file stored
--// in the current campaign profile dir
--//
--native  ReloadGameCachesFromDisk takes nothing returns boolean
--
--native  InitGameCache    takes string campaignFile returns gamecache
--native  SaveGameCache    takes gamecache whichCache returns boolean
--
--native  StoreInteger					takes gamecache cache, string missionKey, string key, integer value returns nothing
--native  StoreReal						takes gamecache cache, string missionKey, string key, real value returns nothing
--native  StoreBoolean					takes gamecache cache, string missionKey, string key, boolean value returns nothing
--native  StoreUnit						takes gamecache cache, string missionKey, string key, unit whichUnit returns boolean
--native  StoreString						takes gamecache cache, string missionKey, string key, string value returns boolean
--
--native SyncStoredInteger        takes gamecache cache, string missionKey, string key returns nothing
--native SyncStoredReal           takes gamecache cache, string missionKey, string key returns nothing
--native SyncStoredBoolean        takes gamecache cache, string missionKey, string key returns nothing
--native SyncStoredUnit           takes gamecache cache, string missionKey, string key returns nothing
--native SyncStoredString         takes gamecache cache, string missionKey, string key returns nothing
--
--native  HaveStoredInteger					takes gamecache cache, string missionKey, string key returns boolean
--native  HaveStoredReal						takes gamecache cache, string missionKey, string key returns boolean
--native  HaveStoredBoolean					takes gamecache cache, string missionKey, string key returns boolean
--native  HaveStoredUnit						takes gamecache cache, string missionKey, string key returns boolean
--native  HaveStoredString					takes gamecache cache, string missionKey, string key returns boolean
--
--native  FlushGameCache						takes gamecache cache returns nothing
--native  FlushStoredMission					takes gamecache cache, string missionKey returns nothing
--native  FlushStoredInteger					takes gamecache cache, string missionKey, string key returns nothing
--native  FlushStoredReal						takes gamecache cache, string missionKey, string key returns nothing
--native  FlushStoredBoolean					takes gamecache cache, string missionKey, string key returns nothing
--native  FlushStoredUnit						takes gamecache cache, string missionKey, string key returns nothing
--native  FlushStoredString					takes gamecache cache, string missionKey, string key returns nothing
--
--// Will return 0 if the specified value's data is not found in the cache
--native  GetStoredInteger				takes gamecache cache, string missionKey, string key returns integer
--native  GetStoredReal					takes gamecache cache, string missionKey, string key returns real
--native  GetStoredBoolean				takes gamecache cache, string missionKey, string key returns boolean
--native  GetStoredString					takes gamecache cache, string missionKey, string key returns string
--native  RestoreUnit						takes gamecache cache, string missionKey, string key, player forWhichPlayer, real x, real y, real facing returns unit
--

--//============================================================================
--// Image API
--//
--native CreateImage                  takes string file, real sizeX, real sizeY, real sizeZ, real posX, real posY, real posZ, real originX, real originY, real originZ, integer imageType returns image
--native DestroyImage                 takes image whichImage returns nothing
--native ShowImage                    takes image whichImage, boolean flag returns nothing
--native SetImageConstantHeight       takes image whichImage, boolean flag, real height returns nothing
--native SetImagePosition             takes image whichImage, real x, real y, real z returns nothing
--native SetImageColor                takes image whichImage, integer red, integer green, integer blue, integer alpha returns nothing
--native SetImageRender               takes image whichImage, boolean flag returns nothing
--native SetImageRenderAlways         takes image whichImage, boolean flag returns nothing
--native SetImageAboveWater           takes image whichImage, boolean flag, boolean useWaterAlpha returns nothing
--native SetImageType                 takes image whichImage, integer imageType returns nothing
--
--//============================================================================
--// Ubersplat API
--//
--native CreateUbersplat              takes real x, real y, string name, integer red, integer green, integer blue, integer alpha, boolean forcePaused, boolean noBirthTime returns ubersplat
--native DestroyUbersplat             takes ubersplat whichSplat returns nothing
--native ResetUbersplat               takes ubersplat whichSplat returns nothing
--native FinishUbersplat              takes ubersplat whichSplat returns nothing
--native ShowUbersplat                takes ubersplat whichSplat, boolean flag returns nothing
--native SetUbersplatRender           takes ubersplat whichSplat, boolean flag returns nothing
--native SetUbersplatRenderAlways     takes ubersplat whichSplat, boolean flag returns nothing
--
--//============================================================================
--// Blight API
--//
--native SetBlight                takes player whichPlayer, real x, real y, real radius, boolean addBlight returns nothing
--native SetBlightRect            takes player whichPlayer, rect r, boolean addBlight returns nothing
--native SetBlightPoint           takes player whichPlayer, real x, real y, boolean addBlight returns nothing
--native SetBlightLoc             takes player whichPlayer, location whichLocation, real radius, boolean addBlight returns nothing
--native CreateBlightedGoldmine   takes player id, real x, real y, real face returns unit
--native IsPointBlighted          takes real x, real y returns boolean
--
--//============================================================================
--// Doodad API
--//
--native SetDoodadAnimation       takes real x, real y, real radius, integer doodadID, boolean nearestOnly, string animName, boolean animRandom returns nothing
--native SetDoodadAnimationRect   takes rect r, integer doodadID, string animName, boolean animRandom returns nothing
--


--//============================================================================
--// Computer AI interface
--//
--native StartMeleeAI         takes player num, string script                 returns nothing
--native StartCampaignAI      takes player num, string script                 returns nothing
--native CommandAI            takes player num, integer command, integer data returns nothing
--native PauseCompAI          takes player p,   boolean pause                 returns nothing
--native GetAIDifficulty      takes player num                                returns aidifficulty
--

--native RecycleGuardPosition takes unit hUnit                                returns nothing
--native RemoveAllGuardPositions takes player num                             returns nothing
--

--//============================================================================
--native Cheat            takes string cheatStr returns nothing
--native IsNoVictoryCheat takes nothing returns boolean
--native IsNoDefeatCheat  takes nothing returns boolean
--
--native Preload          takes string filename returns nothing
--native PreloadEnd       takes real timeout returns nothing
--
--native PreloadStart     takes nothing returns nothing
--native PreloadRefresh   takes nothing returns nothing
--native PreloadEndEx     takes nothing returns nothing
--
--native PreloadGenClear  takes nothing returns nothing
--native PreloadGenStart  takes nothing returns nothing
--native PreloadGenEnd    takes string filename returns nothing
--native Preloader        takes string filename returns nothing
-- TODO
--native          QueueUnitAnimation          takes unit whichUnit, string whichAnimation returns nothing
--native          SetUnitAnimation            takes unit whichUnit, string whichAnimation returns nothing
--native          SetUnitAnimationByIndex     takes unit whichUnit, integer whichAnimation returns nothing
--native          SetUnitAnimationWithRarity  takes unit whichUnit, string whichAnimation, raritycontrol rarity returns nothing
--native          AddUnitAnimationProperties  takes unit whichUnit, string animProperties, boolean add returns nothing
--
--native          SetUnitLookAt       takes unit whichUnit, string whichBone, unit lookAtTarget, real offsetX, real offsetY, real offsetZ returns nothing
--native          ResetUnitLookAt     takes unit whichUnit returns nothing
--
--native          SetUnitRescuable    takes unit whichUnit, player byWhichPlayer, boolean flag returns nothing
--native          SetUnitRescueRange  takes unit whichUnit, real range returns nothing
--native        SetUnitPointValueByType takes integer unitType, integer newPointValue returns nothing


--//============================================================================
--// Trigger API
--//
--
--native TriggerRegisterUnitStateEvent takes trigger whichTrigger, unit whichUnit, unitstate whichState, limitop opcode, real limitval returns event
--
--// EVENT_UNIT_STATE_LIMIT
--constant native GetEventUnitState takes nothing returns unitstate


--
--native TriggerRegisterDeathEvent takes trigger whichTrigger, widget whichWidget returns event
--
--native TriggerWaitForSound  takes sound s, real offset returns nothing
--native TriggerExecuteWait   takes trigger whichTrigger returns nothing

--native          SetUnitExploded     takes unit whichUnit, boolean exploded returns nothing

--//============================================================================
--// Terrain API
--//
--native GetTerrainCliffLevel         takes real x, real y returns integer
--native SetWaterBaseColor            takes integer red, integer green, integer blue, integer alpha returns nothing
--native SetWaterDeforms              takes boolean val returns nothing
--native GetTerrainType               takes real x, real y returns integer
--native GetTerrainVariance           takes real x, real y returns integer
--native SetTerrainType               takes real x, real y, integer terrainType, integer variation, integer area, integer shape returns nothing

local common_unsupported = {}

common_unsupported.unsupported_list =
{'RemoveGuardPosition',
 'AddWeatherEffect',
 'EnableWeatherEffect',
 'RegisterStackedSound',
 'SetUnitAnimation',
 'ResetUnitAnimation',
 'SetCreepCampFilterState',
 'AttachSoundToUnit'
}

return common_unsupported