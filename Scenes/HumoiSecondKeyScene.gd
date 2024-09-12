extends SceneBase

var bratCounter = 0

func _init():
	sceneID = "HumoiSecondKeyScene"


func sayCharater(ch,text):
	saynn("[say=" +ch+ "]" +text + "[/say]")


func _run():
	if(state == ""):
		
		addCharacter("humoi")
		playAnimation(StageScene.Duo, "stand", {npc="humoi", npcAction = "sit"})
		saynn("[say=pc]Humoi, we need to talk. I just had a chat with Alex. He mentioned that you might know something about the android key.[/say]")

		saynn("Humoi gives a playful smirk, leaning back with a casual air.")

		sayCharater("humoi","Oh, did he now? What exactly did Alex tell you?")
		sayCharater("pc","He mentioned I should be cautious around you and suggested you might be hiding information about the key. So, let’s get straight to the point: Why did you lie to me, and how can I actually find the key?")
		sayCharater("humoi","Okay, let me set things straight. I’m not lying to you—I really don’t know how to access the key directly. The androids use a dynamic password system with no key memory. But just because I don’t have the key doesn’t mean I can’t help you generate one. Your controller actually has a feature for creating the current key. I can tweak it a bit so it’ll generate the right key and get you through the check.")
		saynn("Humoi’s expression softens, her eyes narrowing into a playful smile. She takes a deep breath and continues.")
		sayCharater("humoi","Sorry if I’ve been juggling with words and playing a bit of a trick on you. But hey, at least now you’ve got a new friend who’s an official engineering member, right? To make up for it, I’ll upgrade your control panel for free. How’s that for a deal?")

		addButton("OK","Fair enough","endthescenewithkey")
		addDisabledButton("Punish","Sorry, not implemented yet. For now you can only accept this unfair deal. But I'm sure this self-rightous dragon will be get punished in the future.(maybe not next big update)")




func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "endthescenewithkey"):
		GM.main.setModuleFlag("NanoRevolutionModule", "NanoKnowAndroidKey", true)
		endScene()
		return

	if(_action == "trade"):
		GM.pc.getInventory().removeXOfOrDestroy("NanoCore",1)
		GM.pc.addCredits(3)
		setState("trade")
		return

	if(_action == "ask_key"):
		GM.main.setModuleFlag("NanoRevolutionModule", "NanoAskHumoiKey", true)

	if(_action == "aftercare"):
		processTime(30*60)

	setState(_action)

func saveData():
	var data = .saveData()

	return data

func loadData(data):
	.loadData(data)

