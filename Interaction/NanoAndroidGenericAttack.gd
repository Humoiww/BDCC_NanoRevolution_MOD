extends PawnInteractionBase

var surrendered = false
var askCredits = 0

func _init():
	id = "NanoAndroidGenericAttack"

func start(_pawns:Dictionary, _args:Dictionary):
	doInvolvePawn("starter", _pawns["starter"])
	doInvolvePawn("reacter", _pawns["reacter"])
	if(_args.has("askCredits")):
		askCredits = _args["askCredits"]
	setState("", "reacter")


func sayCharater(ch,text):
	saynn("[say=" +ch+ "]" +text + "[/say]")


func init_text():
	saynn("{starter.You} {starter.youVerb('attack')} {reacter.you}!")
	if(!isPlayerInvolved()):
		saynn("[say=starter]"+RNG.pick([
					"I don't care if you’re just doing your job—you're pissing me off!",
					"You're always in the way! Just shut down already!",
					"You're not even alive! Why should I care if I break you?!",
					"You think you're better than me, huh? Let's see how tough you are when I'm done with you!",
					"You're always watching, always recording. Can't a guy have some privacy anymore?!",
				])+"[/say]")
	sayCharater("reacter","Encounter hostile movement, punishing mode activated.")
	addAction("fight", "Fight", "Fight back", "fight", 1.0, 300, {start_fight=["starter", "reacter"],})
	# addAction("surrender", "Surrender", "It's not worth it!", "surrender", 1.0, 60, {})

func init_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "fight"):
		surrendered = false
		var fightResult = getFightResult(_args)
		var theCharID = getRoleID("reacter")
		if(fightResult["won"]):
			if(isPlayerInvolved()):
				runScene("NanoExposureForceCheckScene",[theCharID,"won_fight"])
				stopMe()
			setState("starter_won", "starter")
			onStarterWin()
		else:
			setState("reacter_won", "reacter")
	if(_id == "surrender"):
		surrendered = true
		setState("starter_won", "starter")
		onStarterWin(true)


func starter_won_text():
	
	if(!surrendered):
		saynn("{starter.name} won the fight! {reacter.name} hits the floor, unable to continue fighting..")
		sayCharater("reacter","FATAL ERROR: Damage exceed system threshold. Entering energy saving mode")
		if(RNG.chance(50)):
			sayLine("reacter", "FightLostGeneric", {loser="reacter", winner="starter"})
		else:
			sayLine("starter", "FightWonGeneric", {winner="starter", loser="reacter"})
	else:
		saynn("{reacter.name} decides to surrender instantly..")
		sayCharater("reacter","FATAL ERROR: renveWognaTegivFuyo?pu. Entering energy saving mode")
 

	addAction("punish", "Punish", "Have some fun!", "punish", 1.0, 60, {})
	addAction("leave", "Leave", "Just leave", "default", 0.1, 60, {})

func starter_won_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "punish"):
		startInteraction("PunishInteraction", {punisher=getRoleID("starter"), target=getRoleID("reacter")})
	if(_id == "leave"):
		setState("starter_won_leave", "starter")


func starter_won_leave_text():
	saynn("{starter.name} decides to leave {reacter.you} alone..")

	addAction("leave", "Leave", "Time to go..", "default", 1.0, 60, {})

func starter_won_leave_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "leave"):
		stopMe()


func reacter_won_text():
	if(!surrendered):
		saynn("{reacter.name} won the fight! {starter.name} hits the floor, unable to continue fighting..")
		if(RNG.chance(50)):
			sayLine("starter", "FightLostGeneric", {loser="starter", winner="reacter"})
	else:
		saynn("{starter.name} decides to surrender instantly..")
		sayLine("starter", "FightSurrender", {loser="starter", winner="reacter"})

	saynn("[say=reacter]Confrontation ended successfully. Attacker's status: completely submissive. Securing. Excuting punishment mode.[/say]")

	var theChar = getRoleChar("starter")
	theChar.getInventory().removeItemsList(theChar.getInventory().getItemsWithTag(ItemTag.Illegal))
	theChar.getInventory().removeEquippedItemsList(theChar.getInventory().getEquippedItemsWithTag(ItemTag.Illegal))
	var items = theChar.getInventory().forceRestraintsWithTag(ItemTag.CanBeForcedByGuards, RNG.randi_range(3,8))
	if(isPlayerInvolved()):
		for item in items:
			addMessage(item.getForcedOnMessage())
	saynn("Before {starter.you} realize, some BDSM devices magically bonds on {starter.your} body.")
	addAction("stocks", "Stocks", "Lock them up in stocks!", "punishMean", 0.2 * getStocksScoreMult(), 60, {})
	# addAction("punish", "Punish", "Punish them for attacking you!", "punish", 1.0, 60, {})
	# addAction("leave", "Leave", "Just leave", "surrender", 1.0, 60, {})

