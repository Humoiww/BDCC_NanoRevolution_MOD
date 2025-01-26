extends "res://Scenes/SceneBase.gd"

var npcID = ""
var npcID2 = ""
var sawBefore = false
var npcVariation = ""
var bribeSuccess = false
var subOffered = ""
var extractAmount = 0
var refuseTime = 0
var severity = ""
var initialSize = -1

func _init():
	sceneID = "NanoCallingScene"

func _initScene(_args = []):
	npcID = _args[0]
	npcID2 = _args[1]
	# var npc = GlobalRegistry.getCharacter(npcID)
	
	# if(npc.getFlag(CharacterFlag.Introduced)):
	# 	sawBefore = true
	# else:
	# 	npc.setFlag(CharacterFlag.Introduced, true)
		
	# var personality:Personality = npc.getPersonality()
	# if(personality.getStat(PersonalityStat.Mean) > 0.3 || personality.getStat(PersonalityStat.Subby) < -0.6):
	# 	npcVariation = "mean"
	# if(personality.getStat(PersonalityStat.Mean) < -0.3):
	# 	npcVariation = "kind"
	# if(personality.getStat(PersonalityStat.Subby) > 0.6 || personality.getStat(PersonalityStat.Coward) > 0.8):
	# 	npcVariation = "subby"
	
func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return npcID

# An enginnering function to calculate success probability
func fermidistribution(x,level,a=5,level_ref=2):
	return 1.0 / (exp(a * (level_ref*x - level) / level) + 1.0)

func _run():
	if(state == ""):
		addCharacter(npcID)
		addCharacter(npcID2)
		playAnimation(StageScene.Choking, "idle", {pc = npcID2, npc=npcID, bodyState={exposedCrotch=true,hard=true}})
	if(state == ""):

		saynn("[say=npc]Wha?[/say]") 

		# (if not naked)
		
		GM.main.getCharacter(npcID).addPain(1000)


		addButton("Continue", "See what happened next", "leaveandendthescene")



