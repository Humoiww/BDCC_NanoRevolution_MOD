extends EventBase

func _init():
	id = "AlexLearnEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.TalkingToNPC, "alexrynard")
	
func run(_triggerID, _args):
	print("I'm activate ---------------------------------Alexlearn")
	if(getModuleFlag("NanoRevolutionModule", "NanoAskHumoiKey", false)):
		if(not getFlag("AlexRynardModule.ch1HypnovisorHappened")):
			addDisabledButton("Nano Android", "Better wait till Alex is more friendly with you.\n(Hint: you need to see Alex's hypnovisor scene)")
		else:
			if(!getModuleFlag("NanoRevolutionModule", "NanoAskAlexKey", false) || getModuleFlag("NanoRevolutionModule", "NanoKnowAndroidKey", false)):
				addButtonUnlessLate("Nano Android", "Inquiry something about these nano androids", "talk_android")
			else:
				addDisabledButton("Nano Android", "Better go and check that blue dragon first.")
	
	
	

	

		


func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "talk_android"):
		GM.main.endCurrentScene()
		runScene("Alex_TalkAboutAndroid")

