extends EventBase

const MODULE_ID = "NanoRevolutionModule"

func _init():
	id = "HumoiMeetingEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoom, "cellblock_lilac_nearcell")
	
func run(_triggerID, _args):
	if(getModuleFlag(MODULE_ID, "NanoMeetHumoi", false)):
		if !(GM.main.getModuleFlag(MODULE_ID, "NanoKnowAndroidKey", false)):
			addButtonUnlessLate("Humoi's cell", "See what the special gift is", "enter_cell_first")
		else:
			addButtonUnlessLate("Humoi's cell", "Talk about some nano stuff", "enter_cell")

func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "enter_cell_first"):
		GM.main.setModuleFlag(MODULE_ID, "NanoKnowAndroidKey", true)
		var book = GlobalRegistry.createItem("NanoManual")
		GM.pc.getInventory().addItem(book)
		runScene("NanoSetting",["see_again_first"])
	if(_method == "enter_cell"):
		runScene("NanoSetting",["see_again"])
			
