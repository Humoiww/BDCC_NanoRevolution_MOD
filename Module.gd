extends Module
class_name NanoModule

var interactions = []
var pawnTypes = []

func getFlags():
	return {
		# Nano module
		"NanoCheckSRefuseTimes": flag(FlagType.Number),
		"NanoCheckHappened": flag(FlagType.Bool),
		"NanoSexDollMeeted": flag(FlagType.Bool),
		"NanoAttackSceneHappened": flag(FlagType.Bool),
		"NanoAttackSceneWarned": flag(FlagType.Bool),
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
		"NanoUnlockQuickHack": flag(FlagType.Bool),

		#Nano Species Flag
		"NanoGrantedInitialExp": flag(FlagType.Bool),

		#Nano New Interaction Flag 

		"NanoCharacterCheckedToday": flag(FlagType.Dict),
		"NanoCheckChance": flag(FlagType.Number),
		"NanoCharacterBeingHacked": flag(FlagType.Dict),
		# "NanoIsGenerateThisMorning": flag(FlagType.Bool),# I know might stupid but try this lol
		# "NanoIsGenerateThisAfternoon": flag(FlagType.Bool),
		# "NanoIsGenerateThisEvening": flag(FlagType.Bool),
		
		# "NanoLastCheckTime": flag(FlagType.Number),
		# "NanoNextCheckTime": flag(FlagType.Number),
		# "NanoCheckTimePeriod": flag(FlagType.Number),
		
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

	GM.main.IS.deletePawn(npcID)
	GM.main.IS.spawnPawn(npcID,"SexDoll")
	var newPawn = GM.main.IS.getPawn(npcID)
	newPawn.setLocation(GM.pc.getLocation())
	GM.world.pawns[npcID].setPawnColor(Color( 0.201961, 0, 0.201961, 1 ))
	for slot in InventorySlot.getAll():
		# var item = npc.getInventory().getAllEquippedItems()[itemSlot]
		# if(item.isImportant()):
		# 	continue
		theChar.getInventory().removeItemFromSlot(slot)
	# newPawn.setPawnColor(Color.gray)
	# GM.world.updatePawns(GM.main.IS)
	# newPawn.setInteraction("TestInteraction")
	theChar.npcCharacterType = "SexDoll"
	
	var thedesc = ""
	thedesc += Util.getSpeciesName(theChar.npcSpecies)
	thedesc += ". "
	thedesc += NpcGender.getVisibleName(theChar.npcGeneratedGender)+"."
	
	theChar.npcSmallDescription = "One of the sex doll. " + thedesc
	GM.main.removeDynamicCharacterFromAllPools(npcID)
	GM.main.addDynamicCharacterToPool(npcID, "SexDoll")
	return true

func doConvertCharacterGuard(npcID):
	var theChar:DynamicCharacter = GlobalRegistry.getCharacter(npcID)
	theChar.removeEffect("NanoSexMark")

	GM.main.IS.deletePawn(npcID)
	GM.main.IS.spawnPawn(npcID,"NanoGuard")
	var newPawn = GM.main.IS.getPawn(npcID)
	newPawn.setLocation(GM.pc.getLocation())
	GM.world.pawns[npcID].setPawnColor(Color( 0.5, 0.5, 1, 1))
	for slot in InventorySlot.getAll():
		# var item = npc.getInventory().getAllEquippedItems()[itemSlot]
		# if(item.isImportant()):
		# 	continue
		theChar.getInventory().removeItemFromSlot(slot)
	# newPawn.setPawnColor(Color.gray)
	# GM.world.updatePawns(GM.main.IS)
	# newPawn.setInteraction("TestInteraction")
	theChar.npcCharacterType = "NanoGuard"

	var thedesc = ""
	thedesc += Util.getSpeciesName(theChar.npcSpecies)
	thedesc += ". "
	thedesc += NpcGender.getVisibleName(theChar.npcGeneratedGender)+"."
	
	theChar.npcSmallDescription = "One of the guard. " + thedesc
	
	GM.main.removeDynamicCharacterFromAllPools(npcID)
	GM.main.addDynamicCharacterToPool(npcID, "NanoGuard")
	return true


func _init():
	id = "NanoRevolutionModule"
	author = "Humoi"
	attacks = [
		"res://Modules/NanoRevolution/Attacks/NanoHackPCAttack.gd",
		"res://Modules/NanoRevolution/Attacks/NanoBrickPCAttack.gd",
		"res://Modules/NanoRevolution/Attacks/NanoAutoBondPCAttack.gd",
		"res://Modules/NanoRevolution/Attacks/NanoAttacks/NanoHeatGrenade.gd", 
		"res://Modules/NanoRevolution/Attacks/NanoAttacks/NanoLatexBarrage.gd", 
		"res://Modules/NanoRevolution/Attacks/NanoAttacks/NanoLatexRegeneration.gd", 
		"res://Modules/NanoRevolution/Attacks/NanoAttacks/NanoLatexSlam.gd", 
		"res://Modules/NanoRevolution/Attacks/NanoAttacks/NanoLatexStrike.gd"
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
		"res://Modules/NanoRevolution/Scenes/NanoAndroidFunction/NanoCharacterScene.gd",
		# transform scene
		"res://Modules/NanoRevolution/Scenes/Nano_TransformVictimScene.gd",
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
		# transform event
		"res://Modules/NanoRevolution/Events/Event/Nano_TransformVictimEvent.gd",
	]
	perks = [
		"res://Modules/NanoRevolution/Skills/Perk/NanoBetterExtration.gd",
		"res://Modules/NanoRevolution/Skills/Perk/NanoCraftingT1.gd", 
		"res://Modules/NanoRevolution/Skills/Perk/NanoExtration.gd", 
		"res://Modules/NanoRevolution/Skills/Perk/NanoSexMode.gd",
		"res://Modules/NanoRevolution/Skills/Perk/NanoDistraction.gd",
		"res://Modules/NanoRevolution/Skills/Perk/NanoCallBackUp.gd",
		"res://Modules/NanoRevolution/Skills/Perk/NanoCraftingT2.gd",
		"res://Modules/NanoRevolution/Skills/Perk/NanoCraftingT3.gd",
		# Nano Instinct
		"res://Modules/NanoRevolution/Skills/Perk/NanoFunction/NanoAttackSet.gd",
		"res://Modules/NanoRevolution/Skills/Perk/NanoFunction/NanoAbsorption.gd", 
		"res://Modules/NanoRevolution/Skills/Perk/NanoFunction/NanoAssimilation.gd", 
		"res://Modules/NanoRevolution/Skills/Perk/NanoFunction/NanoEdit.gd"
		
	]
	skills = [
		"res://Modules/NanoRevolution/Skills/Skill/NanoENGR.gd",
		"res://Modules/NanoRevolution/Skills/Skill/NanoFunction.gd",

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



#	custom register
	interactions = [
		"res://Modules/NanoRevolution/Interaction/NanoInteractionTest.gd",
		"res://Modules/NanoRevolution/Interaction/NanoAskSexService.gd",
		"res://Modules/NanoRevolution/Interaction/NanoAndroidGenericAttack.gd",
		"res://Modules/NanoRevolution/Interaction/NanoGuardBasicInteraction.gd",
		"res://Modules/NanoRevolution/Interaction/NanoGuardFrisk.gd",
	]
	pawnTypes =[
		"res://Modules/NanoRevolution/Characters/Dynamic/NanoAndroidPawn/SexDoll.gd",
		"res://Modules/NanoRevolution/Characters/Dynamic/NanoAndroidPawn/NanoGuard.gd",
		
	]
	

func register():
	.register()
	for interaction in interactions:
		GlobalRegistry.registerInteraction(interaction)

	for pawnType in pawnTypes:
		GlobalRegistry.registerPawnType(pawnType)

	# GlobalRegistry.registerInteraction("")



func resetFlagsOnNewDay():
	var charge = GM.main.getModuleFlag("NanoRevolutionModule", "NanoControllerFullCharge", 10)
	GM.main.setModuleFlag("NanoRevolutionModule", "NanoControllerRemainCharge", charge)
	# GM.main.setModuleFlag("NanoRevolutionModule", "NanoIsGenerateThisMorning",false)
	# GM.main.setModuleFlag("NanoRevolutionModule", "NanoCheckedToday",false)
	GM.main.setModuleFlag("NanoRevolutionModule", "NanoCharacterCheckedToday", {})

	# give me some skill
	
	if(GM.pc.getSpecies().has("nanoAndroid")):
		GM.main.addMessage("You feel a strange instinct altering your thoughts...")
		if (!GM.main.getModuleFlag("NanoRevolutionModule", "NanoGrantedInitialExp",false)):
			GM.main.setModuleFlag("NanoRevolutionModule", "NanoGrantedInitialExp",true)
			
			GM.pc.addSkillExperience("NanoFunction", 100)
			
		else:
			GM.pc.addSkillExperience("NanoFunction", 20)


func getCraftCost(itemObject:ItemBase):

	itemObject.getVisibleName()
	return ceil(itemObject.getPrice()/5.0) if (itemObject.getPrice()>0) else 1.0


func transformCharToNano(thePC:Character):
	
	thePC.npcSpecies = ["nanoAndroid"]
	var pcSkinData={
		"hair": {"r": Color("ff21253e"),"g": Color("ff4143a8"),"b": Color("ff000000"),},
		"penis": {"r": Color("ff242424"),"g": Color("ff070707"),"b": Color("ff01b2f9"),},
		}
	thePC.pickedSkin="HumanSkin"
	thePC.pickedSkinRColor=Color("ff080808")
	thePC.pickedSkinGColor=Color("ff363636")
	thePC.pickedSkinBColor=Color("ff678def")
	
	# thePC.setSpecies(["nanoAndroid"]) # yeah this magical function change PC's species 
	

	for bodypartSlot in pcSkinData:
		if(!thePC.hasBodypart(bodypartSlot)):
			continue
		var bodypart = thePC.getBodypart(bodypartSlot)
		var bodypartSkinData = pcSkinData[bodypartSlot]
		if(bodypartSkinData.has("skin")):
			bodypart.pickedSkin = bodypartSkinData["skin"]
		if(bodypartSkinData.has("r")):
			bodypart.pickedRColor = bodypartSkinData["r"]
		if(bodypartSkinData.has("g")):
			bodypart.pickedGColor = bodypartSkinData["g"]
		if(bodypartSkinData.has("b")):
			bodypart.pickedBColor = bodypartSkinData["b"]
	thePC.updateAppearance()
