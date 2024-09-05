extends EventBase

func _init():
	id = "AlexLearnEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.TalkingToNPC, "alexrynard")
	
func run(_triggerID, _args):
	if(getModuleFlag("NanoRevolutionModule", "NanoMeetHumoi", false)):
		if(not getFlag("AlexRynardModule.ch1HypnovisorHappened")):
			addDisabledButton("Nano Android", "Better wait till Alex is more friendly with you")
		else:
			addButtonUnlessLate("Nano Android", "Inquiry something about these nano androids", "talk_android")
		return
	

		


func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "talk_android"):
		GM.main.endCurrentScene()
		runScene("Alex_TalkAboutAndroid")

