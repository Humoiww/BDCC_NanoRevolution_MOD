extends EventBase

func _init():
	id = "NanoAndroidMeetAssembleEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoom, "eng_assemblylab")
	
func run(_triggerID, _args):
	if (getFlag("AlexRynardModule.ch2FinalSceneHappened")):
		if(!getModuleFlag("NanoRevolutionModule","NanoAttackSceneHappened")):
			saynn("You just noitced an old datapad just left in a secret corner.")
			addButton("Pick it up", "Check what on it", "startscene")
		else:
			saynn("Life is strange, isn't? You've never expect you will change your life form in your whole life. Well, that happened, all you need to do is accept it~")
	else:
		saynn("You feel that there's something special hiden in the darkness. Maybe getting more familiar with Alex can provide you some hints to find that.")
		saynn("(Note: this scene require you to complete Alex Rynard's story line. That's an excellent story. If you really do not want to to complete that, here a SKIP button, to skip the whole story line, but may lead some unexpected error :C It's up to you~ XD)")
		addButton("(!)SKIP", "Skip Alex story line!", "skip")

func getPriority():
	return 0

func onButton(_method, _args):
	if(_method == "startscene"):
		runScene("NanoAttackScene")
		# setFlag("NanoAttackSceneHappened", true)
	if(_method == "skip"):
		setFlag("AlexRynardModule.ch2FinalSceneHappened", true)
