extends "res://Scenes/SceneBase.gd"

var npcID = ""
var sawBefore = false
var npcVariation = ""
var bribeSuccess = false
var subOffered = ""
var extractAmount = 0
var refuseTime = 0
var severity = ""
var initialSize = -1

func showAndroidStatus(possibility):
	if(possibility > 90):
		saynn("The android seems very stable.")
	elif(possibility > 80):
		saynn("The android appears mostly stable.")
	elif(possibility > 70):
		saynn("The android is generally stable.")
	elif(possibility > 60):
		saynn("The android shows slight signs of instability.")
	elif(possibility > 50):
		saynn("The android’s stability is somewhat questionable.")
	elif(possibility > 40):
		saynn("The android is showing noticeable instability.")
	elif(possibility > 30):
		saynn("The android is becoming increasingly unstable.")
	elif(possibility > 20):
		saynn("The android is highly unstable.")
	elif(possibility > 10):
		saynn("The android’s system is on the verge of collapse.")
	else:
		saynn("The android is completely unstable and close to failure.")
		saynn("That's... ridiculous! I mean, it's nearly impossible to succeed so many times just to see this message!")

func _init():
	sceneID = "NanoMeetSexDollScene"

func _initScene(_args = []):
	npcID = _args[0]
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
		playAnimation(StageScene.Duo, "stand", {npc=npcID})
	if(state == ""):

		saynn("[say=npc]Hello, sir. What can I serve you today.[/say]")

		# (if not naked)
		

		addButton("Sex!", "Start sex at dominative position.", "startsexasdom")
		addButton("Submit!", "Enable Dominativate Mode","startsexassub")
		addButton("Masturbate","You want your doll to solve your heat.", "masturbate_selection")
		addButton("Toilet","You want to use them as toilet.","toilet")
		addButton("Massage","You want them to relax you, recover some stamina","Massage")
		# addButtonWithChecks("Offer handjob", "Maybe he will let you through if you let his cock out", "offer_handjob", [], [
		# 	ButtonChecks.NotHandsBlocked,
		# 	ButtonChecks.NotLate,
		# 	[ButtonChecks.SkillCheck, Skill.SexSlave, 1],
		# 	])
		if(GM.pc.hasPerk("NanoExtration")):
			addButton("Extract","You don't want this sex doll any more, time to extract" + GlobalRegistry.getCharacter(npcID).hisHer() +" core.","extract_core")
		addButton("leave", "You don't want to do anything for now.", "leaveandendthescene")
		# addButton("Refuse", "You don’t wanna get frisked!", "intimidate")
		# # addButton("Leave", "You don’t wanna get frisked", "leave")
		# if(GM.pc.hasPerk("NanoDistraction")):
		# 	addButton("Distract!", "Making the android think you are not here.", "leave")
		# else:
		# 	addDisabledButton("Leave", "The guard keep all their attention on you")


	if(state == "extract_core"):
		playAnimation(StageScene.SexFisting, "sex", {
			pc="pc", npc=npcID, 
			bodyState={exposedCrotch=true,hard=true},
			npcBodyState={exposedCrotch=true,hard=true},
		})
		if(GM.pc.hasPerk("BetterExtration")):
			extractAmount += 1
			saynn("You start searching the android core, and you find some thing tough inside")

			saynn("Now you can choose to stop and get only one core.")

			saynn("Or you can choose to extract more, with risk of lossing everything")

			var possibility = fermidistribution(extractAmount,GM.pc.getSkillLevel("NanoENGR"))
			possibility = 100*possibility
			showAndroidStatus(possibility)
			if false:
				addButton("Continue", str(possibility).pad_decimals(2) + "%" + "find an extra core\n" + str(100-possibility).pad_decimals(2) + "%" + "loss all the core you find in this fight\n","extract_continue")
			else:
				addButton("Continue", "Extract More","extract_continue")
			addButton("Done", "That is", "extract_end")
		else:
			var anEgg = GlobalRegistry.createItem("NanoCore")
			anEgg.whoGaveBirth = npcID
			anEgg.setAmount(1)
			GM.pc.getInventory().addItem(anEgg)
			saynn("You start searching the android core. Few minutes later, you finally find some thing tough inside")

			saynn("You pull it out, and suddenly, the android guard colapse and become a pad of black goo, slip away")

			saynn("You have a feeling that you will never meet {npc.name} again")
			GM.main.removeDynamicCharacterFromAllPools(npcID)
			addButton("Done", "Weird", "allowFullAndendthescene")


	if(state == "extract_continue"):
		
		var possibility = fermidistribution(extractAmount,GM.pc.getSkillLevel("NanoENGR"))*100
		if RNG.chance(possibility):
			playAnimation(StageScene.SexFisting, "fast", {
				pc="pc", npc=npcID, 
				bodyState={exposedCrotch=true,hard=true},
				npcBodyState={exposedCrotch=true,hard=true},
			})
			extractAmount += 1	
			saynn("Great! You successfully extract one more core from the android's body.")

			saynn("Now you have " + str(extractAmount) + " cores. Wanna have another try?")

			showAndroidStatus(possibility)
			possibility = fermidistribution(extractAmount,GM.pc.getSkillLevel("NanoENGR"))*100
			if false:
				addButton("Continue", str(possibility).pad_decimals(2) + "%" + "find an extra core\n" + str(100-possibility).pad_decimals(2) + "%" + "loss all the core you find in this fight\n","extract_continue")
			else:
				addButton("Continue", "Extract More","extract_continue")
			addButton("Done", "That is", "extract_end")
		else:
			playAnimation(StageScene.Sleeping, "idle", {pc=npcID, pcCum=true, bodyState={naked=true}})
			saynn("Unfortunately, when you try to grab another core, the android can't handle the additional extraction. Its body collapses into a pool of black goo and slips away.")

			saynn("You’ve just lost all the cores you collected in this extraction.")
			addButton("Well", "Better luck next time", "allowFullAndendthescene")
	if(state == "extract_end"):
		playAnimation(StageScene.SexFisting, "tease", {
				pc="pc", npc=npcID, npcCum=true,
				bodyState={exposedCrotch=true,hard=true},
				npcBodyState={exposedCrotch=true,hard=true},
		})
		var anEgg = GlobalRegistry.createItem("NanoCore")
		anEgg.whoGaveBirth = npcID
		anEgg.setAmount(extractAmount)
		GM.pc.getInventory().addItem(anEgg)
		if(extractAmount > 1):
			saynn("You pull " + str(extractAmount) + " cores out. Suddenly, the android guard collapses into a pool of black goo and slips away.")
		else:
			saynn("You make a cautious choice, taking only one core from the android. Suddenly, the android guard collapses into a pool of black goo and slips away.")

		saynn("You have a feeling that you will never meet {npc.name} again")
		GM.main.removeDynamicCharacterFromAllPools(npcID)
		addButton("Done", "Excellent", "allowFullAndendthescene")

	if(state == "convert_to_sex_mode"):
		saynn("You use your terminal and hack in the android guard module. Quiet complex, but you notice that there's an unused sex doll part.")

		saynn("You adjust a bit, and switch success. (TODO: change this text)")
		addButton("Continue","See what happened next","convertsexend")

