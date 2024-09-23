extends EventBase

func _init():
	id = "AlexLearnEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.TalkingToDynamicNPC)
	
func run(_triggerID, _args):
	# if(getModuleFlag("NanoRevolutionModule", "NanoAskHumoiKey", false)):
	# 	if(not getFlag("AlexRynardModule.ch1HypnovisorHappened")):
	# 		addDisabledButton("Nano Android", "Better wait till Alex is more friendly with you")
	# 	else:
	# 		if(!getModuleFlag("NanoRevolutionModule", "NanoAskAlexKey", false) || getModuleFlag("NanoRevolutionModule", "NanoKnowAndroidKey", false)):
	# 			addButtonUnlessLate("Nano Android", "Inquiry something about these nano androids", "talk_android")
	# 		else:
	# 			addDisabledButton("Nano Android", "Better go and check that blue dragon first.")
	
	print("Hello, im talking with dynamic character, am I still working?")
	
	return
	

		


func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "talk_android"):
		GM.main.endCurrentScene()
		runScene("Alex_TalkAboutAndroid")

