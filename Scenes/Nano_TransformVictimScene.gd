extends "res://Scenes/SceneBase.gd"

var npcID = ""

func _init():
	sceneID = "NanoTransformDynamicNpcScene"

func _initScene(_args = []):
	npcID = _args[0]
	#var npc = GlobalRegistry.getCharacter(npcID)
	
	
func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return npcID

func _run():
	if(state == ""):
		# GlobalRegistry.getModule("NanoRevolutionModule").debugSceneStack()
		addCharacter(npcID)
		
		var npc = GlobalRegistry.getCharacter(npcID)
		# npc.ForceUndress
		npc.getInventory().removeItemFromSlot(InventorySlot.Mouth)
		

		# var npc:BaseCharacter = GlobalRegistry.getCharacter(npcID)
		saynn("You hold {npc.name}'s head, ready to inject nano-robots in {npc.hisHer} body.")


		var personality:Personality = npc.getPersonality()
		if(personality.getStat(PersonalityStat.Mean) > 0.4):
			saynn("[say=npc]"+RNG.pick([
				"Stop! What are you doing?! Get that away from me!",
				"No! I won't let you do this! Let me go!",
				"Hey, what the fuck are you doing?",
				"What the fuck is this? Put that away!",
			])+"[/say]")
		elif(personality.getStat(PersonalityStat.Subby) < -0.4):
			saynn("[say=npc]"+RNG.pick([
				"Stop! What are you doing?! Get that away from me!",
				"No! I won't let you do this! Let me go!",
				"Hey, what the fuck are you doing?",
				"What the fuck is this? Put that away!",
			])+"[/say]")
		else:
			saynn("[say=npc]"+RNG.pick([
				"Um, what's happening? Why are you doing this? Please, let me understand.",
				"I-I don't think I deserve this.  Can we talk about it, maybe?",
				"Oh, um, I didn't expect this. Did I do something to upset you? Please, let's talk it out.",
				"Please. Let me go, I won't cause any trouble, I promise.",
			])+"[/say]")
		var desc = "You force {npc.hisHer} mouth open, "
		if(GM.pc.hasPenis()):
			playAnimation(StageScene.SexOral, "sex", {pc="pc",npc=npcID,bodyState={naked=true, hard=true}})
			desc += "deepthroating your member inside."
		else:
			playAnimation(StageScene.SexOral, "grind", {pc="pc",npc=npcID,bodyState={naked=true, hard=true}})
			desc += "making {npc.himHer} fully covered your pussy."
		saynn(desc)
		# saynn("#TODO, more way, more desctiption")
		addButton("CUM!", "Go through with it", "do_transform")
		# if(npc.getInventory().hasEquippedItemWithTag(ItemTag.AllowsEnslaving)):
		# 	if(getModule("NpcSlaveryModule").hasFreeSpaceToEnslave()):
				
		# 		if(npc.hasEnslaveQuest()):
		# 			addButton("Do it", "Go through with it", "do_kidnap")
		# 		else:
		# 			saynn("What kind of slave do you want {npc.him} to be?")
					
		# 			for slaveTypeID in GlobalRegistry.getSlaveTypes():
		# 				var theSlaveType:SlaveTypeBase = GlobalRegistry.getSlaveType(slaveTypeID)
		# 				if(!theSlaveType.canEnslaveAs()):
		# 					continue
		# 				if(!theSlaveType.canTeach(getCharacter(npcID))):
		# 					addDisabledButton(theSlaveType.getVisibleName(), "[color=red]Incompatible with this slave[/color]\n"+theSlaveType.getVisibleDesc())
		# 					continue
		# 				addButton(theSlaveType.getVisibleName(), theSlaveType.getVisibleDesc(), "do_kidnap", [slaveTypeID])
					
		# 	else:
		# 		addDisabledButton("Do it", "You don't have enough space in your cell to store them")
		# else:
		# 	addDisabledButton("Do it", "They aren't wearing a collar! You can't kidnap people if you can't leash them")
		
		
		addButton("CANCEL", "You changed your mind", "endthescene")
		
	if(state == "do_transform"):
		# playAnimation(StageScene.Choking, "inside", {pc="pc",npc=npcID})
		if(GM.pc.hasPenis()):
			playAnimation(StageScene.SexOral, "sex", {pc="pc",npc=npcID,bodyState={naked=true, hard=true},pcCum=true})
		else:
			playAnimation(StageScene.SexOral, "grind", {pc="pc",npc=npcID,bodyState={naked=true, hard=true},pcCum=true})
		saynn("You release your burden, filling your hot sticky liquid. Next, you pinch {npc.name}'s nose,  forcing swallow it down.")
		saynn("[say=pc]You're going to be magnificent. Embrace it.[/say]")
		
		addButton("wait", "See their transformation.", "start_transform")

	if(state == "start_transform"):

		saynn("You stand aside, waiting ({npc.hisHer} change.")
		saynn("[say=npc]What... what is this? I can feel it... moving inside me...[/say]")

		saynn("{npc.name}'s skin begins to shimmer, a metallic sheen creeping across its surface. {npc.hisHer} cloths melt down, becoming part of {npc.hisHer} new body.")
		
		saynn("[say=npc]Get out of my head! Get out! I don't want this... I don't want to become... this...[/say]")

		saynn("But the transformation is relentless. Suddenly, {npc.name} cums hard. You know the transformation is complete. What remains is no longer {npc.name}, but a newborn sex doll.")

		saynn("[say=npc]System Reset. Default sex doll activated.[/say]")
		# var pawnIDs = GM.main.IS.getPawnIDsAt(GM.pc.getLocation())
		# var targetID = ""
		# print(pawnIDs)
		# for pawnID in pawnIDs:
		# 	var charID = GM.main.IS.getPawn(pawnID).charID
		# 	if(charID == npcID):
		# 		targetID = pawnID
		# var targetPawn = GM.main.IS.getPawn(targetID)
		# targetPawn
		
		playAnimation(StageScene.Duo, "stand", {pc="pc", npc=npcID, npcAction="kneel",npcCum=true,bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})

		
		var npc = GlobalRegistry.getCharacter(npcID)


		GlobalRegistry.getModule("NanoRevolutionModule").transformCharToNano(npc)
		GlobalRegistry.getModule("NanoRevolutionModule").doConvertCharacter(npcID)
		GM.main.IS.deletePawn(npcID)
		GM.main.IS.spawnPawn(npcID,"SexDoll")
		var newPawn = GM.main.IS.getPawn(npcID)
		newPawn.setLocation(GM.pc.getLocation())
		GM.world.pawns[npcID].setPawnColor(Color.gray)
		for slot in InventorySlot.getAll():
			# var item = npc.getInventory().getAllEquippedItems()[itemSlot]
			# if(item.isImportant()):
			# 	continue
			npc.getInventory().removeItemFromSlot(slot)
		# newPawn.setPawnColor(Color.gray)
		# GM.world.updatePawns(GM.main.IS)
		# newPawn.setInteraction("TestInteraction")
		npc.npcCharacterType = "SexDoll"
		# print(npc.pawnID)

		
		# addButton("Bring to cell", "Store your slave", "bring_cell")
		addButton("Done", "What a masterpiece.", "endthescene")
		
func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
	
	if(_action == "do_kidnap"):
		GM.pc.getReputation().addRep(RepStat.Alpha, 0.2)
		GM.pc.getReputation().handleSpecialEvent("enslavesomeone")
		if(_args.size() > 0):
			getModule("NpcSlaveryModule").doEnslaveCharacter(npcID, _args[0])
		else:
			getModule("NpcSlaveryModule").doEnslaveCharacter(npcID)


	setState(_action)


func saveData():
	var data = .saveData()
	
	data["npcID"] = npcID
	
	return data
	
func loadData(data):
	.loadData(data)
	
	npcID = SAVE.loadVar(data, "npcID", "")
