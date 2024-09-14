extends ItemBase

var whoGaveBirth = ""

func _init():
	id = "NanoCore"
# so, I just convert the egg item to this new item, wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
func getVisibleName():
	return "Nano Core"

func getDescription():
	var desc
	if("nanoAndroid" in GM.pc.getSpecies()):
		desc = "\nYou are an android, so absorb this will relieve some pain and provide some energy"
	else:
		desc = "PLEASE! Don't eat it! Unless you are a silicon-based life. "
	return "An energitic nano core with mysterious light flash on it. " + desc

func canUseInCombat():
	return true

func useInCombat(_attacker, _receiver):
	var desc
	if("nanoAndroid" in _attacker.getSpecies()):
		desc = _attacker.getName() + "absorbs a nano core, restoring some energy."
		_attacker.addPain(-40)
		_attacker.addStamina(40)
	else:
		desc = _attacker.getName() + " eats a nano...core?  Thanks Rahi there's no death trigger in this game. But please don't do any similar thing in real life X3"
		_attacker.addPain(100000)
		_attacker.addStamina(-1000)
		_attacker.addLust(100000)
	removeXOrDestroy(1)
	return desc

func getPossibleActions():
	var action = []
	if("nanoAndroid" in GM.pc.getSpecies()):
		action.append({
			"name": "Absorb one!",
			"scene": "UseItemLikeInCombatScene",
			"description": "Restore some energy.",
		})
	else:
		action.append({
			"name": "Eat one!",
			"scene": "UseItemLikeInCombatScene",
			"description": "Have you even check the description?!",
		})
	return action

func getPrice():
	return 0

func canSell():
	return true

func canCombine():
	return true

# func tryCombine(_otherItem):
# 	if(whoGaveBirth != _otherItem.whoGaveBirth):
# 		return false
# 	return .tryCombine(_otherItem)

func getTags():
	return [ItemTag.Illegal]


func getItemCategory():
	return "Nano"

# func saveData():
# 	var data = .saveData()
	
# 	data["whoGaveBirth"] = whoGaveBirth
	
# 	return data
	
# func loadData(data):
# 	.loadData(data)
	
# 	whoGaveBirth = SAVE.loadVar(data, "whoGaveBirth", "")
	
func getInventoryImage():
	return "res://Modules/NanoRevolution/Images/Perks/NanoCorePerk.png"
