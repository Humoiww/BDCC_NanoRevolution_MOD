extends ItemBase


func _init():
	id = "InstantCharger"

func getVisibleName():
	return "Instant Charger"

func getDescription():
	return "An energitic charger that can instantly charge your controller to full charge." 

func canUseInCombat():
	return true

func useInCombat(_attacker, _receiver):
	var desc
	desc = _attacker.getName() + " restore the controller to the full charge!"
	var charge = GM.main.getModuleFlag("NanoRevolutionModule", "NanoControllerFullCharge", 10)
	GM.main.setModuleFlag("NanoRevolutionModule", "NanoControllerRemainCharge", charge)
	removeXOrDestroy(1)
	return desc

func getPossibleActions():
	var action = []

	action.append({
		"name": "Use one!",
		"scene": "UseItemLikeInCombatScene",
		"description": "Charge your controller to full charge.",
	})
	return action

func getPrice():
	return 10

func canSell():
	return true

func canCombine():
	return true


func getTags():
	return []


func getItemCategory():
	return "Nano"

	
func getInventoryImage():
	return "res://Modules/NanoRevolution/Images/Perks/NanoCorePerk.png"
