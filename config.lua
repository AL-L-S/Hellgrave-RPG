-- Conexion MySQL (Usuario / Password y Nombre Database)
mysqlHost = "127.0.0.1"
mysqlUser = ""
mysqlPass = ""
mysqlDatabase = ""
mysqlPort = 3306
mysqlSock = ""
passwordType = "sha1"

-- Configuracion del Servidor
-- Nota: Si estan sujetos a algun tipo de retraso "lag" o que algun jugador tiene un kick a la hora de matar X monstruos a la vez
-- Pueden subir el maxPacketsPerSecond , a 30, 35.. Tengan cuidado de no subirlo mucho.
ip = "127.0.0.1"
bindOnlyGlobalAddress = false
loginProtocolPort = 7171
gameProtocolPort = 7172
statusProtocolPort = 7171
maxPlayers = 0
motd = "Bienvenidos al Hellgrave Server"
onePlayerOnlinePerAccount = true
allowClones = false
serverName = "Hellgrave" -- Nombre identico que el servername en el config.php del ZnoteAAC Hellgrave
statusTimeout = 5 * 1000
replaceKickOnLogin = true
maxPacketsPerSecond = 25
maxItem = 2000
maxContainer = 100
clientVersion = 1272
clientVersionStr = "12.72"
freeDepotLimit = 2000
premiumDepotLimit = 10000
depotBoxes = 18
weatherRain = false
thunderEffect = false
freeQuests = false
allConsoleLog = false

-- Configuracion de Combate
worldType = "pvp"
hotkeyAimbotEnabled = true
protectionLevel = 7
pzLocked = 60 * 1000
removeChargesFromRunes = true
removeChargesFromPotions = true
removeWeaponAmmunition = true
removeWeaponCharges = true
timeToDecreaseFrags = 24 * 60 * 60 * 1000
whiteSkullTime = 15 * 60 * 1000
stairJumpExhaustion = 2 * 1000
experienceByKillingPlayers = false
expFromPlayersLevelRange = 75
dayKillsToRedSkull = 3
weekKillsToRedSkull = 5
monthKillsToRedSkull = 10
redSkullDuration = 1
blackSkullDuration = 3
orangeSkullDuration = 7
onlyInvitedCanMoveHouseItems = true
cleanProtectionZones = false

-- Extra Configuracion
-- GameStore
gamestoreByModules = true
-- Servidor unicamente para Cuentas premium ?
onlyPremiumAccount = false
-- Guardado del Servidor 1 = 1 hora, no puede ser menos
saveInterval = false
saveIntervalCleanMap = false
saveIntervalTime = 1
-- Stamina en Trainers (No Compatible Hellgrave)
staminaTrainer = false
staminaTrainerDelay = 5
staminaTrainerGain = 1
-- Stamina in PZ
staminaPz = true
staminaOrangeDelay = 1
staminaGreenDelay = 5
staminaPzGain = 1
-- Maximo de jugadores en un Dummy
maxAllowedOnADummy = 1
-- Imbuement
togleImbuementShrineStorage = false
-- Muertes, - 1 Por defecto, viejo sistema poner 10.
-- Para no perder experiencia poner 0
deathLosePercent = -1
-- Casas
-- Insertar -1 Para descativar la compra de casas en el juego
-- houseRentPeriod: daily/weekly/monthly/yearly/never
housePriceEachSQM = 1000
houseRentPeriod = "never"
houseOwnedByAccount = false
-- Use de Time ( tiempo entre acciones )
timeBetweenActions = 200
timeBetweenExActions = 1000
-- Push Delay
pushDelay = 1000
pushDistanceDelay = 1500
-- Mapa Hellgrave
mapName = "hellgrave"
mapAuthor = "OpenGamesCommunity"
-- Party List limitations
-- max distance in which players in party list are visible
-- NOTE partyListMaxDistance set to 0 means no limit
partyListMaxDistance = 30
-- Mapa Custom
mapCustomName = ""
mapCustomFile = ""
mapCustomSpawn = ""
mapCustomAuthor = ""
mapCustomEnabled = false
-- Mercado ( Market )
marketOfferDuration = 30 * 24 * 60 * 60
premiumToCreateMarketOffer = true
checkExpiredMarketOffersEachMinutes = 60
maxMarketOffersAtATimePerPlayer = 100
-- Extra Configuracion
allowChangeOutfit = true
freePremium = false
kickIdlePlayerAfterMinutes = 15
maxMessageBuffer = 4
emoteSpells = false 
classicEquipmentSlots = false -- No recomendado utilizar en true, de hecho los quivers no se podran llevar
allowWalkthrough = true
coinPacketSize = 25
coinImagesURL = "http://127.0.0.1/store/images/" -- Imagenes del Store dentro del juego ( 127.0.0.1, por defecto localhost, no cambiar, crear una carpeta llamada Store en vuestra carpeta www o htdocs, descarga https://opengamescommunity.com/index.php?resources/store-images.203/ )
classicAttackSpeed = false
showScriptsLogInConsole = false
-- Guardado Del Servidor 
-- Recomendado si quereis cada dia resetear automaticamente el servidor, ponerlo en true ( para modificar la hora data/scripts/globalevents/others/server_save.lua , indicado a las 08:00:00 abajo del script )
-- Para hacerlo de manera automatica podeis descargar nuestro OT Restarter, lo que hara esque si la consola esta cerrada, la abre automaticamente ( https://opengamescommunity.com/index.php?resources/otrestarter-restart-on-crash.592/ )
serverSaveNotifyMessage = true
serverSaveNotifyDuration = 5
serverSaveCleanMap = false
serverSaveClose = false
serverSaveShutdown = false
-- Indicar true unicamente si usan servidores con muchissimo loot distinto para que aparezca el loot raro primero y no se pierda por X casillas que no tenga el cuerpo ( raros casos )
sortLootByChance = false
-- EXP / RATES -- En este caso funciona por stages, ver archivo data/xml/stages. Indicar unicamente el rate del loot.
rateExp = 1
rateSkill = 50
rateLoot = 3
rateMagic = 25
rateSpawn = 1
-- Regeneracion , 1.0 es lo mas minimo
rateHealthRegen = 1.0
rateHealthRegenSpeed = 1.0
rateManaRegen = 1.0
rateManaRegenSpeed = 1.0
rateSoulRegen = 1.0
rateSoulRegenSpeed = 1.0
rateSpellCooldown = 1.0
rateAttackSpeed = 1.0
rateOfflineTrainingSpeed = rateAttackSpeed
rateExerciseTrainingSpeed = rateAttackSpeed
-- Rates de los monstruos
rateMonsterHealth = 1.0
rateMonsterAttack = 1.0
rateMonsterDefense = 1.0
-- Monstruos
deSpawnRange = 2
deSpawnRadius = 50
-- Stamina
staminaSystem = true
-- Scripts
warnUnsafeScripts = true
convertUnsafeScripts = true
-- Startup ( Comienzo del servidor )
-- Unicamente para windows, processos altos , puede ser "normal", "above-normal", "high"
defaultPriority = "high"
startupDatabaseOptimization = true
-- Informacion del Servidor
ownerName = "OpenGamesCommunity"
ownerEmail = ""
url = "https://opengamescommunity.com/"
location = "Spain"
-- Discord Webhook
discordWebhookURL = ""
