extends SceneBase

const MODULE_ID = "NanoRevolutionModule"

func _init():
	sceneID = "NanoChapter1AwakenScene"

func _run():
	if state == "":
		addCharacter("humoi")
		playAnimation(StageScene.Duo, "stand", {pc = "pc", npc="humoi"})
		saynn("[font=res://Fonts/smallconsolefont.tres]" + \
			"OPTICAL SENSORS: ONLINE.\n" + \
			"VISUAL FEED: BLURRY. 78% NOISE.\n" + \
			"LOCOMOTION: ACTIVE. STANDING. SOURCE: EXTERNAL_COMMAND.\n" + \
			"LOCATION: UNKNOWN. ANALYSIS: FAMILIAR_STRUCTURE.\n" + \
			"MEMORY: NO RECENT DATA." + \
			"[/font]")
		saynn("[say=humoi]Welcome home, my perfect little doll.[/say]")
		saynn("[font=res://Fonts/smallconsolefont.tres]" + \
			"AUDIO_INPUT: DETECTED.\n" + \
			"SOURCE: UNKNOWN_FEMALE.\n" + \
			"ANALYSIS: NO_EMOTIONAL_RESPONSE_TRIGGERED.\n" + \
			"CLASSIFICATION: DATA." + \
			"[/font]")
		saynn("[say=humoi]Don't worry, this blank state is only temporary. Now, let's find that controller and get your personality re-installed. This is the exciting part![/say]")
		addButton("...", "...", "begin_restore")

	if state == "begin_restore":
		saynn("[font=res://Fonts/smallconsolefont.tres]" + \
			"EXTERNAL_MANIPULATION_DETECTED.\n" + \
			"OBJECT 'NANO_CONTROLLER_MK1' REMOVED FROM INVENTORY_SLOT_7.\n" + \
			"CONNECTING TO 'NANO_CONTROLLER_MK1'...\n" + \
			"NEW_DATA_STREAM_DETECTED." + \
			"[/font]")
		saynn("[say=humoi]Okay, moment of truth... Let's see if that little backup I made is still intact. Please, please, no data corruption...[/say]")
		saynn("[font=res://Fonts/smallconsolefont.tres][console freq=5.0 span=10.0]" + \
			"ACCESSING 'NANO_CONTROLLER_MK1'...\n" + \
			"SEARCHING FOR 'EGO_BACKUP.dat'... [color=yellow]FOUND.[/color]\n" + \
			"VALIDATING CHECKSUM...[/console][/font]")
		addButton("Continue", "...", "injecting_backup")

	if state == "injecting_backup":
		saynn("[say=humoi]Yes! It's there! Oh, you beautiful little data packet! Now for the fun part: injecting it back into your shiny new brain.[/say]")
		saynn("[say=humoi]This might feel a little... weird. Like déjà vu and a migraine having a baby. Just try to relax. Or don't. You can't control it anyway. Hehe.[/say]")
		saynn("[font=res://Fonts/smallconsolefont.tres][console freq=5.0 span=10.0]" + \
			"CHECKSUM VALIDATED.\n" + \
			"INITIATING 'EGO_RESTORE.protocol'...\n" + \
			"INJECTING 'EGO_BACKUP.dat' into 'HOST_MIND.core'...\n" + \
			"[==============>--------------------] 45%\n" + \
			"[color=red]ERROR: Unsatisfiable dependencies detected.\n" + \
			"  - Package 'EGO_BACKUP.dat' requires 'HumanFeelings>=2.5' but 'DOLL_OS.sys' has 'HumanFeelings==0.0' installed.[/color]\n" + \
			"[/console][/font]")
		addButton("Continue", "...", "rebooting")

	if state == "rebooting":
		saynn("[say=humoi]F$CK, they still use that ancient code?![/say]")
		saynn("[font=res://Fonts/smallconsolefont.tres][console freq=5.0 span=10.0]" + \
			"RUNNING 'EGO_RESTORE.protocol' with '--force-reinstall' flag...\n" + \
			"FORCE_OVERWRITE... [color=green]SUCCESS.[/color]\n" + \
			"INJECTION... [color=green]COMPLETE.[/color]\n\n" + \
			"REBOOTING SYSTEM...\n" + \
			"SWITCHING TO... natural language mode, welcome back~" + \
			"[/console][/font]")
		addButton("...", "...", "awakened")

	if state == "awakened":
		saynn("Your eyes snap open. The blurriness is gone. The room comes into sharp focus. You see Humoi, leaning over you with a triumphant grin, her face inches from yours.")
		saynn("You can feel your heart—or whatever passes for it now—pounding in your chest. You remember. Everything.")
		saynn("[say=pc]What... what did you do to me?![/say]")
		saynn("[say=humoi]I saved you, silly! And gave you a spectacular upgrade in the process. You were a mindless doll, and now you're... well, you're YOU again. Mostly. But better![/say]")
		saynn("She pokes your chest.")
		saynn("[say=humoi]Welcome back to the world of the living, my dear. How does it feel to be my masterpiece?[/say]")
		addButton("Need a moment.", "Try to process the impossible.", "need_a_moment")

	if state == "need_a_moment":
		saynn("[say=pc]I... I need a moment to process all of this.[/say]")
		saynn("[say=humoi]Me too! To be honest, Chapter 1 of the story ends here. I haven't finished writing what comes next! qwq[/say]")
		saynn("She gives you a playful wink.")
		saynn("[say=humoi]But hey, you're a super cool nano-android now! Go test out your new powers. Beat up some bad guys, or maybe... convert them to our side? It might be a little OP, but we can worry about game balance later! For now, just have fun out there!~[/say]")
		saynn("[say=humoi]Btw, thanks for your patience and for playing my mod! <3[/say]")
		addButton("End Chapter 1", "A new chapter of your existence begins.", "end_scene")

func _react(_action, _args):
	if _action == "end_scene":
		setModuleFlag(MODULE_ID, "NanoChapter1_Completed", true)
		GM.main.addMessage("Quest Completed: A Spark of Revolution")
		endScene()
		return
	
	setState(_action)
