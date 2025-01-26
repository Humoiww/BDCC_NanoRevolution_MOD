extends EventBase

func _init():
	id = "NanoTransformDynamicNpcEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.DefeatedDynamicNPC)
	es.addTrigger(self, Trigger.AfterSexWithDefeatedDynamicNPC)

func run(_triggerID, _args):
	var npcID = _args[0]
	var character:DynamicCharacter = getCharacter(npcID)
	
	if(!character.isDynamicCharacter()):
		return
	
	if(character.isSlaveToPlayer()):
		return
	addButton("Debug1", "Try to transform them.", "doTransfrom", [_args[0]])
	# addButton("Debug2!", "Try to enslave them", "doenslave", [_args[0]])
	GlobalRegistry.getModule("NanoRevolutionModule").debugSceneStack()
	# if(character.hasEnslaveQuest()):
	# 	var enslaveQuest:NpcEnslavementQuest = character.getEnslaveQuest()
	# 	if(enslaveQuest.isEverythingCompleted()):
			
	# 	else:
	# 		addDisabledButton("Kidnap!", "They are not ready to be kidnapped")
	# else:
	# 	if(!getModule("NpcSlaveryModule").canEnslave()):
	# 		if(_triggerID == Trigger.DefeatedDynamicNPC):
	# 			addDisabledButton("Enslave!", "Your cell is not big enough for this. Find someone who can upgrade it first.")
	# 		return
		
	# 	if(!character.hasEnslaveQuest() ):
	# 		if(character.getInventory().hasEquippedItemWithTag(ItemTag.AllowsEnslaving)):
				
	# 		else:
	# 			if(_triggerID == Trigger.DefeatedDynamicNPC):
	# 				addDisabledButton("Enslave!", "They need to be wearing a collar for you to be able to enslave them")
		

func getPriority():
	return 0

func onButton(_method, _args):
	# if(_method == "doenslave"):
	# 	runScene("EnslaveDynamicNpcScene", [_args[0]])
	if(_method == "doTransfrom"):
		# GM.main.endCurrentScene()
		runScene("NanoTransformDynamicNpcScene", [_args[0]])
