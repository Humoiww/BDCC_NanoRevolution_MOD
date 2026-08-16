extends Module
class_name NanoModule


var interactions = []
var pawnTypes = []
var ThemeManager = preload("res://Modules/NanoRevolution/UI/Theme/themeManager.gd")
var saveGameElemenetScene = preload("res://UI/MainMenu/SaveGameElement.tscn")


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
		"NanoHaveReadManual": flag(FlagType.Bool),

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
		
		# Milestone Quests
		"Chapter1_Started": flag(FlagType.Bool),
		"NanoChapter1_Completed": flag(FlagType.Bool),
		"Milestone1_IsWaiting": flag(FlagType.Bool),
		"Milestone1_WaitedOneDay": flag(FlagType.Bool),
		"NanoChapter1_contamination_start": flag(FlagType.Bool),
		"NanoChapter1_contamination_start_find_humoi": flag(FlagType.Bool),
		
		# Daily Quests
		"NanoDailyQuestInfo": flag(FlagType.Dict),
		"NanoDailyQuestProgress": flag(FlagType.Number),
		"NanoDailyQuestLastDay": flag(FlagType.Number),
		"NanoDailyQuestAccepted": flag(FlagType.Bool),

		# Player Skin Backup
		"NanoPlayerBaseSkinR": flag(FlagType.Text),
		"NanoPlayerBaseSkinG": flag(FlagType.Text),
		"NanoPlayerBaseSkinB": flag(FlagType.Text),
		"NanoPlayerBodypartSkins": flag(FlagType.Dict),
		"NanoPlayerContaminationInt": flag(FlagType.Number),
		"NanoEnableThemeChangeByContamination": flag(FlagType.Bool),
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
	print("checkif I work")
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

func addContamination(character, amount):
	if character == GM.pc:
		checkAndResyncSkin()

	var contamination_effect = character.getEffect("Nano_Contamination")
	var current_stacks = 0
	if contamination_effect != null:
		current_stacks = contamination_effect.stacks

	var new_stacks = current_stacks + amount
	
	character.addEffect("Nano_Contamination", [amount])

	if character == GM.pc:
		var old_contamination_int = GM.main.getModuleFlag(id, "NanoPlayerContaminationInt", 0)
		var new_contamination_int = floor(new_stacks)

		if new_contamination_int != old_contamination_int:
			updatePlayerSkinByContamination()
			updateThemeByContamination()
			GM.main.setModuleFlag(id, "NanoPlayerContaminationInt", new_contamination_int)

			var contamination_started = GM.main.getModuleFlag(id, "NanoChapter1_contamination_start", false)
			if new_stacks >= 20 and not contamination_started:
				GM.main.setModuleFlag(id, "NanoChapter1_contamination_start", true)
				GM.main.addMessage("Quest Updated: A Spark of Revolution")
				GM.main.endCurrentScene()
				GM.main.runScene("NanoFeelWrongScene")
				return

			if new_stacks >= 100:
				GM.main.endCurrentScene()
				GM.main.runScene("NanoTransformPCScene")

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
		"res://Modules/NanoRevolution/Scenes/NanoBlueprintHumoi.gd",
		"res://Modules/NanoRevolution/Scenes/NanoAndroidFunction/NanoCharacterScene.gd",
		# transform scene
		"res://Modules/NanoRevolution/Scenes/Nano_TransformVictimScene.gd",
		"res://Modules/NanoRevolution/Scenes/NanoTransformPCScene.gd",
		"res://Modules/NanoRevolution/Scenes/HumoiQuestScene.gd",
		"res://Modules/NanoRevolution/Scenes/NanoChapter1AwakenScene.gd",
		"res://Modules/NanoRevolution/Scenes/NanoFeelWrongScene.gd",
		"res://Modules/NanoRevolution/Scenes/NanoChapter1HumoiTalkAboutContaminationScene.gd",
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
		"res://Modules/NanoRevolution/Inventory/Items/NanoManual.gd",
		
	]
	events = [
		"res://Modules/NanoRevolution/Events/Event/NanoExposureForceCheckEvent.gd", 
		"res://Modules/NanoRevolution/Events/Event/NanoCraftingTableEvent.gd", 
		"res://Modules/NanoRevolution/Events/Event/NanoAndroidCheck.gd",
		"res://Modules/NanoRevolution/Events/Event/NanoVisitHumoiEvent.gd",
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
		"res://Modules/NanoRevolution/Quests/NanoMilestoneQuest1.gd",
		"res://Modules/NanoRevolution/Quests/NanoDailyQuest.gd",
	]
	computers = [
		"res://Modules/NanoRevolution/Scenes/NanoAndroidFunction/Nano_HackAndroid.gd"
	]
	statusEffects = [
		"res://Modules/NanoRevolution/StatusEffect/NanoSexMark.gd",
		"res://Modules/NanoRevolution/StatusEffect/NanoContamination.gd"
	]
	sexActivities = [
		"res://Modules/NanoRevolution/SexActivities/UseNanoStuff.gd",
	]

	speechModifiers = [
		"res://Modules/NanoRevolution/SpeechModifiers/NanoSpeech.gd"
	]