func _react(_action: String, _args):
	if(_action == "get_frisked"):
		for item in GM.pc.getInventory().getItemsWithTag(ItemTag.Illegal):
			addMessage(item.getStackName()+" was taken away")
		for item in GM.pc.getInventory().getEquippedItemsWithTag(ItemTag.Illegal):
			addMessage(item.getStackName()+" was taken away")
	
	if(_action == "friskAndEndthescene"):
		GM.pc.getInventory().removeItemsList(GM.pc.getInventory().getItemsWithTag(ItemTag.Illegal))
		GM.pc.getInventory().removeEquippedItemsList(GM.pc.getInventory().getEquippedItemsWithTag(ItemTag.Illegal))
		
		endScene()
		return
	


	if(_action == "force_end"):
		processTime(30*60)
		GM.pc.doPainfullyStretchHole(BodypartSlot.Anus, npcID)
		GM.pc.gotAnusFuckedBy(npcID)
		GM.pc.cummedInAnusBy(npcID, FluidSource.Penis,20)
		GM.pc.cummedInMouthBy("pc", FluidSource.Penis)
		
		GM.pc.addSkillExperience(Skill.SexSlave, 20)


	if(_action == "convert_to_sex_mode"):
		var _npc = getCharacter(npcID)
	if(_action == "outside"):
		GM.pc.addSkillExperience(Skill.SexSlave, 20, "cpguard_suckcock")

	if(_action == "facial"):
		GM.pc.cummedOnBy(npcID, FluidSource.Penis)
		GM.pc.addSkillExperience(Skill.SexSlave, 20, "cpguard_suckcock")

	if(_action == "mouth"):
		GM.pc.cummedInMouthBy(npcID, FluidSource.Penis)
		GM.pc.addSkillExperience(Skill.SexSlave, 20)
	if(_action == "allowFullAndendthescene"):
		endScene()
		return

	if(_action == "leaveandendthescene"):
		# GM.pc.setLocation("hall_mainentrance")
		endScene()
		return
	
	if(_action == "loseandendthescene"):
		GM.pc.getInventory().removeItemsList(GM.pc.getInventory().getItemsWithTag(ItemTag.Illegal))
		GM.pc.getInventory().removeEquippedItemsList(GM.pc.getInventory().getEquippedItemsWithTag(ItemTag.Illegal))
		if(severity == "tough"):
			# reset npc status
			var _npc = getCharacter(npcID)
			if(initialSize > 0):
				var _penis = _npc.getBodypart(BodypartSlot.Penis)
				_penis.lengthCM = initialSize
			else:
				var _penis = _npc.removeBodypart(BodypartSlot.Penis)
		runScene("StocksPunishmentScene")
		endScene()
		return
		

	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "fight"):
		runScene("FightScene", [npcID], "nanoguardfight")
	
	if(_action == "extract_core"):
		GM.pc.addSkillExperience("NanoENGR", 25)

	if(_action == "extract_continue"):
		GM.pc.addSkillExperience("NanoENGR", 10)
	
	if(_action == "startsexsubby"):
		getCharacter(npcID).prepareForSexAsDom()
		var personality:Personality = getCharacter(npcID).getPersonality()
		personality.setStat(PersonalityStat.Subby,-1.0)
		# getCharacter(npcID).setstate
		# getCharacter(npcID).fe
		GlobalRegistry.getCharacter(npcID).addPain(-50)
		runScene("GenericSexScene", [npcID, "pc"], "subbysex")
	
	if(_action == "startsexasdom"):
		var personality:Personality = getCharacter(npcID).getPersonality()
		personality.setStat(PersonalityStat.Subby,1.0)
		runScene("GenericSexScene", ["pc", npcID], "domsex")
	
	if(_action == "openinventory"):
		runScene("InventoryScene")
		return
	
	if(_action == "strugglemenu"):
		runScene("StrugglingScene")
		return
	
	if(_action == "bring_to_stock"):
		if(severity == "tough"):
			var _npc = getCharacter(npcID)
			if(_npc.hasPenis()):
				var _penis = _npc.getBodypart(BodypartSlot.Penis)
				initialSize = _penis.lengthCM
				_penis.lengthCM = 40
			else:
				var penis = GlobalRegistry.createBodypart("equinepenis")
				_npc.giveBodypartUnlessSame(penis)
				var _penis = _npc.getBodypart(BodypartSlot.Penis)
				initialSize = -1
				_penis.lengthCM = 40
				var npcSkinData={
				"penis": {"r": Color("ff242424"),"g": Color("ff070707"),"b": Color("ff01b2f9"),},
				}
				for bodypartSlot in npcSkinData:
					if(!_npc.hasBodypart(bodypartSlot)):
						#Log.error(getID()+" doesn't have "+str(bodypartSlot)+" slot but we're trying to paint it anyway inside paintBodyparts()")
						continue
					var bodypart = _npc.getBodypart(bodypartSlot)
					var bodypartSkinData = npcSkinData[bodypartSlot]
					if(bodypartSkinData.has("skin")):
						bodypart.pickedSkin = bodypartSkinData["skin"]
					if(bodypartSkinData.has("r")):
						bodypart.pickedRColor = bodypartSkinData["r"]
					if(bodypartSkinData.has("g")):
						bodypart.pickedGColor = bodypartSkinData["g"]
					if(bodypartSkinData.has("b")):
						bodypart.pickedBColor = bodypartSkinData["b"]
			_npc.updateAppearance()
				
	
	setState(_action)


func _react_scene_end(_tag, _result):
	if(_tag in ["subbysex", "domsex"]):
		# setModuleFlag("CellblockModule", "Cellblock_FreeToPassCheckpoint", true)
		endScene()
	
	if(_tag == "nanoguardfight"):
		processTime(20 * 60)
		var battlestate = _result[0]
		if(battlestate == "win"):
			setState("won_fight")
			GM.pc.addSkillExperience("NanoENGR", 50)
			addExperienceToPlayer(30)
		else:
			setState("lost_fight")
			GM.pc.addSkillExperience("NanoENGR", 25)
			addExperienceToPlayer(5)
			var baseNum = 1
			if(refuseTime > 5):
				baseNum = 2
			elif(refuseTime > 10):
				baseNum = 3

			for item in GM.pc.getInventory().forceRestraintsWithTag(ItemTag.CanBeForcedByGuards, RNG.randi_range(baseNum, int(ceil(refuseTime/2)))):
				addMessage(item.getForcedOnMessage())


func getDevCommentary():
	return "This part actually based one the check point guard scene. Now I adjust with a new minigame"

func hasDevCommentary():
	return true

func saveData():
	var data = .saveData()
	
	data["npcID"] = npcID
	data["sawBefore"] = sawBefore
	data["npcVariation"] = npcVariation
	data["bribeSuccess"] = bribeSuccess
	data["subOffered"] = subOffered
	
	return data
	
func loadData(data):
	.loadData(data)
	
	npcID = SAVE.loadVar(data, "npcID", "")
	sawBefore = SAVE.loadVar(data, "sawBefore", false)
	npcVariation = SAVE.loadVar(data, "npcVariation", "")
	bribeSuccess = SAVE.loadVar(data, "bribeSuccess", false)
	subOffered = SAVE.loadVar(data, "subOffered", "")
