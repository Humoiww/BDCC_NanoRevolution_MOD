extends EventBase

func _init():
	id = "NanoCraftingTableEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringPlayerCell)

func run(_triggerID, _args):
	if(GM.pc.hasPerk("NanoCraftingT1")):
		if(getModuleFlag("NanoRevolutionModule","NanoCraftingTableEnabled")):
			addButton("Station","Use your nano core to make something","craft")
		else:
			var coreAmount = GM.pc.getInventory().getAmountOf("NanoCore")
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
	
