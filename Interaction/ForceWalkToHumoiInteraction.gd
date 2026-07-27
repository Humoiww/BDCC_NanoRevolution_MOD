extends PawnInteractionBase

func _init():
	id = "ForceWalkToHumoiInteraction"

func start(_pawns:Dictionary, _args:Dictionary):
	doInvolvePawn("main", _pawns["main"])
	setState("", "main")
	# goTowards("cellblock_lilac_nearcell")

func init_text():
	saynn("You feel a strange pull, an instinct guiding your new body towards an unknown destination...")
	addAction("continue", "Let the instinct guide you", "You have no choice.", "default", 1.0, 10, {})

func init_do(_id:String, _args:Dictionary, _context:Dictionary):

	if(_id == "continue"):
		goTowards("cellblock_lilac_nearcell")
		if(getLocation() == "cellblock_lilac_nearcell"):
			setState("arrived", "walker")
		else:
			setState("", "main")



func arrived_text():
	saynn("You have arrived. The pull subsides.")
	addAction("continue", "Continue", "You have arrived.", "default", 1.0, 1, {})


func arrived_do(_id:String, _args:Dictionary, _context:Dictionary):
	if _id == "continue":
		runScene("NanoSetting",["see_again_first"]) #change here, put humoi fix you scene
		stopMe()
