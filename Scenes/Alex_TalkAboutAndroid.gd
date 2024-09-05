extends SceneBase

var bratCounter = 0

func _init():
	sceneID = "Alex_TalkAboutAndroid"

func displayCoreCount(coreAmount):
	if coreAmount > 1:
		saynn("You have "+ str(coreAmount) +" cores.")
	elif coreAmount > 0:
		saynn("You have only one core.")
	else:
		saynn("You don't have any core.")
func _run():
	if(state == ""):
		addCharacter("alexrynard")
		playAnimation(StageScene.Duo, "stand", {npc="alexrynard"})

		saynn("Want to learn something?")
	if(state == "debug_message_state"):

		var coreAmount = GM.pc.getInventory().getAmountOf("NanoCore")
		displayCoreCount(coreAmount)
		if(coreAmount >= 1):
			addButton("Trade","Trade one core","trade")
		else:
			addDisabledButton("Trade","You don't have any core, better go and get some for me?")
		addButton("Leave","Seems like there's not much to talk about right now, is there? But trust me, there'll be something in the future. X3","endthescene")
	if(state == "trade"):
		var coreAmount = GM.pc.getInventory().getAmountOf("NanoCore")
		displayCoreCount(coreAmount)
		if(coreAmount >= 1):
			addButton("Trade","Trade one core","trade")
		else:
			addDisabledButton("Trade","You don't have any core, better go and get some for me?")
		addButton("Leave","Seems like there's not much to talk about right now, is there? But trust me, there'll be something in the future. X3","endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "trade"):
		GM.pc.getInventory().removeXOfOrDestroy("NanoCore",1)
		GM.pc.addCredits(3)
		setState("trade")
		return

	if(_action == "aftercare"):
		processTime(30*60)

	setState(_action)

func saveData():
	var data = .saveData()

	return data

func loadData(data):
	.loadData(data)

