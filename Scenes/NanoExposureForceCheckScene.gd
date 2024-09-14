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
var newMode = ""
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
	sceneID = "NanoExposureForceCheckScene"

func _initScene(_args = []):
	npcID = _args[0]
	var npc = GlobalRegistry.getCharacter(npcID)
	
	if(npc.getFlag(CharacterFlag.Introduced)):
		sawBefore = true
	else:
		npc.setFlag(CharacterFlag.Introduced, true)
		
	var personality:Personality = npc.getPersonality()
	if(personality.getStat(PersonalityStat.Mean) > 0.3 || personality.getStat(PersonalityStat.Subby) < -0.6):
		npcVariation = "mean"
	if(personality.getStat(PersonalityStat.Mean) < -0.3):
		npcVariation = "kind"
	if(personality.getStat(PersonalityStat.Subby) > 0.6 || personality.getStat(PersonalityStat.Coward) > 0.8):
		npcVariation = "subby"
	
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
	if(state == "" && !getModuleFlag("NanoRevolutionModule", "NanoCheckHappened", false)):
		setModuleFlag("NanoRevolutionModule", "NanoCheckHappened", true)
		setModuleFlag("NanoRevolutionModule", "NanoCheckSRefuseTimes", 0)
		saynn("When you walk around, you just notice an android with dark blue skin color approach you")

		saynn("{npc.himHer} gives you a stop sign.")

		saynn("[say=npc]Greating, Inmate number {pc.inmateNumber}, how's your day going?[/say]")

		saynn("[say=pc]Good I suppose?[/say]")

		saynn("[say=npc]That's excellent, may I have your name please? Just for reference.[/say]")

		saynn("[say=pc]It's {pc.name}, can I go now?[/say]")

		saynn("[say=npc]Sorry {pc.name}, we have to frisk you. Please stand against a wall.[/say]")

		# (if not naked)
		if(!GM.pc.isFullyNaked()):
			saynn("[say=pc]Why?[/say]")

			saynn("[say=npc]According to the prison law 1437, inmates should not have any stuff labeled illegal. And we will check periodically to ensure safety.[/say]")

			saynn("[say=pc]And what is illegal?[/say]")

			saynn("[say=npc]Illegal item include but not limited to weapons, contraband, and stollen stuff. Your personal inventory UI should show the stuff label for reference.[/say]")
		# (if naked)
		else:
			saynn("[say=pc]Can’t you see that I don’t have anything, I’m naked[/say]")

			saynn("[say=npc]I'm afraid that we still need to complete frisking process. According to our frisking record, 20% Inmates hide item in their private area.[/say]")

		saynn("The nano guard will check you every time when they meet you. What do you wanna do?")
	elif(state == ""):
		saynn("The nano guard stops you.")

		saynn("[say=npc]{pc.name}, we have to frisk you. Please stand against a wall.[/say]")
		
		saynn("What do you wanna do?")
	if(state == ""):
		addButton("Get frisked", "Let "+ GlobalRegistry.getCharacter(npcID).himHer() +" frisk you", "get_frisked")
		# addButtonWithChecks("Offer handjob", "Maybe he will let you through if you let his cock out", "offer_handjob", [], [
		# 	ButtonChecks.NotHandsBlocked,
		# 	ButtonChecks.NotLate,
		# 	[ButtonChecks.SkillCheck, Skill.SexSlave, 1],
		# 	])
		addButton("Refuse", "You don’t wanna get frisked!", "intimidate")
		# addButton("Leave", "You don’t wanna get frisked", "leave")
		if(GM.pc.hasPerk("NanoDistraction")):
			addButton("Distract!", "Making the android think you are not here.", "leave")
		else:
			addDisabledButton("Leave", "The guard keep all their attention on you")

	if(state == "leave"):
		saynn("[say=npc]Warning: cannot track inmate {pc.inmateNumber}.[/say]")

		saynn("It is still weird that this seemly advance android will lose its attention. Whatever, now you can leave now")

		addButton("leave", "", "leaveandendthescene")

	if(state == "get_frisked"):
		playAnimation(StageScene.SexStanding, "tease", {
			pc=npcID,npc="pc",
			bodyState={},
			npcBodyState={},
		})
		
		saynn("You stand against a wall and wait for the guy. He stands behind you and makes you spread your feet more.")

		saynn("He then crouches and starts going from bottom to the top, his hands slide along the curves of your {pc.thick} body, searching for anything unusual. He checks any pockets too.")

		saynn("Then he pulls out some kind of scanner and uses it on you. He probably could have just done that from the start.")

		# (if has something)
		if(GM.pc.hasIllegalItems()):
			saynn("[say=npc]That’s contraband. Where did you find that, inmate?[/say]")

			saynn("[say=pc]On the floor?[/say]")

			saynn("[say=npc]I will be taking that away[/say]")

			saynn("Well, what can you do. You roll your eyes and walk away.")
		else:
		# (if clear)
			saynn("[say=npc]Alright, you’re clear.[/say]")

			saynn("You continue on your way.")
		
		addButton("Continue", "Time to go", "friskAndEndthescene")

		
	if(state == "intimidate"):
		saynn("[say=pc]How about you let me leave peacefully.[/say]")

		saynn("The guard straightens eye start to flash")
		increaseModuleFlag("NanoRevolutionModule", "NanoCheckSRefuseTimes", 1)
		refuseTime = getModuleFlag("NanoRevolutionModule", "NanoCheckSRefuseTimes", 0)
		severity = "tough"
		if(refuseTime < 5):
			severity = "slight"
		elif((refuseTime < 10) || !(getModuleFlag("NanoRevolutionModule", "NanoToughEnable", true))):
			severity = "moderate"
		if(refuseTime < 2):
			saynn("[say=npc]I see, {pc.name}. Since this is the first time, we will let you leave. But let me explain our rule, after this time, we will force punishment on you. The severity of punishment is depending on your total refusing times. You can leave now.[/say]")

			addButton("leave", "Well, prepare for the next time then", "leaveandendthescene")
		else:
			saynn("[say=npc]{pc.name}, you have refuse our frisking request " + str(refuseTime) +" times. We will force " + severity + " punishment on you. Initiating attack protocol.[/say]")

			saynn("Seems like it’s a fight.")
			
			addButton("Fight", "Start the fight", "fight")

	if(state == "lost_fight"):
		if(severity == "slight"):
			playAnimation(StageScene.Duo, "Standing", {pc = npcID, npc="pc"})
			saynn("Defeated, you fall to your knees.")
		else:
			playAnimation(StageScene.Choking, "idle", {pc = npcID, npc="pc", bodyState={exposedCrotch=true,hard=true}})
			saynn("Defeated, you fall to your knees. But then the sticky android chock your neck!")

		saynn("[say=npc]Confrontation ended successfully. Inmate's status: completely submissive. Securing. Excuting "+ severity +" punishment mode.[/say]")

		saynn("Before your realize, some BDSM devices magically bonds on you.")

		if(severity == "slight"):
			saynn("[say=npc]Attach slight BDSM device success. All possible illegal items collected. You can leave now inmate.[/say]")
			saynn("Well, at least you've learnt some nano stuff from this fight.")
			# (scene ends)
			addButton("Continue","Ouch","friskAndEndthescene")
		else:
			saynn("[say=npc]Bondage secure. Bringing inmate to punishment stock.[/say]")
			saynn("The android chocking your neck, force you follow its step.")
			addButton("Struggle", "", "bring_to_stock")
	if(state == "bring_to_stock"):
		GM.pc.setLocation("main_punishment_spot")
		aimCamera("main_punishment_spot")
		if(severity == "moderate"):
			playAnimation(StageScene.Stocks, "idle")
			saynn("[say=npc]Inmate Secured. {pc.name}, hope you will follow our instruction next time.[/say]")
			saynn("Now you need to figure out how to escape here")
			addButton("Continue", "Ouch", "loseandendthescene")
		else:
			playAnimation(StageScene.StocksSex, "tease", {pc="pc", npc=npcID, bodyState={exposedCrotch=true}, npcBodyState={exposedCrotch=true, hard=true}})

			saynn("[say=npc]Inmate Secured. Initiating anal punishment. Modifying body to punishment mode.[/say]")

			saynn("The android guard cock erect out. You estimate it about 40 cm long.")

			saynn("[say=pc]Wait! That won't fit..[/say]")

			addButton("Resist", "That just... too big", "force_anal")			
	if(state == "force_anal"):
		playAnimation(StageScene.StocksSex, "sex", {pc="pc", npc=npcID, bodyState={exposedCrotch=true}, npcBodyState={exposedCrotch=true, hard=true}})
		saynn("The android thick cock force penetrate inside your anus.")

		saynn("[say=pc]Please... Stop....[/say]")

		saynn("The android ignore your request, mechanically insert back and forth again and again")

		addButton("Submit", "Ahh", "force_end")

	if(state == "force_end"):
		playAnimation(StageScene.StocksSex, "fast", {pc="pc", npc=npcID, pcCum=true, npcCum=true, bodyState={exposedCrotch=true}, npcBodyState={exposedCrotch=true, hard=true}})

		saynn("[say=npc]Inmate state: close. Injecting simulated cum.[/say]")

		saynn("All of sudden, you feel massive amount of hot liquid flux into your stomach. But the cum don't stop, you feel your stomach become bigger and bigger, something coming down your throat! Does this cum just pass through your whole body?!")

		saynn("[say=pc]Ahh.....h....h...[/say]")
		saynn("[say=npc]Punishment completed. Enjoy rest of your day, {pc.name}.[/say]")

		saynn("Now you need to figure out how to escape here")
		
		addButton("Continue", "Ouch", "loseandendthescene")

	if(state == "won_fight"):
		
		saynn("The defeated guard sits on the floor, unable to continue fighting.")

		saynn("[say=npc]FATAL ERROR: Damage exceed system threshold. Entering energy saving mode[/say]")

		saynn("Winning this fight makes you understand more about nano engineering")

		saynn("You check the android, their body just become too stiff to use for your pleasure.")
		
		addWonButton()
		
	if(state == "hack_fail"):
		saynn("You try to hack in, but nothing changed.")
		if(!GM.main.getModuleFlag("NanoRevolutionModule", "NanoTriggerKeyQuest", false)):
			GM.main.setModuleFlag("NanoRevolutionModule", "NanoTriggerKeyQuest", true)
			saynn("Looks like you need to find the key first.")

			addMessage("Add Quest: 'Figure out the key'")
		
		addWonButton()

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
		saynn("You successfully convert it to sex mode.")

		addButton("Continue","See what happened next","convertsexend")

	if(state == "convert_to_guard_mode"):
		saynn("You switch the android to guard mode, nothing changed.")
		
		addWonButton()

