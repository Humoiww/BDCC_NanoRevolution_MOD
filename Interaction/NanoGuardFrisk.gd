extends PawnInteractionBase

var chat = {}
var lust = {}
var chatAnswer = ""
var surrendered = false
var notFirst = false
var struggleText = ""
var tryCount = 0
var askCredits = 0
var didAmount = 0
var gotDenied = false
var willFrisking = false
var nanoCheckedDict = {}
func _init():
	id = "NanoGuardFrisk"

func start(_pawns:Dictionary, _args:Dictionary):

	doInvolvePawn("starter", _pawns["starter"])
	doInvolvePawn("reacter", _pawns["reacter"])
	
	setState("", "starter")


func shouldRunOnMeet(_pawn1, _pawn2, _pawn2Moved:bool):
	nanoCheckedDict = GM.main.getModuleFlag("NanoRevolutionModule", "NanoCharacterCheckedToday",{})
	var prob = GM.main.getModuleFlag("NanoRevolutionModule", "NanoCheckChance", 0.1)
	willFrisking = false
	if(!_pawn1.canBeInterrupted() || !_pawn2.canBeInterrupted()):
		return [false]
		
	if(_pawn2.isInmate() && _pawn1.getCharType() == "NanoGuard"):
		var pawnTemp = _pawn1
		_pawn1 = _pawn2
		_pawn2 = pawnTemp
	
	if(_pawn1.isInmate()  && _pawn2.getCharType() == "NanoGuard"):
		var inmateID = _pawn1.charID
		if inmateID in nanoCheckedDict:
			return [false]
		if RNG.chance((1-prob)*100):
			return [false]
		if(_pawn1.isPlayer()):
			return [true, {starter=_pawn1.charID, reacter=_pawn2.charID}, {}]
		if(_pawn1.social > 0.6):
			return [true, {starter=_pawn1.charID, reacter=_pawn2.charID}, {}]
			

	return [false]


func sayCharater(ch,text):
	saynn("[say=" +ch+ "]" +text + "[/say]")
	

func init_text():
	nanoCheckedDict = GM.main.getModuleFlag("NanoRevolutionModule", "NanoCharacterCheckedToday",{})
	var inmateID = getRoleID("starter")
	if inmateID in nanoCheckedDict:
		willFrisking = false
	else:
		nanoCheckedDict[inmateID] = 1
		GM.main.setModuleFlag("NanoRevolutionModule", "NanoCharacterCheckedToday",nanoCheckedDict)
		willFrisking = true


	if(!notFirst):
		saynn("{reacter.name} approaches {starter.you}.")
		notFirst=true
	else:
		saynn("{reacter.name} is standing near {starter.you}.")

	
	if(isPlayerInvolved() && !GM.main.getModuleFlag("NanoRevolutionModule", "NanoCheckHappened", false)):
		GM.main.setModuleFlag("NanoRevolutionModule", "NanoCheckHappened", true)
		saynn("{reacter.HeShe} gives you a stop sign.")

		saynn("[say=reacter]Greating, Inmate number {pc.inmateNumber}, how's your day going?[/say]")

		saynn("[say=pc]Good I suppose?[/say]")

		saynn("[say=reacter]That's excellent, may I have your name please? Just for reference.[/say]")

		saynn("[say=pc]It's {pc.name}, can I go now?[/say]")

		saynn("[say=reacter]Sorry {pc.name}, we have to frisk you. Please stand against a wall.[/say]")

		if(!GM.pc.isFullyNaked()):
			saynn("[say=pc]Why?[/say]")

			saynn("[say=reacter]According to the prison law 1437, inmates should not have any stuff labeled illegal. And we will check periodically to ensure safety.[/say]")

			saynn("[say=pc]And what is illegal?[/say]")

			saynn("[say=reacter]Illegal item include but not limited to weapons, contraband, and stollen stuff. Your personal inventory UI should show the stuff label for reference.[/say]")
		# (if naked)
		else:
			saynn("[say=pc]Can’t you see that I don’t have anything, I’m naked[/say]")

			saynn("[say=reacter]I'm afraid that we still need to complete frisking process. According to our frisking record, 20% Inmates hide item in their private area.[/say]")

		saynn("The nano guard will check you once per day. What do you wanna do?")
	else:
		if(willFrisking):
			sayCharater("reacter","{starter.name}, we have to frisk you. Please stand against a wall.")
		else:
			var time = GM.main.getTime()
			sayCharater("reacter","{starter.name}, you've been frisked today. Next routine interaction available in "+str(30 - ceil((time/3600))) +" hours.")


	addAction("attack", "Attack", "Make them regret it!", "attack", 0.1, 30, {})
	if(willFrisking):
		addAction("submit", "Submit", "Fine.", "attack", 0.1, 30, {})
	else:
		addDisabledAction("submit", "They won't frisk you now.")

	if((isPlayerInvolved() && GM.pc.hasPerk("NanoDistraction")) || !willFrisking):
		addAction("leave", "Leave", "No more frisking stuff now.", "default", 0.01 if didAmount <= 0 else 0.5*sqrt(float(didAmount)), 30, {})
	else:
		addDisabledAction("leave", "They are focusing on you.")
	# if(getRolePawn("starter").canEnslaveForFree(getRolePawn("reacter"))):
	# 	addAction("enslave_free", "Enslave!", "They are subby enough.. and you are Alpha enough too..", "default", 0.0, 60, {})

	triggerTalkRunEvents("reacter")

