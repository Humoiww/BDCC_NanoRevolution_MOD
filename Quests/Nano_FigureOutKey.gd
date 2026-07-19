extends QuestBase

const MODULE_ID = "NanoRevolutionModule"

func _init():
	id = "FigureOutKey"

func getVisibleName():
	return "Figure out key"

func getProgress():
	var result = []
	
	result.append("So, you try to hack the android, but its key access blocks your way. Maybe you should ask that sky blue dragon who gave you this controller for assistance?")
	if(GM.main.getModuleFlag(MODULE_ID, "NanoAskHumoiKey", false)):
		result.append("Humoi mentioned that to get the key for hacking, you’ll need to gather some info from Alex, but keep in mind, he’s not the easiest person to befriend—patience might be required.")
	if(GM.main.getModuleFlag(MODULE_ID, "NanoAskAlexKey", false)):
		result.append("That dragon lied to you? Well, it’s time to figure this out and get some revenge.")
	if(GM.main.getModuleFlag(MODULE_ID, "NanoKnowAndroidKey", false)):
		result.append("Now you’ve got the method to generate the key.")
	
	return result

func isVisible():
	return GM.main.getModuleFlag(MODULE_ID, "NanoTriggerKeyQuest", false)

func isCompleted():
	return GM.main.getModuleFlag(MODULE_ID, "NanoKnowAndroidKey", false)

func isMainQuest():
	return false
