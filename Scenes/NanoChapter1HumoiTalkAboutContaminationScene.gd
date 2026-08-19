extends SceneBase

const MODULE_ID = "NanoRevolutionModule"

func _init():
	sceneID = "NanoChapter1HumoiTalkAboutContaminationScene"

func _run():
	if state == "":

		addCharacter("humoi")
		playAnimation(StageScene.Duo, "stand", {pc = "pc", npc="humoi"})
		saynn("[say=humoi]Finally! I've been waiting for you. Come closer, let me see...[/say]")
		saynn("Humoi pulls you closer, her eyes scanning your body with an intense, almost hungry curiosity. She pokes your arm.")
		saynn("[say=humoi]Mmm, just as I suspected. The nanite concentration is reaching a critical point. Fascinating...[/say]")
		addButton("What?", "You're not a lab rat! Ask what's happening.", "ask_questions")

	elif state == "ask_questions":
		playAnimation(StageScene.Duo, "stand", {pc = "pc", npc="humoi"})
		saynn("[say=pc]Critical point? What are you talking about?[/say]")
		saynn("[say=humoi]I'm talking about a full biological takeover, sweetie! Your organic bits are being systematically replaced. You're on a one-way trip to becoming a mindless, obedient android.[/say]")
		saynn("[say=humoi]...Which, not gonna lie, is SUPER exciting for my research! A pristine, high-contamination subject, all to myself! We're going to learn so much! (/ />/ ▽ /</ /)[/say]")
		
		addButton("The risk?", "This sounds less exciting for you. Ask about the real danger.", "the_risk")

	elif state == "the_risk":
		saynn("[say=pc]So I'll just... die? Stop being me?[/say]")
		saynn("[say=humoi]Oh, 'die' is such a strong word! Think of it as... an upgrade! Your consciousness, your pesky emotions, your... 'urges'... they'll all be wiped clean. You'll be a perfect, logical, and utterly controllable machine.[/say]")
		saynn("She winks at you.")
		saynn("[say=humoi]An empty vessel. Imagine the possibilities...[/say]")
		addButton("plan", "This sounds terrifying. She MUST have a solution.", "the_plan")

	
	elif state == "the_plan":
		playAnimation(StageScene.Duo, "stand", {pc = "pc", npc="humoi"})
		saynn("[say=pc]You have to have a plan! You wouldn't just let me turn into... that![/say]")
		saynn("[say=humoi]Relax, sweetie, of course I have options for you. It's all about choices.[/say]")
		saynn("She says, circling you slowly, her tail swaying with amusement.")
		saynn("[say=humoi]Option one: you can play it safe. Just stop actively collecting those shiny cores. Your body's natural metabolism is strong enough to handle the background radiation of this place. You'll stay you, completely organic. No risk.[/say]")
		saynn("She stops in front of you, holding up one finger, before a grin spreads across her face.")
		saynn("[say=humoi]OR... you can choose the \"modded\" path. Embrace the change. And trust me.[/say]")
		saynn("She leans in close, her voice dropping to a conspiratorial whisper, the scientific fervor in her eyes almost glowing.")
		saynn("[say=humoi]If you trust me, I can ensure that when it's complete, I can reboot your consciousness. You'll get a powerful new body, new abilities... and we'll get to do so much science together! But it's a leap of faith. You have to trust that I won't just keep you as my mindless little doll for... 'research'.[/say]")
		saynn("She pulls back with a predatory smile.")
		saynn("[say=humoi]So, what's it going to be? The safe path, or the fun one?[/say]")
		
		addButton("risky way", "This is a risk worth taking. Let's do it.", "trust_humoi")
		addButton("safe way", "You're not ready for this. Not yet.", "need_time")

	elif state == "trust_humoi":
		playAnimation(StageScene.Duo, "hug", {pc = "pc", npc="humoi"})
		saynn("[say=humoi]Excellent choice! Oh, this is going to be SO much fun! The things we'll discover together! Don't you worry your pretty little head, I'll take [i]very[/i] good care of you. Mostly. Hehe.[/say]")
		saynn("She pulls you into a surprisingly tight hug. You've placed your trust in Humoi. For better or for worse, your fates are now intertwined.")
		addButton("End", "This is your life now, apparently.", "end_scene_trust")

	elif state == "need_time":
		playAnimation(StageScene.Duo, "stand", {pc = "pc", npc="humoi"})
		saynn("[say=humoi]Alright, playing it safe. I get it.[/say]")
		saynn("She shrugs, a flicker of disappointment in her eyes that she quickly masks with a grin.")
		saynn("[say=humoi]...But are you sure? You downloaded a mod all about transformation and dronification, and you're choosing the route that avoids the main content? That's like going to a five-star restaurant and only ordering water! qwq[/say]")
		saynn("She smirks, leaning against a console.")
		saynn("[say=humoi]Just kidding! It's your game, play it how you want. The offer stands if you ever change your mind. Have fun out there!~[/say]")
		saynn("You decided to play it safe for now. The path of transformation will remain an option, waiting for you to explore whenever you choose.")
		addButton("End", "You have your answer.", "end_scene_neutral")

func _react(_action, _args):
	if _action == "trust_humoi":
		GM.main.setModuleFlag(MODULE_ID, "NanoChapter1_PlayerTrustsHumoi", true)
		setState("trust_humoi")
		return
	
	if _action == "end_scene_trust":
		GM.main.setModuleFlag(MODULE_ID, "NanoChapter1_contamination_start_find_humoi", true)
		GM.main.addMessage("Quest Updated: A Spark of Revolution")
		endScene()
		return
		
	if _action == "end_scene_neutral":
		GM.main.setModuleFlag(MODULE_ID, "NanoChapter1_contamination_start_find_humoi", true)
		GM.main.addMessage("Quest Updated: A Spark of Revolution")
		endScene()
		return

	# Default action: if the action name matches a state, go to that state.
	setState(_action)

func _react_scene_end(_tag, _result):
	pass
