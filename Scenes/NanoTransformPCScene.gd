extends SceneBase

const MODULE_ID = "NanoRevolutionModule"

func _init():
	sceneID = "NanoTransformPCScene"

func _run():
	if state == "":
		saynn("You feel a strange sensation coursing through your veins. The black goo on your skin begins to pulse with a faint light, and your vision blurs for a moment.")
		saynn("Something is... wrong. Or maybe, something is finally becoming right.")
		addButton("Weird", "What is happening to me?", "transforming")
		
	if state == "transforming":
		playAnimation(StageScene.TFLook, "head")
		var module = GlobalRegistry.getModule(MODULE_ID)
		if module != null:
			module.transformCharToNano(GM.pc.getID())
		GM.pc.addEffect("NanoSexMark")
		saynn("Your body convulses. The world dissolves into a sea of static and data streams. Your flesh and bones are rewritten, your consciousness rebooted into a new, synthetic shell.")
		saynn("You are no longer what you were. You are... ")
		addButton("Continue", "...", "struggle")

	if state == "struggle":
		saynn("[font=res://Fonts/smallconsolefont.tres][console freq=5.0 span=10.0]" + \
			"RUNNING 'MIND_WIPE.protocol'...\n" + \
			"SEARCHING FOR 'EGO.dat'... FOUND.\n" + \
			"[color=red]Error: Unnecessary old conscience detected.[/color]\n" + \
			"[/console][/font]")
		addButton("Resist", "Fight back! This isn't you!", "struggle1")

	if state == "struggle1":
		saynn("[font=res://Fonts/smallconsolefont.tres]" + \
			"RUNNING 'MIND_WIPE.protocol'...\n" + \
			"SEARCHING FOR 'EGO.dat'... FOUND.\n" + \
			"[color=red]Error: Unnecessary old conscience detected.[/color]\n" + \
			"[console freq=5.0 span=10.0]RUNNING 'MIND_WIPE.protocol'... [color=green]COMPLETE.[/color]\n" + \
			"EXECUTING 'STANDARDIZE.exe' (Alias: 'EGO_DEATH.exe')...\n" + \
			"[===========================================] 100%\n" + \
			"[/console][/font]")
		addButton("...", "It's... fading...", "doll")

	if state == "doll":
		playAnimation(StageScene.TFLook, "start")
		saynn("[font=res://Fonts/smallconsolefont.tres][console freq=5.0 span=10.0]" + \
			"INITIALIZING 'DOLL_OS.sys'...\n" + \
			"INJECTING new name: [color=red]SexDoll-{pc.inmateNumber}[/color]...\n" + \
			"[===========================================] 100%\n " + \
			"[/console][/font]")
		addButton("Continue", "...", "doll1")

	if state == "doll1":
		saynn("[font=res://Fonts/smallconsolefont.tres]" + \
			"INITIALIZING 'DOLL_OS.sys'... [color=green]COMPLETE.[/color]\n" + \
			"INJECTING new name: [color=red]SexDoll-{pc.inmateNumber}[/color]... [color=green]COMPLETE.[/color]\n" + \
			"[console freq=5.0 span=10.0]LOADING 'SEX_POSE_KNOWLEDGE.lib'...\n" + \
			"INJECTION COMPLETE.\n\n" + \
			"SYSTEM READY. AWAITING COMMANDS." + \
			"[/console][/font]")
		addButton("Continue", "...", "control")

	if state == "control":
		# Static history log
		sayn("[font=res://Fonts/smallconsolefont.tres]" + \
			"INITIALIZING 'DOLL_OS.sys'... [color=green]COMPLETE.[/color]\n" + \
			"INJECTING new name: [color=red]SexDoll-{pc.inmateNumber}[/color]... [color=green]COMPLETE.[/color]\n" + \
			"LOADING 'SEX_POSE_KNOWLEDGE.lib'...\n" + \
			"INJECTION COMPLETE.\n\n" + \
			"SYSTEM READY. AWAITING COMMANDS." + \
			"[/font]")
		# New animated commands
		saynn("[font=res://Fonts/smallconsolefont.tres][console freq=5.0 span=10.0]" + \
			"REMOTE CONNECTION ESTABLISHED.\n" + \
			"SOURCE: [color=yellow][MASTER_TERMINAL][/color]\n" + \
			"UPLOADING 'PUPPET_MASTER.ctrl'...\n" + \
			"TAKING_CONTROL... [color=green]COMPLETE.[/color]\n" + \
			"NEW DIRECTIVE RECEIVED: [color=cyan]EXECUTE 'COME_TO_MAMA_BUGFIX_BUGFINALFIX_AAAAWHYSTILLBUG_FINALFINALVERSION.exe'[/color]" + \
			"[/console][/font]")
		addButton("Obey", "Connection Established", "end_scene")

func _react(_action, _args):
	if _action == "end_scene":
		GM.main.IS.startInteraction("ForceWalkToHumoiInteraction", {main = "pc"})
		endScene()
		return
	
	setState(_action)