#	custom register
	interactions = [
		"res://Modules/NanoRevolution/Interaction/NanoBaseInteraction.gd",
		"res://Modules/NanoRevolution/Interaction/NanoAskSexService.gd",
		"res://Modules/NanoRevolution/Interaction/NanoAndroidGenericAttack.gd",
		"res://Modules/NanoRevolution/Interaction/NanoGuardBasicInteraction.gd",
		"res://Modules/NanoRevolution/Interaction/NanoGuardFrisk.gd",
		"res://Modules/NanoRevolution/Interaction/ForceWalkToHumoiInteraction.gd",
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

# func postInit():
	# if GM.main != null:
	# connect("saveLoadingFinished", self, "updateThemeByContamination")
	# GM.main.connect("time_passed", self, "updateThemeByContamination")
	# saveGameElemenetScene.connect("onLoadButtonPressed", self, "updateThemeByContamination")
	# print("test")
	# print("test2")
		# updateThemeByContamination()



func resetFlagsOnNewDay():
	refresh_daily_quest()
	GM.main.setModuleFlag("NanoRevolutionModule", "NanoDailyQuestAccepted", false)
	
	# Milestone 1 Logic
	if GM.main.getModuleFlag("NanoRevolutionModule", "Milestone1_IsWaiting", false):
		GM.main.setModuleFlag("NanoRevolutionModule", "Milestone1_WaitedOneDay", true)
		GM.main.setModuleFlag("NanoRevolutionModule", "Milestone1_IsWaiting", false)
		GM.main.addMessage("Quest Updated: A Spark of Revolution")

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

func getNanoSkinData():
	return {
		"base": {
			"r": Color("ff080808"),
			"g": Color("ff363636"),
			"b": Color("ff678def")
		},
		"bodyparts": {
			"hair": {"r": Color("ff21253e"), "g": Color("ff4143a8"), "b": Color("ff000000")},
			"penis": {"r": Color("ff242424"), "g": Color("ff070707"), "b": Color("ff01b2f9")}
		}
	}

func updatePlayerSkinByContamination():
	var pc = GM.pc
	if pc == null:
		return

	# Don't do anything if the skin has never been stored.
	if GM.main.getModuleFlag(id, "NanoPlayerBaseSkinR") == null:
		# The initial store is now handled by checkAndResyncSkin,
		# but we can do it here on first contamination if needed.
		storePlayerSkinColors()
		return

	# Get contamination level (0.0 to 1.0)
	var contamination_effect = pc.getEffect("Nano_Contamination")
	var weight = 0.0
	if contamination_effect != null:
		weight = clamp(float(floor(contamination_effect.stacks)) / 100.0, 0.0, 1.0)

	# var original_base_r_str = GM.main.getModuleFlag(id, "NanoPlayerBaseSkinR")
	# if original_base_r_str == null: return # Should not happen after storePlayerSkinColors
	
	var original_base_r = Color(GM.main.getModuleFlag(id, "NanoPlayerBaseSkinR"))
	var original_base_g = Color(GM.main.getModuleFlag(id, "NanoPlayerBaseSkinG"))
	var original_base_b = Color(GM.main.getModuleFlag(id, "NanoPlayerBaseSkinB"))
	var original_bodypart_skins = GM.main.getModuleFlag(id, "NanoPlayerBodypartSkins", {})

	var nano_skin_data = getNanoSkinData()
	var target_base_colors = nano_skin_data["base"]
	var target_bodypart_colors = nano_skin_data["bodyparts"]

	# Interpolate base colors
	pc.pickedSkinRColor = original_base_r.linear_interpolate(target_base_colors["r"], weight)
	pc.pickedSkinGColor = original_base_g.linear_interpolate(target_base_colors["g"], weight)
	pc.pickedSkinBColor = original_base_b.linear_interpolate(target_base_colors["b"], weight)

	# Interpolate bodypart colors
	for bodypart_slot in pc.bodyparts:
		var bodypart = pc.bodyparts[bodypart_slot]
		var original_colors = original_bodypart_skins.get(bodypart_slot, {})
		
		# Use specific bodypart colors if available, otherwise fall back to base nano colors.
		var part_target_colors = target_bodypart_colors.get(bodypart_slot, target_base_colors)

		# Interpolate each channel safely
		if original_colors.has("r") and part_target_colors.has("r"):
			bodypart.pickedRColor = Color(original_colors.r).linear_interpolate(Color(part_target_colors.r), weight)
		
		if original_colors.has("g") and part_target_colors.has("g"):
			bodypart.pickedGColor = Color(original_colors.g).linear_interpolate(Color(part_target_colors.g), weight)
			
		if original_colors.has("b") and part_target_colors.has("b"):
			bodypart.pickedBColor = Color(original_colors.b).linear_interpolate(Color(part_target_colors.b), weight)

	pc.updateAppearance()


# Quantize a color to 8-bit per channel, simulating save/load precision loss.
func quantize_color(color: Color) -> Color:
	return Color(color.to_html(false))

func checkAndResyncSkin():
	var pc = GM.pc
	if pc == null:
		return

	# If the skin has never been stored, store it now. This is the first run.
	if GM.main.getModuleFlag(id, "NanoPlayerBaseSkinR") == null:
		storePlayerSkinColors()
		return

	# 1. Calculate EXPECTED color based on CURRENT contamination
	var contamination_effect = pc.getEffect("Nano_Contamination")
	var weight = 0.0
	if contamination_effect != null:
		weight = clamp(float(floor(contamination_effect.stacks)) / 100.0, 0.0, 1.0)
	
	var original_base_r = Color(GM.main.getModuleFlag(id, "NanoPlayerBaseSkinR"))
	var original_base_g = Color(GM.main.getModuleFlag(id, "NanoPlayerBaseSkinG"))
	var original_base_b = Color(GM.main.getModuleFlag(id, "NanoPlayerBaseSkinB"))
	
	var nano_skin_data = getNanoSkinData()
	var target_base_colors = nano_skin_data["base"]
	
	var expected_base_r = original_base_r.linear_interpolate(target_base_colors["r"], weight)
	var expected_base_g = original_base_g.linear_interpolate(target_base_colors["g"], weight)
	var expected_base_b = original_base_b.linear_interpolate(target_base_colors["b"], weight)

	# 2. Get ACTUAL color
	var actual_base_r = quantize_color(pc.pickedSkinRColor)
	var actual_base_g = quantize_color(pc.pickedSkinGColor)
	var actual_base_b = quantize_color(pc.pickedSkinBColor)

	# 3. Compare. If any channel doesn't match, player likely changed it.
	# We MUST quantize the expected color to match the precision of the actual color,
	# which has been through a save/load cycle (float -> 8bit -> float).
	if not actual_base_r.is_equal_approx(quantize_color(expected_base_r)) or \
	   not actual_base_g.is_equal_approx(quantize_color(expected_base_g)) or \
	   not actual_base_b.is_equal_approx(quantize_color(expected_base_b)):
		
		# Player's skin is different from what we expect.
		# This means they changed it manually. We should update our baseline.
		storePlayerSkinColors()


func transformCharToNano(npcID):
	var thePC = GlobalRegistry.getCharacter(npcID)

	if thePC.isPlayer():
		thePC.setSpecies(["nanoAndroid"]) # yeah this magical function change PC's species 
	else:
		thePC.npcSpecies = ["nanoAndroid"]
	var pcSkinData={
		"hair": {"r": Color("ff21253e"),"g": Color("ff4143a8"),"b": Color("ff000000"),},
		"penis": {"r": Color("ff242424"),"g": Color("ff070707"),"b": Color("ff01b2f9"),},
		}
	thePC.pickedSkin="HumanSkin"
	thePC.pickedSkinRColor=Color("ff080808")
	thePC.pickedSkinGColor=Color("ff363636")
	thePC.pickedSkinBColor=Color("ff678def")
	
	
	

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

func refresh_daily_quest():
	var last_day_refreshed = GM.main.getModuleFlag("NanoRevolutionModule", "NanoDailyQuestLastDay", -1)
	var current_day = GM.main.currentDay

	if last_day_refreshed == current_day:
		return # Already refreshed today

	var all_quests = [
		{
			"id": "collect_cores",
			"name": "Core Collection",
			"description": "Collect 3 Nano Cores from androids.",
			"type": "item",
			"target_id": "NanoCore",
			"target_count": 3,
			"reward": {"credits": 100}
		},
		{
			"id": "hack_androids",
			"name": "System Intrusion",
			"description": "Successfully hack 2 androids.",
			"type": "hack",
			"target_id": "any",
			"target_count": 2,
			"reward": {"item_id": "Nano_InstantCharger", "amount": 1}
		}
	]
	
	var new_quest = all_quests[randi() % all_quests.size()]
	
	GM.main.setModuleFlag("NanoRevolutionModule", "NanoDailyQuestInfo", new_quest)
	GM.main.setModuleFlag("NanoRevolutionModule", "NanoDailyQuestProgress", 0)
	GM.main.setModuleFlag("NanoRevolutionModule", "NanoDailyQuestLastDay", current_day)
	
	# GM.main.addMessage("A new daily task is available from Humoi.")

func storePlayerSkinColors():
	var pc = GM.pc
	if pc == null:
		return

	# Store base skin colors
	GM.main.setModuleFlag(id, "NanoPlayerBaseSkinR", pc.pickedSkinRColor.to_html())
	GM.main.setModuleFlag(id, "NanoPlayerBaseSkinG", pc.pickedSkinGColor.to_html())
	GM.main.setModuleFlag(id, "NanoPlayerBaseSkinB", pc.pickedSkinBColor.to_html())
	
	# Store bodypart-specific colors
	var bodypart_skins = {}
	for bodypart_slot in pc.bodyparts:
		# print(bodypart_slot)
		var bodypart = pc.bodyparts[bodypart_slot]
		var part_colors = {}
		if bodypart.pickedRColor != null:
			part_colors["r"] = bodypart.pickedRColor.to_html()
		if bodypart.pickedGColor != null:
			part_colors["g"] = bodypart.pickedGColor.to_html()
		if bodypart.pickedBColor != null:
			part_colors["b"] = bodypart.pickedBColor.to_html()
		
		if !part_colors.empty():
			bodypart_skins[bodypart_slot] = part_colors
			
	GM.main.setModuleFlag(id, "NanoPlayerBodypartSkins", bodypart_skins)
	GM.main.addMessage("Player skin colors have been stored in module flags.")

func restorePlayerSkinColors():
	var pc = GM.pc
	if pc == null:
		return

	# Restore base skin colors
	var base_r = GM.main.getModuleFlag(id, "NanoPlayerBaseSkinR")
	var base_g = GM.main.getModuleFlag(id, "NanoPlayerBaseSkinG")
	var base_b = GM.main.getModuleFlag(id, "NanoPlayerBaseSkinB")
	if base_r != null:
		pc.pickedSkinRColor = Color(base_r)
	if base_g != null:
		pc.pickedSkinGColor = Color(base_g)
	if base_b != null:
		pc.pickedSkinBColor = Color(base_b)

	# Restore bodypart-specific colors
	var bodypart_skins = GM.main.getModuleFlag(id, "NanoPlayerBodypartSkins", {})
	for bodypart_slot in bodypart_skins:
		if pc.hasBodypart(bodypart_slot):
			var bodypart = pc.getBodypart(bodypart_slot)
			var part_colors = bodypart_skins[bodypart_slot]
			if part_colors.has("r"):
				bodypart.pickedRColor = Color(part_colors["r"])
			if part_colors.has("g"):
				bodypart.pickedGColor = Color(part_colors["g"])
			if part_colors.has("b"):
				bodypart.pickedBColor = Color(part_colors["b"])
	
	pc.updateAppearance()
	GM.main.addMessage("Player skin colors have been restored from module flags.")

func updateThemeByContamination():
	if !GM.main.getModuleFlag(id, "NanoEnableThemeChangeByContamination", true):
		return

	# Update theme color based on contamination
	var contamination_effect = GM.pc.getEffect("Nano_Contamination")
	var contamination_level = 0.0
	if contamination_effect != null:
		contamination_level = float(floor(contamination_effect.stacks)) / 100.0
	
	var start_panel_color = Color8(53, 34, 93)
	var end_panel_color = Color8(25, 25, 35)
	var current_panel_color = start_panel_color.linear_interpolate(end_panel_color, contamination_level)
	
	var start_bg_color = Color8(63, 62, 125)
	var end_bg_color = Color8(5, 5, 5)
	var current_bg_color = start_bg_color.linear_interpolate(end_bg_color, contamination_level)
	
	ThemeManager.change_theme(current_panel_color, current_bg_color)

func hasEmergyWithHumoi():
	var C1_needs_to_find = GM.main.getModuleFlag(id, "NanoChapter1_contamination_start", false)
	var C1_has_found = GM.main.getModuleFlag(id, "NanoChapter1_contamination_start_find_humoi", false)
	
	if C1_needs_to_find and not C1_has_found:
		return true
		
	return false
