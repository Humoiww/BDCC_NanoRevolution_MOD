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

func sayCharater(ch,text):
	saynn("[say=" +ch+ "]" +text + "[/say]")


func _run():
	if(state == ""):
		addCharacter("alexrynard")
		playAnimation(StageScene.Duo, "stand", {npc="alexrynard"})
		if(!getModuleFlag("NanoRevolutionModule", "NanoAskAlexKey", false)):
			sayCharater("pc","Hey, Alex, can I ask you something?")
			sayCharater("alexrynard","What’s up?")
			sayCharater("pc","I’ve been curious about how those nano androids work. It’s pretty fascinating. You seem to know a lot about them—think you could give me a rundown?")
			saynn("A suspicious expression flickers across Alex’s face. ")
			sayCharater("alexrynard","Why the sudden interest?")
			sayCharater("pc","Oh, just trying to understand the tech better. You know, see how it all fits together. Plus, I’ve heard some things about how the key system works. Any chance you could fill me in?")
			sayCharater("alexrynard","Hold on a second...where did you hear the word \"key\"? It’s not something a normal inmate would know about.")
			addButton("Lie","Try to think a excuse for this","a_excuse")
			addButton("Honest","Humoi didn’t specifically say not to expose her to Alex, did she?","humoi_truth")
		else:
			addCharacter("humoi")
			playAnimation(StageScene.Duo, "stand", {npc="humoi"})
			sayCharater("humoi","Hi, just want to say sorry that this part hasn't implemented yet, come back in next large update X3")
			addButton("Leave","fine","endthescene")


	
	if(state == "a_excuse"):
		sayCharater("pc","Oh, it’s just something I picked up from overhearing a conversation. I didn’t think it was a big deal.")
		saynn("Alex shakes his head, a bemused smile tugging at the corners of his mouth.")
		sayCharater("alexrynard","Not a big deal? You don’t even know what you’re working with. It’s Humoi—the sneaky dragon, right?")
		addButton("Stay silence","How did he know this?","humoi_close")
		addButton("Honest","Humoi didn’t specifically say not to expose her to Alex, did she?","humoi_truth")
	
	if(state == "humoi_close"):
		sayCharater("alexrynard","Still not ready to spill the truth? That’s fine. Just be careful, Humoi is a tricky one. She might try to deceive you with her words. I bet she knows something about the key.")
		saynn("Wait, did she lie to you? Why would she do that?")
		sayCharater("alexrynard","Now that you’ve got what you need, head back and give my regards to Humoi. I'm kind of busy now.")
		addButton("Leave","Nothing so much here.","endscenewithclue")


	if(state == "humoi_truth"):
		sayCharater("pc","Fine, It’s Humoi. She told me to ask you for any clues about the android key.")
		sayCharater("alexrynard","I figured as much. The only advice I can give you is to be cautious around her. Humoi is known for being tricky and may try to mislead you with her words. I’m pretty sure she knows something about the key.")
		saynn("Wait, did she lie to you? Why would she do that?")
		sayCharater("alexrynard","Now that you’ve got what you need, head back and give my regards to Humoi. I'm kind of busy now.")
		addButton("Leave","Nothing so much here.","endscenewithclue")
		

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "endscenewithclue"):
		GM.main.setModuleFlag("NanoRevolutionModule", "NanoAskAlexKey", true)
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

