extends EventBase

func _init():
	id = "HumoiMeetingEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoom, "cellblock_lilac_nearcell")
	
func run(_triggerID, _args):
	if(getModuleFlag("NanoRevolutionModule", "NanoMeetHumoi", false)):
		addButtonUnlessLate("Humoi's cell", "Talk about some nano stuff", "enter_cell")

func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "enter_cell"):
		runScene("NanoSetting",["see_again"])
			