func addWonButton():
	addButton("Walk away", "You got your pass, you can just go", "allowFullAndendthescene")
	# addButtonWithChecks("Catch anal", "Use the guy’s dick for your pleasure", "catch_anal", [], [ButtonChecks.NotHandsBlocked])
	# addButtonWithChecks("Catch virginal", "Use the guy’s dick for your pleasure", "catch_virginal", [], [ButtonChecks.NotHandsBlocked])
	# addButtonWithChecks("Catch oral", "Use the guy’s dick for your pleasure", "catch_oral", [], [ButtonChecks.NotHandsBlocked])

	if(GM.pc.hasPerk("NanoSexMode")):
		addButtonWithChecks("Sex!", "Transform to android running mode to sex doll.", "convert_to_sex_mode", [], [ButtonChecks.CanStartSex])
		# addButton("Submit to", "Switch the android to dominative mode", "startsexsubby")
	else:
		addDisabledButton("Sex!", "The system has shutted down.")
		addDisabledButton("Submit to", "The system has shutted down.")
	addButton("Inventory", "Look at your inventory", "openinventory")
	if(GM.pc.hasPerk("NanoExtration")):
		addButtonWithChecks("Extract Core","get this android core through its hole","extract_core", [], [ButtonChecks.CanStartSex])
	if(GM.pc.getInventory().hasRemovableRestraints()):
		addButton("Struggle", "Struggle out of your restraints", "strugglemenu")

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
