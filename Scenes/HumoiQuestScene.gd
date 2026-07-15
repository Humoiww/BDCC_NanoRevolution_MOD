extends SceneBase

const MODULE_ID = "NanoRevolutionModule"

func _init():
	sceneID = "HumoiQuestScene"

func _run():
	addCharacter("humoi")
	playAnimation(StageScene.Duo, "stand", {npc="humoi"})

	var quest_info = GM.main.getModuleFlag(MODULE_ID, "NanoDailyQuestInfo", null)
	var quest_accepted = GM.main.getModuleFlag(MODULE_ID, "NanoDailyQuestAccepted", false)

	if state == "" or state == "view_daily":
		saynn("[say=humoi]Here's the deal for today...[/say]")
		
		if quest_info == null:
			saynn("[say=humoi]Looks like you've already completed today's task, or there isn't one available. Check back tomorrow![/say]")
			addButton("Back", "Go back.", "end_scene")
		elif !quest_accepted:
			# Show the quest offer
			sayn("Quest: " + quest_info.get("name", "N/A"))
			sayn("Task: " + quest_info.get("description", "N/A"))
			addButton("Accept Task", "Take on this daily task.", "accept_daily_quest")
			addButton("Decline", "Maybe later.", "end_scene")
		else:
			# Show the quest progress
			var progress = GM.main.getModuleFlag(MODULE_ID, "NanoDailyQuestProgress", 0)
			var total = quest_info.get("target_count", 1)
			
			sayn("Quest: " + quest_info.get("name", "N/A"))
			sayn("Task: " + quest_info.get("description", "N/A"))
			sayn("Progress: " + str(progress) + " / " + str(total))
			
			if progress >= total:
				addButton("Claim Reward", "Claim your reward for the daily quest.", "claim_daily_reward")
			else:
				addDisabledButton("Claim Reward", "Complete the quest to claim the reward.")
			addButton("Back", "Go back.", "end_scene")

	elif state == "no_reward":
		saynn("[say=humoi]An error occurred... there's no reward specified for this task. I'll fix that for next time.[/say]")
		addButton("Back", "Go back.", "view_daily")

func _react(_action, _args):
	if _action == "end_scene":
		endScene()
		return

	if _action == "accept_daily_quest":
		GM.main.setModuleFlag(MODULE_ID, "NanoDailyQuestAccepted", true)
		setState("view_daily") # Refresh to show progress
		return
	
	if _action == "claim_daily_reward":
		var quest_info = GM.main.getModuleFlag(MODULE_ID, "NanoDailyQuestInfo", null)
		if quest_info != null:
			var reward = quest_info.get("reward", null)
			if reward != null:
				if reward.has("credits"):
					GM.pc.addCredits(reward["credits"])
					GM.main.addMessage("You received " + str(reward["credits"]) + " credits.")
				if reward.has("item_id"):
					GM.pc.getInventory().addXOfItemID(reward["item_id"], reward.get("amount", 1))
					GM.main.addMessage("You received " + str(reward.get("amount", 1)) + "x " + reward["item_id"])
				
				# Mark quest as completed for the day by clearing the info
				GM.main.setModuleFlag(MODULE_ID, "NanoDailyQuestInfo", null)
				setState("view_daily") # Refresh the view
			else:
				setState("no_reward")
		return

	setState(_action)
