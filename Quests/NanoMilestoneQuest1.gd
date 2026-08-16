extends QuestBase

const MODULE_ID = "NanoRevolutionModule"

func _init():
	id = "NanoMilestoneQuest1"

func getVisibleName():
	return "A Spark of Revolution"

func getProgress():
	var result = []
	var found_humoi_about_contamination = GM.main.getModuleFlag(MODULE_ID, "NanoChapter1_contamination_start_find_humoi", false)

	if GM.main.getModuleFlag(MODULE_ID, "NanoMeetHumoi", false) and not GM.main.getModuleFlag(MODULE_ID, "NanoHaveReadManual", false):
		result.append("- That frisky dragon Humoi mentioned a 'gift'. Maybe you should check the lilac cell? She probably left some weird stuff for you there... (/ />/ ▽ /</ /) \n- Also, she gave you a book, maybe you should read it first?")
	
	if GM.main.getModuleFlag(MODULE_ID, "NanoHaveReadManual", false) and not GM.main.getModuleFlag(MODULE_ID, "NanoKnowAndroidKey", false):
		result.append("- Now that you have mastered the basic of Nano ENGR, you should totally go grab some of their cores! For science, of course. Definitely not for anything kinky. Hehe.")

	if GM.main.getModuleFlag(MODULE_ID, "NanoKnowAndroidKey", false) and not found_humoi_about_contamination:
		result.append("- Now that you know the secret to neutralizing those androids, you should totally go grab some of their cores! For science, of course. Definitely not for anything kinky. Hehe.")
	
	if GM.main.getModuleFlag(MODULE_ID, "NanoChapter1_contamination_start", false) and not found_humoi_about_contamination:
		result.append("- Uh oh... you're feeling... tingly. The nano-contamination is doing its thing. You should probably go find that horny dragoness Humoi and let her poke you. For science! (o`ω`o)ﾉ")
	
	if found_humoi_about_contamination:
		result.append("- Humoi wants more data (and cores)! Keep dismantling those androids and bring their shiny bits back to her. She promises it's for important research and not just to build a new 'friend'. Probably...\n[i]P.S. This message was definitely NOT written by Humoi hacking into the quest system.[/i]\n[i]P.S.2 Cores are delicious![/i]")
		
	return result

func isVisible():
	return GM.main.getModuleFlag(MODULE_ID, "NanoMeetHumoi", false)

func isCompleted():
	# This will be updated as more chapters are added
	return GM.main.getModuleFlag(MODULE_ID, "NanoChapter1_Completed", false)
