extends QuestBase

const MODULE_ID = "NanoRevolutionModule"

func _init():
	id = "NanoDailyQuest"

func getVisibleName():
	return "Humoi's daily requst (´｡• ᵕ •｡`)"

func getProgress():
	var result = []
	var quest_info = GM.main.getModuleFlag(MODULE_ID, "NanoDailyQuestInfo", null)
	
	if quest_info == null:
		result.append("No daily task available. Check back tomorrow!")
		return result

	var progress = GM.main.getModuleFlag(MODULE_ID, "NanoDailyQuestProgress", 0)
	var target = quest_info.get("target_count", 1)
	
	result.append(quest_info.get("description", "No description."))
	result.append("Progress: " + str(progress) + " / " + str(target))
	
	if progress >= target:
		result.append("Task completed! You can claim your reward from Humoi.")
		
	return result

func isVisible():
	# Only visible after being accepted and before being completed for the day.
	var quest_info = GM.main.getModuleFlag(MODULE_ID, "NanoDailyQuestInfo", null)
	var accepted = GM.main.getModuleFlag(MODULE_ID, "NanoDailyQuestAccepted", false)
	return accepted and quest_info != null

func isCompleted():
	# The quest is considered "completed" for the day if the info is cleared (reward claimed).
	return GM.main.getModuleFlag(MODULE_ID, "NanoDailyQuestInfo", null) == null
