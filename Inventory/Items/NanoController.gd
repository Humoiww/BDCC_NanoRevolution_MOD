extends ItemBase

var whoGaveBirth = ""

func _init():
	id = "NanoController"
# so, I just convert the egg item to this new item, wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
func getVisibleName():
	return "Nano Controller - Lite version"

func getDescription():
	var desc = "\n\nCurrent feature:\n"
	desc += "Edit Nano generation response.\n"
	desc += "Calling the android with your own backend.\n"
	var charge = GM.main.getModuleFlag("NanoRevolutionModule", "NanoControllerRemainCharge", 1)
	var fullcharge = GM.main.getModuleFlag("NanoRevolutionModule", "NanoControllerFullCharge", 10)
	desc += "\n\nCharge remain: "+ str(charge) + "/" + str(fullcharge) + "\n"
	desc += "["
	for i in range(fullcharge):
		if i < charge:
			desc += "■"
		else:
			desc += "   "
	desc += "]"
	desc += "\n Recharge to full every morning."
	return "A portable version Nano Controller with limited function." + desc



func useInCombat(_attacker, _receiver):
	if(GM.main.getModuleFlag("NanoRevolutionModule", "NanoControllerRemainCharge", 1) >= 4):
		var sexDollPool = GM.main.getDynamicCharacterIDsFromPool("SexDoll")
		if(sexDollPool.size() > 0):
			var idToUse = NpcFinder.grabNpcIDFromPool("SexDoll")
			if (GM.main.getCurrentFightScene() != null):
				var summon = GM.main.getCharacter(idToUse)
				var damage = summon.painThreshold()
				_receiver.getPain()
				_receiver.painThreshold()
				if(damage+ _receiver.getPain() >= _receiver.painThreshold()):
					GM.main.getCurrentFightScene().runScene("NanoCallingScene",[_receiver.getID(),idToUse])
					GM.main.getCurrentFightScene().endScene(["win"])
				else:
					_receiver.addPain(damage)
					GM.main.removeDynamicCharacterFromAllPools(idToUse)
					return "You try to call " + summon.getName() + " to attack " + _receiver.getName() + ". Unfortunately, it's not strong enough to defeat " + _receiver.getName() + " and collapses into a pool of goo. Before it's gone, it deals " + str(damage) + " damage to " + _receiver.getName() + "."
			else:
				GM.main.runScene("NanoMeetSexDollScene",[idToUse])
			GM.main.increaseModuleFlag("NanoRevolutionModule", "NanoControllerRemainCharge", -4)
			return "You let your sex doll leave away, waiting for your next command."
		else:
			return "You don't have any Sex Doll, better go and get some?"
	else:
		return "You try to calling someone. Unfortunately, you just notice that your device does not have enough charge."
	
	

func getPossibleActions():
	var action = []
	action.append({
			"name": "Setting!",
			"scene": "NanoSetting",
			"description": "Entering the setting part",
			"onlyWhenCalm": true,
	})
	if(GM.pc.hasPerk("NanoCallBackUp")):
		action.append({
				"name": "Calling",
				"scene": "UseItemLikeInCombatScene",
				"description": "(Charge: 4) Call one of your sex doll. Useless if you don't have any sex doll.",
		})
	return action

func getPrice():
	return 0

func canSell():
	return true

func canCombine():
	return true

func isImportant():
	return true
# func tryCombine(_otherItem):
# 	if(whoGaveBirth != _otherItem.whoGaveBirth):
# 		return false
# 	return .tryCombine(_otherItem)

func getTags():
	return []


func getItemCategory():
	return "Nano"

# func getAttacks():
# 	return ["NanoCallingBackup"]
# func saveData():
# 	var data = .saveData()
	
# 	data["whoGaveBirth"] = whoGaveBirth
	
# 	return data
	
# func loadData(data):
# 	.loadData(data)
	
# 	whoGaveBirth = SAVE.loadVar(data, "whoGaveBirth", "")
	
func getInventoryImage():
	return "res://Modules/NanoRevolution/Images/Perks/NanoCorePerk.png"
