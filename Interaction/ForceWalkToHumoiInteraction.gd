extends PawnInteractionBase
var proceed_text = ""
var new_text
func _init():
	id = "ForceWalkToHumoiInteraction"
	proceed_text = "[font=res://Fonts/smallconsolefont.tres]" + \
		"INITIALIZING 'DOLL_OS.sys'... [color=green]COMPLETE.[/color]\n" + \
		"INJECTING new name: [color=red]SexDoll-{pc.inmateNumber}[/color]... [color=green]COMPLETE.[/color]\n" + \
		"LOADING 'SEX_POSE_KNOWLEDGE.lib'...\n" + \
		"INJECTION COMPLETE.\n\n" + \
		"SYSTEM READY. AWAITING COMMANDS.\n" + \
		"REMOTE CONNECTION ESTABLISHED.\n" + \
		"SOURCE: [color=yellow][MASTER_TERMINAL][/color]\n" + \
		"UPLOADING 'PUPPET_MASTER.ctrl'...\n" + \
		"TAKING_CONTROL... [color=green]COMPLETE.[/color]\n" + \
		"NEW DIRECTIVE RECEIVED: [color=cyan]EXECUTE 'COME_TO_MAMA_BUGFIX_BUGFINALFIX_AAAAWHYSTILLBUG_FINALFINALVERSION.exe'[/color]" 

func start(_pawns:Dictionary, _args:Dictionary):
	doInvolvePawn("main", _pawns["main"])
	setState("", "main")
	# goTowards("cellblock_lilac_nearcell")

func init_text():
	new_text = "proceed\n"
	saynn(proceed_text + \
		"[console freq=5.0 span=10.0]"+ new_text +\
		"[/console][/font]")


	addAction("continue", "proceed", "Calm down, you are on the right route~", "default", 1.0, 10, {})

func init_do(_id:String, _args:Dictionary, _context:Dictionary):


	if(_id == "continue"):
		proceed_text += new_text
		goTowards("cellblock_lilac_nearcell")
		# print(GM.world.calculatePath(getLocation(), "cellblock_lilac_nearcell"))
		if(getLocation() == "cellblock_lilac_nearcell"):
			setState("arrived", "main")
		else:
			setState("", "main")

func getAnimData() -> Array:
	return [StageScene.Solo, "walk", {pc="main"}]

func arrived_text():
	new_text = "Destination Reached\n Clearing Output"
	saynn(proceed_text + \
		"[console freq=5.0 span=10.0]"+ new_text +\
		"[/console][/font]")
	addAction("continue", "Continue", "You have arrived.", "default", 1.0, 1, {})


func arrived_do(_id:String, _args:Dictionary, _context:Dictionary):
	if _id == "continue":
		runScene("NanoChapter1AwakenScene")
		stopMe()
