extends ItemBase

var whoGaveBirth = ""

func _init():
	id = "NanoManual"
# so, I just convert the egg item to this new item, wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
func getVisibleName():
	return "Nano Engineering 101"

func getDescription():
	return "A powerful manual that can teach you how to hack android. Two huge words 'READ ME' on the cover."

func canUseInCombat():
	return true

func useInCombat(_attacker, _receiver):
	var desc
	desc = _attacker.getName() + "read the manual, and learn how to use the controller to hack android."
	GM.pc.getSkillsHolder().addPerk("NanoSexMode")
	removeXOrDestroy(1)
	return desc

func getPossibleActions():
	var action = []

	action.append({
		"name": "Read  me!",
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