func addWonButton():
	addButton("Walk away", "You got your pass, you can just go", "allowFullAndendthescene")
	# addButtonWithChecks("Catch anal", "Use the guy’s dick for your pleasure", "catch_anal", [], [ButtonChecks.NotHandsBlocked])
	# addButtonWithChecks("Catch virginal", "Use the guy’s dick for your pleasure", "catch_virginal", [], [ButtonChecks.NotHandsBlocked])
	# addButtonWithChecks("Catch oral", "Use the guy’s dick for your pleasure", "catch_oral", [], [ButtonChecks.NotHandsBlocked])

	if(GM.pc.hasPerk("NanoSexMode")):
		addButtonWithChecks("Hack!", "Try to hack in the android system", "enter_hack_scene", [], [ButtonChecks.CanStartSex])
		# addButton("Submit to", "Switch the android to dominative mode", "startsexsubby")
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


	if(_action == "enter_hack_scene"):
		runScene("ComputerSimScene", ["HackAndroid"], "computerhack")

	# if(_action == "convert_to_sex_mode"):

		

	if(_action == "convertsexend"):
		runScene("NanoMeetSexDollScene",[npcID])
		endScene()
		return
		
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

	if(_tag == "computerhack"):
		print(_result)
		if(_result[0] == true):
			var parameter = _result[1]
			newMode = parameter[0]
			if(newMode == "guard"):
				setState("convert_to_guard_mode")
			if(newMode == "sex"):
				setState("convert_to_sex_mode")
				var _npc = getCharacter(npcID)
				getModule("NanoRevolutionModule").doConvertCharacter(npcID)
		else:
			setState("hack_fail")


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