func reacter_won_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "stocks"):
		setState("about_to_stocks", "reacter")
	# if(_id == "leave"):
	# 	setState("reacter_won_leave", "reacter")
	# 	affectAffection("starter", "reacter", 0.15)


func reacter_won_leave_text():
	saynn("{reacter.name} decides to leave {starter.you} alone..")

	addAction("leave", "Leave", "Time to go..", "default", 1.0, 60, {})

func reacter_won_leave_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "leave"):
		stopMe()


func getAnimData() -> Array:
	if(getState() == "starter_won"):
		if(surrendered):
			return [StageScene.Duo, "stand", {pc="starter", npc="reacter", npcAction="kneel"}]
		else:
			return [StageScene.Duo, "stand", {pc="starter", npc="reacter", npcAction="defeat"}]
	if(getState() == "reacter_won"):
		if(surrendered):
			return [StageScene.Duo, "kneel", {pc="starter", npc="reacter"}]
		else:
			return [StageScene.Duo, "defeat", {pc="starter", npc="reacter"}]

	if(getState() == "in_slutwall"):
		return [StageScene.SlutwallSex, "tease", {pc="starter", npc="reacter"}]
	if(getState() == "in_stocks"):
		return [StageScene.StocksSexOral, "tease", {npc="reacter", pc="starter"}]
	if(getState() in ["pulling_to_stocks", "pulling_to_slutwall"]):
		if(getLocation() != "main_punishment_spot" && getLocation() != "fight_slutwall"):
			return [StageScene.Duo, "walk", {pc="starter", npc="reacter", npcAction="walk", flipNPC=true, bodyState={leashedBy="reacter"}}]



	return [StageScene.Duo, "stand", {pc="starter", npc="reacter"}]

func onStarterWin(_isSurrender=false):
	if(askCredits > 0):
		if(getRolePawn("reacter").isPlayer()):
			GM.pc.addCredits(-askCredits)
			addMessage("You lost "+str(askCredits)+" credits!")
		if(getRolePawn("starter").isPlayer()):
			GM.pc.addCredits(askCredits)
			addMessage("You gained "+str(askCredits)+" credits!")

func getPreviewLineForRole(_role:String) -> String:
	if(_role == "starter"):
		return "{starter.name} is attacking {reacter.name}!"
	if(_role == "reacter"):
		return "{reacter.name} is being attacked by {starter.name}!"
	return .getPreviewLineForRole(_role)






# punish to stock


func about_to_stocks_text():
	saynn("{reacter.name} clips a leash to {starter.your} collar.")

	addAction("stocks", "Escort", "Escort them towards the stocks", "default", 1.0, 60, {})

func about_to_stocks_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "stocks"):
		setState("pulling_to_stocks", "reacter")
		goTowards("main_punishment_spot")


func pulling_to_stocks_text():
	saynn("{reacter.name} is pulling {starter.name} towards the punishment platform!")

	addAction("stocks", "Escort", "Pull them towards the stocks", "default", 1.0, 60, {})

func pulling_to_stocks_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "stocks"):
		goTowards("main_punishment_spot")
		if(getLocation() == "main_punishment_spot"):
			setState("about_to_lock_stocks", "reacter")


func about_to_lock_stocks_text():
	saynn("{reacter.name} guides {starter.name} to the stocks.")

	addAction("lock_them", "Lock them", "Force them into the stocks", "default", 1.0, 120, {})

func about_to_lock_stocks_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "lock_them"):
		affectAffection("starter", "reacter", -0.1)
		addRepScore("starter", RepStat.Alpha, -3.0)
		setState("in_stocks", "reacter")


func in_stocks_text():
	saynn("{reacter.name} locks {starter.name} into the stocks!")

	addAction("leave", "Leave", "Leave them be", "default", 1.0, 30, {})

func in_stocks_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "leave"):
		stopMe()
		startInteraction("InStocks", {inmate=getRoleID("starter")})






func isRoleOnALeash(_role:String) -> bool:
	if(_role == "starter" && getState() in ["pulling_to_stocks", "pulling_to_slutwall"]):
		return true
	return false
	
func isRoleLeashing(_role:String) -> bool:
	if(_role == "reacter" && getState() in ["pulling_to_stocks", "pulling_to_slutwall"]):
		return true
	return false



func saveData():
	var data = .saveData()

	data["surrendered"] = surrendered
	data["askCredits"] = askCredits
	return data

func loadData(_data):
	.loadData(_data)

	surrendered = SAVE.loadVar(_data, "surrendered", false)
	askCredits = SAVE.loadVar(_data, "askCredits", 0)

