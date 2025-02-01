extends EventBase

func _init():
	id = "NanoCraftingTableEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringPlayerCell)

func run(_triggerID, _args):
	var coreAmount = GM.pc.getInventory().getAmountOf("NanoCore")
	var fullCharge = GM.main.getModuleFlag("NanoRevolutionModule", "NanoControllerFullCharge", 10)
	var upgradeCost = fullCharge - 9

	if(GM.pc.hasPerk("NanoCraftingT1")):
		if(getModuleFlag("NanoRevolutionModule","NanoCraftingTableEnabled")):
			addButton("Station","Use your nano core to make something","craft")
			if(GM.pc.hasPerk("NanoCraftingT3")):
				saynn("You can use your core to upgrade your controller.")
				sayn("Current Capacity:" + str(fullCharge))
				sayn("Upgrade Cost:" + str(upgradeCost))
				sayn("Cores Amount:" + str(coreAmount))
				if(upgradeCost > coreAmount):
					addDisabledButton("Upgrade","You don't have enough cores.")
				else:
					addButton("Upgrade","Use your nano core toupgrade your controller.\n","upgrade",[upgradeCost])
		else:
			
			if(coreAmount >= 1):
				addButton("Initiate","Use one nano core to shape a craft station","make")
			else:
				addDisabledButton("Initiate","You need one nano core to shape a craft station")
func getPriority():
	return 9

func onButton(_method, _args):
	if(_method == "craft"):
		runScene("NanoCraftScene",["buymenu"])
	if(_method == "make"):
		GM.pc.getInventory().removeXOfOrDestroy("NanoCore",1)
		setModuleFlag("NanoRevolutionModule","NanoCraftingTableEnabled",true)
	if(_method == "upgrade"):
		var cost = _args[0]
		GM.pc.getInventory().removeXOfOrDestroy("NanoCore",cost)
		var fullCharge = GM.main.getModuleFlag("NanoRevolutionModule", "NanoControllerFullCharge", 10)
		fullCharge += 1
		GM.main.setModuleFlag("NanoRevolutionModule", "NanoControllerFullCharge", fullCharge)
	