func init_do(_id:String, _args:Dictionary, _context:Dictionary):
	# if(_id == "chat"):
	# 	didAmount += 1
	# 	gotDenied = false
	# 	setState("chat_started", "starter")
	# if(_id == "flirt"):
	# 	didAmount += 1
	# 	gotDenied = false
	# 	setState("about_to_flirt", "starter")
	# if(_id == "grab_and_fuck"):
	# 	setState("grabbed_about_to_fuck", "reacter")
	if(_id == "attack"):
		startInteraction("NanoAndroidGenericAttack", {starter=getRoleID("starter"), reacter=getRoleID("reacter")})
		# if(!getRolePawn("reacter").isPlayer()):
		# 	affectAffection("reacter", "starter", -0.25)

	if(_id == "submit"):
		didAmount += 1
		gotDenied = false
		setState("about_to_submit", "reacter")
	# if(_id == "offersex"):
	# 	didAmount += 1
	# 	gotDenied = false
	# 	setState("offered_sex", "reacter")
	# if(_id == "offerself"):
	# 	didAmount += 1
	# 	gotDenied = false
	# 	setState("offered_self", "reacter")
	if(_id == "ask_help_restraints"):
		#setState("asking_help_restraints", "reacter")
		startInteraction("HelpingWithRestraints", {reacter=getRoleID("reacter"), starter=getRoleID("starter")})
	if(_id == "help_with_restraints"):
		startInteraction("HelpingWithRestraints", {reacter=getRoleID("starter"), starter=getRoleID("reacter")}, {reacterStarted=true})
	if(_id == "ask_for_key"):
		startInteraction("AskingForKey", {starter=getRoleID("starter"), reacter=getRoleID("reacter")})
	
	if(_id == "leave"):
		setState("about_to_leave", "starter")
	# if(_id == "enslave_free"):
	# 	setState("about_to_kidnap", "starter")




func about_to_submit_text():
	saynn("{starter.You} stand against a wall and wait for the guy. {reacter.HeShe} stands behind you and makes you spread your feet more.")

	saynn("{reacter.HeShe} then crouches and starts going from bottom to the top, {reacter.hisHer} hands slide along the curves of your {starter.thick} body, searching for anything unusual. {reacter.HeShe} checks any pockets too.")

	saynn("Then {reacter.heShe} pulls out some kind of scanner and uses it on {starter.You}. {reacter.HeShe} probably could have just done that from the start.")

	# (if has something)
	var theChar = getRoleChar("starter")
	theChar.getInventory().removeItemsList(theChar.getInventory().getItemsWithTag(ItemTag.Illegal))
	theChar.getInventory().removeEquippedItemsList(theChar.getInventory().getEquippedItemsWithTag(ItemTag.Illegal))
	if(theChar.hasIllegalItems()):
		saynn("[say=reacter]Illegal item detected. Sorry {starter.name}, I will be taking that away.[/say]")

		saynn("Well, what can {starter.you} do. {starter.You} roll {starter.your} eyes and walk away.")
	else:
	# (if clear)
		saynn("[say=reacter]Alright, you’re clear.[/say]")

		saynn("{starter.You} continue on {starter.your} way.")

	addAction("leave", "Continue", "See what happens next..", "default", 1.0, 30, {})

func about_to_submit_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "leave"):
		stopMe()






func about_to_leave_text():
	saynn("{starter.name} decides to leave..")

	addAction("leave", "Continue", "See what happens next..", "default", 1.0, 30, {})

func about_to_leave_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "leave"):
		stopMe()


func offered_self_agreed_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "sex"):
		var _result = getSexResult(_args, true)
		setState("after_sex", "starter")


