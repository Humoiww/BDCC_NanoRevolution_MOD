extends Module
class_name NanoModule
var NIS = preload("res://Modules/NanoRevolution/InteractionSystem/NanoInteractionSystem.gd").new()



func getFlags():
	return {
		# Nano module
		"NanoCheckSRefuseTimes": flag(FlagType.Number),
		"NanoCheckHappened": flag(FlagType.Bool),
		"NanoAttackSceneHappened": flag(FlagType.Bool),
		"NanoCraftingTableEnabled": flag(FlagType.Bool),
		"NanoMeetHumoi": flag(FlagType.Bool),
		# "NanoAndroidMaxCockSize": flag(FlagType.Number),
		# "NanoAndroidMinCockSize": flag(FlagType.Number),
		# "NanoAndroidMaxCupSize": flag(FlagType.Number),
		# "NanoAndroidMinCupSize": flag(FlagType.Number),
		"NanoAndroidSizePara": flag(FlagType.Dict),
		"NanoAndroidSpeciesDistr": flag(FlagType.Dict),
		"NanoAndroidGuardAppearWeight": flag(FlagType.Number),
		"NanoAndroidGenderDistr": flag(FlagType.Dict),
		"NanoToughEnable": flag(FlagType.Bool),

		# CraftFlag
		"NanoAfterFirstBlueprintHumoi": flag(FlagType.Bool),
		# Craftable List
		"NanoCraftableTag": flag(FlagType.Dict),
		"NanoCraftableItem": flag(FlagType.Dict),
		# SexDollSkill
		"NanoSexSub": flag(FlagType.Bool),
		"NanoSexMasturbate": flag(FlagType.Bool),
		"NanoSexToilet": flag(FlagType.Bool),
		"NanoSexDollMaitain": flag(FlagType.Bool),
		# ControllerFlag
		"NanoHasController": flag(FlagType.Bool),
		"NanoControllerRemainCharge": flag(FlagType.Number),
		"NanoControllerFullCharge": flag(FlagType.Number),
		# KeyQuestFlag
		"NanoTriggerKeyQuest": flag(FlagType.Bool),
		"NanoKnowAndroidKey": flag(FlagType.Bool),
		"NanoAskHumoiKey": flag(FlagType.Bool),
		"NanoAskAlexKey": flag(FlagType.Bool),

		# Interaction Flag 
		"NanoIsGenerateThisMorning": flag(FlagType.Bool),# I know might stupid but try this lol
		"NanoIsGenerateThisAfternoon": flag(FlagType.Bool),
		"NanoIsGenerateThisEvening": flag(FlagType.Bool),

		
	}

func getDefaultSize():
	var defaultSizePara = {}
	defaultSizePara[BodypartSlot.Penis] = ["Cock Length",1,40]
	defaultSizePara[BodypartSlot.Breasts] = ["Cup Size",BreastsSize.FLAT,BreastsSize.O]
	return defaultSizePara

func getSizeDict():
	var defaultSizeDict = getDefaultSize()
	var sizeDict = GM.main.getModuleFlag("NanoRevolutionModule", "NanoAndroidSizePara",defaultSizeDict)
	# check if sizeDict is valid, if not, reset the size dictionary
	if (sizeDict[BodypartSlot.Penis] == null) or (sizeDict[BodypartSlot.Breasts] == null):
		sizeDict = defaultSizeDict
		GM.main.setModuleFlag("NanoRevolutionModule", "NanoAndroidSizePara",defaultSizeDict)
	return sizeDict

func getNanoCockSize():
	var sizeDict = getSizeDict()
	return RNG.randi_range(sizeDict[BodypartSlot.Penis][1],sizeDict[BodypartSlot.Penis][2])

func getNanoBreastSize():
	var sizeDict = getSizeDict()
	return RNG.randi_range(sizeDict[BodypartSlot.Breasts][1],sizeDict[BodypartSlot.Breasts][2])

func doConvertCharacter(npcID):
	var theChar:DynamicCharacter = GlobalRegistry.getCharacter(npcID)
	theChar.addEffect("NanoSexMark")
	
	# if(theChar == null || !theChar.isDynamicCharacter()):
	# 	return false
	# if(theChar.isSlaveToPlayer()):
	# 	return false
	
	# var theEnslaveQuest:NpcEnslavementQuest = theChar.getEnslaveQuest()
	# theChar.setEnslaveQuest(null)
	
	# var slaveType = defaultSlaveType
	# if(theEnslaveQuest != null):
	# 	slaveType = theEnslaveQuest.slaveType
	
	# var newNpcSlavery = NpcSlave.new()
	# newNpcSlavery.setChar(theChar)
	# newNpcSlavery.setMainSlaveType(slaveType)
	# newNpcSlavery.slaveSpecializations = {
	# 	slaveType: 0,
	# }
	# #newNpcSlavery.generateTasks()
	# theChar.setNpcSlavery(newNpcSlavery)
	# newNpcSlavery.onEnslave()
	
	GM.main.removeDynamicCharacterFromAllPools(npcID)
	GM.main.addDynamicCharacterToPool(npcID, "SexDoll")
	return true



