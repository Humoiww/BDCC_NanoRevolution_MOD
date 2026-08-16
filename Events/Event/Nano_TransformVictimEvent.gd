extends EventBase

const MODULE_ID = "NanoRevolutionModule"

func _init():
	id = "NanoTransformDynamicNpcEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.DefeatedDynamicNPC)
	es.addTrigger(self, Trigger.AfterSexWithDefeatedDynamicNPC)

func run(_triggerID, _args):
	var npcID = _args[0]
	var character:DynamicCharacter = getCharacter(npcID)
	
	if(!character.isDynamicCharacter() || character.getSpecies().has("nanoAndroid")):
		return
	
	if(character.isSlaveToPlayer()):
		return
	if(GM.pc.hasPerk("NanoAssimilation")):
		addButtonWithChecks("Assimilate", "Inject your nano robots to their body.", "doTransfrom", [_args[0]],[ButtonChecks.HasReachablePenis,ButtonChecks.HasReachableVagina,ButtonChecks.NotHandsBlocked,ButtonChecks.NotArmsRestrained])


func getPriority():
	return 0

func onButton(_method, _args):
	# if(_method == "doenslave"):
	# 	runScene("EnslaveDynamicNpcScene", [_args[0]])
	if(_method == "doTransfrom"):
		# GM.main.endCurrentScene()
		runScene("NanoTransformDynamicNpcScene", [_args[0]])
