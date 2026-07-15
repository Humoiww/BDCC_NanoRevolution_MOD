extends QuestBase

const MODULE_ID = "NanoRevolutionModule"

func _init():
	id = "NanoMilestoneQuest1"

func getVisibleName():
	return "A Spark of Revolution"

func getProgress():
	var result = []
	
	if GM.main.getModuleFlag(MODULE_ID, "Milestone1_WaitedOneDay", false):
		result.append("Preliminary analysis is complete. You should report back to Humoi.")
	elif GM.main.getModuleFlag(MODULE_ID, "Milestone1_IsWaiting", false):
		result.append("Humoi is analyzing the data. Check back with her tomorrow.")
	elif GM.main.getModuleFlag(MODULE_ID, "Chapter1_Started", false):
		result.append("You have talked to Humoi and learned the basics of Nano Cores. The journey has just begun.")
		
	return result

func isVisible():
	return GM.main.getModuleFlag(MODULE_ID, "Chapter1_Started", false)

func isCompleted():
	# This will be updated as more chapters are added
	return GM.main.getModuleFlag(MODULE_ID, "Chapter1_Completed", false)
