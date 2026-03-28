extends EventBase

func _init():
	id = "HumoiMeetingEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoom, "cellblock_lilac_nearcell")
	
func run(_triggerID, _args):
	if(getModuleFlag("NanoRevolutionModule", "NanoMeetHumoi", false)):
		if !(GM.main.getModuleFlag("NanoRevolutionModule", "NanoKnowAndroidKey", false)):
			addButtonUnlessLate("Humoi's cell", "See what the speical gift is", "enter_cell_first")
		else:
			addButtonUnlessLate("Humoi's cell", "Talk about some nano stuff", "enter_cell")

func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "enter_cell_first"):
		GM.main.setModuleFlag("NanoRevolutionModule", "NanoKnowAndroidKey", true)
		var book = GlobalRegistry.createItem("NanoManual")
		GM.pc.getInventory().addItem(book)
		runScene("NanoSetting",["see_again_first"])
	if(_method == "enter_cell"):
		runScene("NanoSetting",["see_again"])
			
