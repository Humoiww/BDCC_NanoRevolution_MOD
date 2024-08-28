extends Module
class_name NanoModule

func getFlags():
	return {
		# Nano module
		"NanoCheckSRefuseTimes": flag(FlagType.Number),
		"NanoCheckHappened": flag(FlagType.Bool),
		"NanoAttackSceneHappened": flag(FlagType.Bool),
		"NanoCraftingTableEnabled": flag(FlagType.Bool),
		"NanoMeetHumoi": flag(FlagType.Bool),
		"NanoAndroidMaxCockSize": flag(FlagType.Number),
		"NanoAndroidMinCockSize": flag(FlagType.Number),
		"NanoAndroidMaxCupSize": flag(FlagType.Number),
		"NanoAndroidMinCupSize": flag(FlagType.Number),
		"NanoAndroidSpeciesDistr": flag(FlagType.Dict),
		"NanoAndroidGuardAppearWeight": flag(FlagType.Number),
		"NanoAndroidGenderDistr": flag(FlagType.Dict),
	}

func _init():
	id = "NanoRevolutionModule"
	author = "Humoi"
	
	scenes = [
		"res://Modules/NanoRevolution/Scenes/NanoAttackScene.gd",
		"res://Modules/NanoRevolution/Scenes/NanoCraftScene.gd",
		"res://Modules/NanoRevolution/Scenes/NanoExposureForceCheckScene.gd",
		"res://Modules/NanoRevolution/Scenes/NanoSetting.gd"
		]
	characters = [
		"res://Modules/NanoRevolution/Characters/NanoAssemble.gd",
		"res://Modules/NanoRevolution/Characters/Humoi.gd"
	]
	items = [
		"res://Modules/NanoRevolution/Inventory/Items/NanoCore.gd",
		
	]
	events = [
		"res://Modules/NanoRevolution/Events/Event/NanoExposureForceCheckEvent.gd", 
		"res://Modules/NanoRevolution/Events/Event/NanoCraftingTableEvent.gd", 
		"res://Modules/NanoRevolution/Events/Event/NanoAndroidMeetAssembleEvent.gd", 
		"res://Modules/NanoRevolution/Events/Event/NanoAndroidCheck.gd",
	]
	perks = [
		"res://Modules/NanoRevolution/Skills/Perk/NanoBetterExtration.gd",
		"res://Modules/NanoRevolution/Skills/Perk/NanoCraftingT1.gd", 
		"res://Modules/NanoRevolution/Skills/Perk/NanoExtration.gd", 
		"res://Modules/NanoRevolution/Skills/Perk/NanoSexMode.gd",
		"res://Modules/NanoRevolution/Skills/Perk/NanoDistraction.gd",
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
# func resetFlagsOnNewDay():
# 	if(GM.main.getModuleFlag("NovaModule", "Nova_NotThereToday")):
# 		GM.main.setModuleFlag("NovaModule", "Nova_NotThereToday", false)