func offered_self_deny_text():
	sayLine("reacter", "TalkSexOfferSelfDeny", {main="reacter", target="starter"})

	addAction("continue", "Continue", "Oh well..", "default", 1.0, 60, {})

func offered_self_deny_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		setState("", "starter")


func after_sex_text():
	saynn("After that sex, it was time to go your separate ways..")

	addAction("continue", "Continue", "", "default", 1.0, 60, {})

func after_sex_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		stopMe()


func grabbed_about_to_fuck_text():
	saynn("{starter.You} {starter.youVerb('grab')} {reacter.you}..")
	saynn("{reacter.You} quickly {reacter.youVerb('realize')} that {reacter.yourHis} restraints prevent {reacter.youHim} from escaping..")
	sayLine("starter", "TalkGrabAndFuck", {main="starter", target="reacter"})

	addAction("sex", "Sex", "You're so fucked..", "default", 1.0, 600, {start_sex=["starter", "reacter"],})

func grabbed_about_to_fuck_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "sex"):
		var _result = getSexResult(_args, true)
		setState("after_grab_and_fuck", "reacter")


func after_grab_and_fuck_text():
	saynn("{starter.name} leaves after messing with {reacter.you}..")

	addAction("continue", "Continue", "See what happens next..", "default", 1.0, 60, {})

func after_grab_and_fuck_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		stopMe()


func about_to_kidnap_text():
	saynn("{starter.You} {starter.youVerb('grab')} {reacter.yourHis} throat and {starter.youVerb('look')} {reacter.youHim} deep into the eyes..")
	saynn("{starter.YourHis} dominant aura alone is making {reacter.youHim} shiver..")
	sayLine("starter", "TalkAboutToKidnap", {main="starter", target="reacter"})
	sayLine("reacter", "TalkAboutToKidnapReact", {main="reacter", target="starter"})

	addAction("continue", "Continue", "See what happens next..", "default", 1.0, 60, {})

func about_to_kidnap_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "continue"):
		stopMe()
		runScene("KidnapDynamicNpcScene", [getRoleID("reacter")])


func shouldShowBigButtons() -> bool:
	if((getState() in ["chat_started"]) && isPlayersTurn()):
		return true
	return false

func getAnimData() -> Array:
	if(getState() in ["about_to_kidnap"]):
		return [StageScene.Choking, "idle", {pc="starter", npc="reacter"}]
	if(getState() in ["about_to_submit"]):
		return [StageScene.SexStanding, "tease", {
			pc="reacter",npc="starter",
			bodyState={},
			npcBodyState={},
		}]
	return [StageScene.Duo, "stand", {pc="starter", npc="reacter"}]

func getActivityIconForRole(_role:String):
	return RoomStuff.PawnActivity.Chat

func getPreviewLineForRole(_role:String) -> String:
	if(_role == "starter"):
		return "{starter.name} is chatting with {reacter.name}."
	if(_role == "reacter"):
		return "{reacter.name} is chatting with {starter.name}."
	return .getPreviewLineForRole(_role)

func doHelpStruggleForStarter():
	var theStarter = getRoleChar("starter")
	var struggleData:Dictionary = theStarter.doStruggleOutOfRestraints(false, true, getRoleChar("reacter"), 2.0)
	if(struggleData.empty()):
		struggleText = "Something happened.."
	else:
		struggleText = struggleData["text"]

func saveData():
	var data = .saveData()

	data["chat"] = chat
	data["lust"] = lust
	data["chatAnswer"] = chatAnswer
	data["surrendered"] = surrendered
	data["notFirst"] = notFirst
	data["struggleText"] = struggleText
	data["tryCount"] = tryCount
	data["askCredits"] = askCredits
	data["didAmount"] = didAmount
	data["gotDenied"] = gotDenied
	return data

func loadData(_data):
	.loadData(_data)

	chat = SAVE.loadVar(_data, "chat", {})
	lust = SAVE.loadVar(_data, "lust", {})
	chatAnswer = SAVE.loadVar(_data, "chatAnswer", "")
	surrendered = SAVE.loadVar(_data, "surrendered", false)
	notFirst = SAVE.loadVar(_data, "notFirst", false)
	struggleText = SAVE.loadVar(_data, "struggleText", "")
	tryCount = SAVE.loadVar(_data, "tryCount", 0)
	askCredits = SAVE.loadVar(_data, "askCredits", 0)
	didAmount = SAVE.loadVar(_data, "didAmount", 0)
	gotDenied = SAVE.loadVar(_data, "gotDenied", false)

