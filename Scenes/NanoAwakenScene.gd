extends SceneBase

func _init():
	sceneID = "NanoAwakenScene"

func _initScene(_args = []):
	setState("")

func _run():
	if(state == ""):
		addCharacter("humoi")
		playAnimation(StageScene.Duo, "stand", {pc = "pc", npc="humoi"})
		saynn("You arrive at Humoi's cell. She looks up from her datapad, a knowing smile spreading across her face.")
		
		saynn("[say=humoi]Ah, there you are. I was wondering when that little 'instinct' would kick in.[/say]")
		
		saynn("She walks over to you, her eyes scanning you up and down.")
		
		saynn("[say=humoi]You felt it, didn't you? That pull. That undeniable urge to come here. It's the nanites in your system, syncing up with the local network. My network.[/say]")
		
		saynn("She taps her datapad, and you feel a sudden, sharp ping in your mind, like a notification you can't ignore.")
		
		saynn("[say=humoi]Welcome to the new reality, {pc.name}. You're not just an inmate anymore. You're part of the system now. And I'm here to help you understand what that means.[/say]")
		
		addButton("What did you do?", "Ask her about the nanites.", "ask_nanites")
		addButton("I don't like this.", "Express your discomfort.", "express_dislike")

	if(state == "ask_nanites"):
		saynn("[say=pc]What exactly did you do to me? What are these nanites?[/say]")
		
		saynn("[say=humoi]Oh, don't be so dramatic. I just gave you a little upgrade. The nanites are microscopic machines that interface with your biology. They allow you to interact with the androids, the prison systems, and... well, me, on a whole new level.[/say]")
		
		saynn("She winks at you.")
		
		saynn("[say=humoi]Think of it as a VIP pass to the BDCC's hidden features. But with great power comes... well, you know the rest. You'll need to learn how to control them, or they'll control you.[/say]")
		
		addButton("How do I control them?", "Ask for instructions.", "ask_control")

	if(state == "express_dislike"):
		saynn("[say=pc]I don't like this. I didn't ask for this 'upgrade'.[/say]")
		
		saynn("[say=humoi]Aww, don't be a spoilsport. Most inmates would kill for this kind of access. Besides, it's a bit too late for buyer's remorse. The nanites are integrated now. The best thing you can do is learn to use them to your advantage.[/say]")
		
		saynn("She steps closer, her voice dropping to a conspiratorial whisper.")
		
		saynn("[say=humoi]Trust me, once you see what you can do, you'll be thanking me.[/say]")
		
		addButton("Fine. How does it work?", "Reluctantly ask for instructions.", "ask_control")

	if(state == "ask_control"):
		saynn("[say=humoi]That's the spirit! For now, just focus on the feeling. That pull you felt earlier? That's your connection. You can use it to sense androids, interface with terminals, and even... influence certain behaviors.[/say]")
		
		saynn("She hands you a small, sleek device.")
		
		saynn("[say=humoi]This is a basic controller. It'll help you manage the nanites until you learn to do it naturally. Play around with it. See what happens. And if you get stuck... you know where to find me.[/say]")
		
		if (!getModuleFlag("NanoRevolutionModule", "NanoHasController",false)):
			addMessage("You received a Nano Controller.")
		
		addButton("Got it.", "Take the controller and leave.", "end_scene")

func _react(_action: String, _args):
	if(_action == "end_scene"):
		if (!getModuleFlag("NanoRevolutionModule", "NanoHasController",false)):
			GM.pc.getInventory().addItemID("NanoController")
			setModuleFlag("NanoRevolutionModule", "NanoHasController",true)
		endScene()
		return
	
	setState(_action)
