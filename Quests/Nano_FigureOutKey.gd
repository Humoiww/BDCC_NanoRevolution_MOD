extends QuestBase

func _init():
	id = "FigureOutKey"

func getVisibleName():
	return "Figure out key"

func getProgress():
	var result = []
	
	result.append("So, you try to hack the android, but its key access blocks your way. Maybe you should ask that sky blue dragon who gave you this controller for assistance?")
	if(GM.main.getModuleFlag("NanoRevolutionModule", "NanoAskHumoiKey", false)):
		result.append("So, Humoi offers a temporary solution: use some cores to craft a special EMP to paralyze the system. However, to permanently obtain the key to hack, you’ll need to get some information from Alex.")
	if(GM.main.getModuleFlag("NanoRevolutionModule", "NanoAskAlexKey", false)):
		result.append("So, you’ve just learned that the key word is dynamic and related to the android's current name. Will this information be useful?")
	if(GM.main.getModuleFlag("NanoRevolutionModule", "NanoKnowAndroidKey", false)):
		result.append("Now you get the way to utilize key.")
	
	return result

func isVisible():
	return GM.main.getModuleFlag("NanoRevolutionModule", "NanoTriggerKeyQuest", false)

func isCompleted():
	return GM.main.getModuleFlag("NanoRevolutionModule", "NanoKnowAndroidKey", false)

func isMainQuest():
	return false
