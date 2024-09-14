extends ItemBase


var charges:int = 1

func useCharge(amount = 1):
	charges -= amount
	if(charges <= 0):
		destroyMe()

func getCharges():
	return charges

func _init():
	id = "AutoBonder"

func getVisibleName():
	return "Automatic Bonder"
	
func getDescription():
	return "A compact device designed to replicate the nano guard bonding process. Once activated, it will automatically bond 3~5 BDSM devices with the nearest target. It features an impact trigger, allowing you to use it like a grenade."

func canUseInCombat():
	return true

func useInCombat(_attacker, _receiver):
	for item in _attacker.getInventory().forceRestraintsWithTag(ItemTag.CanBeForcedByGuards, RNG.randi_range(3, 5)):
		GM.main.addMessage(item.getForcedOnMessage())
	removeXOrDestroy(1)
	return _attacker.getName() + " trigger the automatic bonder."

func getPossibleActions():
	return [
		{
			"name": "Activate",
			"scene": "UseItemLikeInCombatScene",
			"description": "Bond your self. If you want to bond others, then this is a Special Attack",
		},
	]

func getPrice():
	return 13

func canSell():
	return true

func canCombine():
	return true

func getAttacks():
	return ["NanoAutoBondPCAttack"]


func getTags():
	return [
		]

func getBuyAmount():
	return 1

func getItemCategory():
	return "Nano"

func getInventoryImage():
	return "res://Modules/NanoRevolution/Images/Perks/NanoCorePerk.png"