func _init():
	id = "NanoRevolutionModule"
	author = "Humoi"
	attacks = [
		"res://Modules/NanoRevolution/Attacks/NanoHackPCAttack.gd",
		"res://Modules/NanoRevolution/Attacks/NanoBrickPCAttack.gd",
		"res://Modules/NanoRevolution/Attacks/NanoAutoBondPCAttack.gd",
	]
	scenes = [
		"res://Modules/NanoRevolution/Scenes/NanoAttackScene.gd",
		"res://Modules/NanoRevolution/Scenes/NanoCraftScene.gd",
		"res://Modules/NanoRevolution/Scenes/NanoExposureForceCheckScene.gd",
		"res://Modules/NanoRevolution/Scenes/NanoSetting.gd",
		"res://Modules/NanoRevolution/Scenes/HumoiTalkScene.gd",
		"res://Modules/NanoRevolution/Scenes/NanoMeetSexDollScene.gd",
		"res://Modules/NanoRevolution/Scenes/NanoCallingScene.gd",
		"res://Modules/NanoRevolution/Scenes/Alex_TalkAboutAndroid.gd",
		"res://Modules/NanoRevolution/Scenes/HumoiSecondKeyScene.gd",
		"res://Modules/NanoRevolution/Scenes/NanoBlueprintHumoi.gd",
		]
	characters = [
		"res://Modules/NanoRevolution/Characters/NanoAssemble.gd",
		"res://Modules/NanoRevolution/Characters/Humoi.gd"
	]
	items = [
		"res://Modules/NanoRevolution/Inventory/Items/NanoCore.gd",
		"res://Modules/NanoRevolution/Inventory/Items/NanoController.gd",
		"res://Modules/NanoRevolution/Inventory/Items/Weapons/NanoBrick.gd",
		"res://Modules/NanoRevolution/Inventory/Items/Nano_InstantCharger.gd",
		"res://Modules/NanoRevolution/Inventory/Items/Nano_AutoBonder.gd",
		
	]
	events = [
		"res://Modules/NanoRevolution/Events/Event/NanoExposureForceCheckEvent.gd", 
		"res://Modules/NanoRevolution/Events/Event/NanoCraftingTableEvent.gd", 
		"res://Modules/NanoRevolution/Events/Event/NanoAndroidMeetAssembleEvent.gd", 
		"res://Modules/NanoRevolution/Events/Event/NanoAndroidCheck.gd",
		"res://Modules/NanoRevolution/Events/Event/NanoVisitHumoiEvent.gd",
		"res://Modules/NanoRevolution/Events/Event/Nano_AlexLearnEvent.gd",
		"res://Modules/NanoRevolution/Events/Event/Nano_NewInteraction.gd",
	]
	perks = [
		"res://Modules/NanoRevolution/Skills/Perk/NanoBetterExtration.gd",
		"res://Modules/NanoRevolution/Skills/Perk/NanoCraftingT1.gd", 
		"res://Modules/NanoRevolution/Skills/Perk/NanoExtration.gd", 
		"res://Modules/NanoRevolution/Skills/Perk/NanoSexMode.gd",
		"res://Modules/NanoRevolution/Skills/Perk/NanoDistraction.gd",
		"res://Modules/NanoRevolution/Skills/Perk/NanoCallBackUp.gd",
		"res://Modules/NanoRevolution/Skills/Perk/NanoCraftingT2.gd",
	]
	skills = [
		"res://Modules/NanoRevolution/Skills/Skill/NanoENGR.gd",

	]
	species = [
		"res://Modules/NanoRevolution/Species/NanoAndroid.gd"
	]
#	stageScenes = [
#
#	]
	quests = [
		"res://Modules/NanoRevolution/Quests/Nano_FigureOutKey.gd"
	]
	computers = [
		"res://Modules/NanoRevolution/Scenes/NanoAndroidFunction/Nano_HackAndroid.gd"
	]
	statusEffects = [
		"res://Modules/NanoRevolution/StatusEffect/NanoSexMark.gd"
	]
	sexActivities = [
		"res://Modules/NanoRevolution/SexActivities/UseNanoStuff.gd",
	]


func resetFlagsOnNewDay():
	var charge = GM.main.getModuleFlag("NanoRevolutionModule", "NanoControllerFullCharge", 10)
	GM.main.setModuleFlag("NanoRevolutionModule", "NanoControllerRemainCharge", charge)
	GM.main.setModuleFlag("NanoRevolutionModule", "NanoIsGenerateThisMorning",false)


func getCraftCost(itemObject:ItemBase):

	itemObject.getVisibleName()
	return ceil(itemObject.getPrice()/5.0) if (itemObject.getPrice()>0) else 1.0
