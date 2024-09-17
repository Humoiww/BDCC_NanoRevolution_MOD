extends SceneBase

var bratCounter = 0

func _init():
	sceneID = "HumoiTalkScene"

func displayCoreCount(coreAmount):
	if coreAmount > 1:
		saynn("You have "+ str(coreAmount) +" cores.")
	elif coreAmount > 0:
		saynn("You have only one core.")
	else:
		saynn("You don't have any core.")

func sayCharater(ch,text):
	saynn("[say=" +ch+ "]" +text + "[/say]")

func addBackStoryButton():
	addButton("Crime","How did she get here?","what_crime")
	addButton("Energetic","She seems so upbeat—it’s not something you’d expect in a place like this.","why_positive")
	addDisabledButton("Engineering","She’s incredibly skilled in nano engineering. What was her job before she ended up in prison? (Not implemented qwq, waiting for next big update)")
	addDisabledButton("Alex","What's the deal with her and Alex? They seem pretty familiar with each other. (Not implemented qwq, waiting for next big update)")
	addButton("Leave","Enough talk","endthescene")

func _run():
	if(state == ""):
		
		addCharacter("humoi")
		playAnimation(StageScene.Duo, "stand", {npc="humoi"})
		saynn("[say=humoi]So, you want to chat? Awesome! What’s on your mind?[/say]")

		addButton("Herself","Backstory?","humoi_self")
		if GM.main.getModuleFlag("NanoRevolutionModule", "NanoTriggerKeyQuest", false):
			if !GM.main.getModuleFlag("NanoRevolutionModule", "NanoAskHumoiKey", false):
				addButton("Key?","Does she know anything about android key?","ask_key")
			elif !GM.main.getModuleFlag("NanoRevolutionModule", "NanoAskAlexKey", false):
				addButton("Key","Review some key information","ask_key")
		
		if GM.pc.hasPerk("NanoCraftingT1"):
			addButton("Blueprint","Ask about available blueprint for nano core crafting","blueprint")
		
		if (!GM.pc.getInventory().hasItemID("NanoController")):
			addButton("Controller!","You accidentally lose your controller. (Probably you stack it somewhere, no worries, you can get a new one)","new_controller")
		else:
			addDisabledButton("Controller!","If you don’t have the controller in your inventory, just press this button, and I’ll give you a new one. \n(Note: You can store the controller in your cell and get as many as you want, but remember that the extra controllers are useless, so you’ll only be wasting your time X3)")
		addButton("Leave","I think that's it","endthescene")



	if(state == "humoi_self"):
		sayCharater("humoi","Yay, backstory time! What would you like to know?")
		addBackStoryButton()

	if(state == "what_crime"):
		sayCharater("pc","What's your crime? I know it must be some sex related, but I’m curious to hear the details.")
		sayCharater("humoi","Oh, my crime? Well, according to the prison record, I lead a massive, unauthorized orgy on the entire space station, Celestial Nexus. Not sure if you've heard of it.")
		sayCharater("pc","The whole station?! How on earth did you pull that off?")
		sayCharater("humoi","Simple: hacked into the station's system, played some hypnosis music, adding some heating gas, and voilà!")
		saynn("Simple? That’s like saying putting a spaceship in a refrigerator is easy. A look of skepticism crosses your face.")
		sayCharater("humoi","Don’t buy it? Hey, if you’ve got a better story to explain how I pulled it off, go ahead and use that one. I'm all ears!")
		saynn("Humoi chuckles, leaving you with little choice but to take her word... for now.")

		addButton("Why?","Why did she do that","why_crime")

		# addBackStoryButton()

	if(state == "why_crime"):
		sayCharater("humoi","For fun, obviously")
		saynn("Does this even count as a answer?")
		sayCharater("humoi","Well, that's my answer for you! If you're curious for more juicy details, you might want to dig around and find out for yourself! Oh wait, I forget that part hasn't implemented yet, sorry~")
		addMessage("Why does she keep broking the fourth wall?!(╯°^°)╯︵┻━┻")
		addBackStoryButton()

	
	if(state == "why_positive"):
		sayCharater("pc","Why are you so upbeat? It’s unusual to see anyone this positive in a place like this. Aren’t you bothered by being in prison?")
		sayCharater("humoi","First, obviously, as an liliac, people alreadly treat you as a their sex toy, no need to hypnosis or some other extra movement, which is perfect. Besides...")
		saynn("Humoi smiles and gestures towards an android guard patrolling near the cell.")
		sayCharater("humoi","Have you noticed those androids?")
		sayCharater("pc","Those android guards? Yes. They actually make me uncomfortable… It’s like being under constant surveillance, all the time, everywhere.")
		sayCharater("humoi","Yeah, they are. But the way they work is super fascinating. With some hacking skills, I can control them and make stuff you just can't find anywhere else. Kind of nerdy, but really interesting. Hey, just a tip—if you’re looking to craft something with nano cores, come find me. I’ve got some great deals for you!")
		addBackStoryButton()


	if(state == "ask_key"):
		if GM.main.getModuleFlag("NanoRevolutionModule", "NanoAskHumoiKey", false):
			sayCharater("humoi","Need more information? Sure, just ask anything you want!")
		else:
			sayCharater("humoi","So, you’ve found the backdoor software I created for these androids? Nice work! Unfortunately, I still don’t have any clues on how to access those keys. Maybe you should check with Alex. He’s a smart fox working in the engineering bay near the mining area, and he might have more information once he gets to know you better.")
			GM.main.setModuleFlag("NanoRevolutionModule", "NanoAskHumoiKey", true)
			addMessage("Updated: Figure out key quest")
		
		addButton("Strange","She designed the software but doesn’t have the key to access it? Why?","why_key")
		addButton("Alex?","Why does she think Alex might have a clue about the key?","why_alex")
		addButton("Why me?","So, she must have been designing this software for a while. Why didn’t she find the key herself?","why_me")
		addButton("Leave","OK then","endthescene")

	if(state == "why_key"):
		sayCharater("humoi","Well, that’s a common issue in engineering. Sometimes, we design a project but don’t anticipate every possible case. When we encounter an unexpected situation, we often have to pause the project until we find a solution.")
		saynn("She blinks and continues.")
		sayCharater("humoi","Once you have any clues about the key, I can probably make something to help with your hacking.")


		addDisabledButton("Strange","She designed the software but doesn’t have the key to access it? Why?")
		addButton("Alex?","Why does she think Alex might have a clue about the key?","why_alex")
		addButton("Why me?","So, she must have been designing this software for a while. Why didn’t she find the key herself?","why_me")
		addButton("Leave","OK then","endthescene")
	if(state == "why_alex"):
		sayCharater("humoi","So, Alex is a very ambitious fox working in engineering. He’s put a lot of effort into this project for some reason, so if you want more information about the nano androids, you should check with him.")
		saynn("She sighs a little.")
		sayCharater("humoi","Though I strongly suggest you avoid asking too much about why he put so much effort into this project until he brings it up himself. It’s not a story with a happy ending. Just keep an eye on this fox, alright? He’s been through a lot, and it’d mean a lot to me if you looked out for him. Think of it as a favor.")
		
		
		addButton("Strange","She designed the software but doesn’t have the key to access it? Why?","why_key")
		addDisabledButton("Alex?","Why does she think Alex might have a clue about the key?")
		addButton("Why me?","So, she must have been designing this software for a while. Why didn’t she find the key herself?","why_me")
		addButton("Leave","OK then","endthescene")	


	if(state == "why_me"):
		sayCharater("pc","Why don’t you go ask him about the key? You’re more familiar with him and the androids, so you might get better clues than I can provide.")
		sayCharater("humoi","There are two reasons. First, he knows me too well, so he probably won’t spill any clues about the key since he knows I could use it to mess things up. Second, getting chummy with Alex could really help you if you want to dig deeper into the nano androids.")


		addButton("Strange","She designed the software but doesn’t have the key to access it? Why?","why_key")
		addButton("Alex?","Why does she think Alex might have a clue about the key?","why_alex")
		addDisabledButton("Why me?","So, she must have been designing this software for a while. Why didn’t she find the key herself?")
		addButton("Leave","OK then","endthescene")



	if(state == "debug_message_state"):
		addCharacter("humoi")
		playAnimation(StageScene.Duo, "stand", {npc="humoi"})
		saynn("[say=humoi]So, you want to know more about me? You’re so sweet! But for now, sorry for breaking the fourth wall—I have to tell you that this scene hasn’t been implemented yet. This is the only part you’ll see for now.[/say]")
		
		saynn("Humoi playfully made a pouty face, tilting her head slightly.")

		saynn("[say=humoi]But I can give you a hint about what to expect in the future. It doesn’t make much sense for you to learn how to craft something with nano cores by kicking those androids' asses, right? You can get familiar with them, sure, but you’ll need to learn some techniques from others. That’s why I’m here—to offer advice and blueprints related to those nano things.[/say]")

		saynn("Humoi paused for a moment, thinking, then continued speaking.")

		saynn("[say=humoi]In this mod, I initially thought about having Alex teach you these things. But then I realized it would be out of character for him to teach something dangerous, like nano weapons or anything like that. So, there needs to be a “bad guy” to offer some forbidden knowledge for a bit of fun. That’s where I come in. In the next update, you’ll be able to get some really cool stuff from me. And if you have any great ideas, just remember there’s an issue option in the survey part.[/say]")
		
		saynn("Humoi flashed a mischievous grin.")
		
		saynn("[say=humoi]Well, since this scene is set up, let’s do a little test. See that Trade button? You can click it to give me one core, and I’ll give you 3 credits. Great deal, isn’t it?~[/say]")
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

	if(_action == "blueprint"):
		runScene("NanoBlueprintHumoi")
		endScene()
		return

	if(_action == "trade"):
		GM.pc.getInventory().removeXOfOrDestroy("NanoCore",1)
		GM.pc.addCredits(3)
		setState("trade")
		return


	if(_action == "aftercare"):
		processTime(30*60)

	if(_action == "new_controller"):
		GM.pc.getInventory().addItemID("NanoController")
		addMessage("Got it! A new one has just been added to your inventory.(-▽-)/")
		setState("")
		return
	setState(_action)

func saveData():
	var data = .saveData()

	return data

func loadData(data):
	.loadData(data)

