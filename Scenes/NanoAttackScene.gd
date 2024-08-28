extends SceneBase

func _init():
	sceneID = "NanoAttackScene"

func createPart(bodypartSlot):
	var possible = []
	var fullWeight = 0.0
	var character = GM.pc
	var theSpecies = character.getSpecies()
	var allbodypartsIDs = GlobalRegistry.getBodypartsIdsBySlot(bodypartSlot)
	for bodypartID in allbodypartsIDs:
		var bodypart = GlobalRegistry.getBodypartRef(bodypartID)
		var supportedSpecies = bodypart.getCompatibleSpecies()
		
		var hasInSupported = false
		var hasInAllowed = false
		
		for supported in supportedSpecies:
			if((supported in theSpecies) || supported == Species.AnyNPC): # || supported == Species.Any
				hasInSupported = true
				break
			
		for playerSpecie in theSpecies:
			var speciesObject = GlobalRegistry.getSpecies(playerSpecie)
			if(bodypartID in speciesObject.getAllowedBodyparts()):
				hasInAllowed = true
				break
		
		if(hasInSupported || hasInAllowed):
			var weight = bodypart.npcGenerationWeight(character)
			if(weight != null && weight > 0.0):
				possible.append([bodypartID, weight])
				fullWeight += weight

	# Adding the default bodypart of this species into the mix
	for specie in theSpecies:
		var speciesObject = GlobalRegistry.getSpecies(specie)
		var bodypartID = speciesObject.getDefaultForSlotForNpcGender(bodypartSlot, NpcGender.Herm)
		var alreadyHasInPossible = false
		for possibleEntry in possible:
			if(possibleEntry[0] == bodypartID):
				alreadyHasInPossible = true
				break
		if(alreadyHasInPossible):
			continue
		if(bodypartID == null):
			possible.append([null, 1.0])
			fullWeight += 1.0
			continue
		var bodypart = GlobalRegistry.getBodypartRef(bodypartID)
		var weight = bodypart.npcGenerationWeight(character)
		if(weight != null && weight > 0.0):
			possible.append([bodypartID, weight])
			fullWeight += weight

	#print(bodypartSlot, " ", possible) # Uncomment for debug
	if(possible.size() > 0):
		if(!RNG.chance(fullWeight * 100.0)):
			return
		
		var bodypartID = RNG.pickWeightedPairs(possible)
		if(bodypartID != null):
			var bodypart = GlobalRegistry.createBodypart(bodypartID)
			character.giveBodypartUnlessSame(bodypart)
			bodypart.generateDataFor(character)

func _run():
	if(state == ""):
		saynn("You pick the datapad up, there's a power button right beside it.")

		addButton("Turn it on", "Take a look at it", "datapad")
		addButton("Put it back", "Well, guess nothing special in it.", "endthescene")
	if(state == "datapad"):	
		saynn("=========================================")
		saynn("Nano Android Prototype Remote Control")
		saynn("=========================================")

		saynn("- State: [color=green]Connected[/color]")
		saynn("- <PLEASE CHECK THE MAIN SYSTEM FOR MORE ASSEMBLY LINE INFORMATION>")

		saynn("- [Records]")

		saynn("- [Enable Power]")

		saynn("- [Shut Down]")

		addButton("Records", "Check the messages", "look_messages")
		addButton("Enable power", "Press the notification that will enable the power", "do_enable_power")
		addButton("Shut Down", "Enough poking around", "endthescene")

	if(state == "look_messages"):
		saynn("=========================================")
		saynn("Nano Android Prototype Remote Control")
		saynn("=========================================")

		saynn("- [Record_0] - 1 years ago")

		saynn("- [Record_1] - 1 years ago")

		saynn("- [Back]")
		addButton("Record_0", "Check the first record", "readed_message_0")
		addButton("Record_1", "Check the second record", "readed_message_1")
		addButton("Back", "Enough reading", "datapad")
	if(state == "readed_message_0"):
		saynn("You check the first record")

		saynn("[say=alexrynard]Captain. How about fully simulated android?[/say]")

		saynn("[say=captain]What do you mean?[/say]")

		saynn("[say=alexrynard]An android, fully simulate a person. It can think, learn, talk, eat, and death, just like a normal person.[/say]")

		saynn("[say=captain]That's not possible. [/say]")

		saynn("[say=alexrynard]Captain, I understand your concern, but we are pretty close to this step, the only we need to do is slight adjustment. We can cooperate with medical team and simulate the living organs system.[/say]")

		saynn("[say=captain]That can't convince me.[/say]")

		saynn("[say=alexrynard]But you can't just reject any possibility without any experiment. Just one more month, our team can make another prototype, than you can make your decision.[/say]")

		saynn("[say=captain]I still suspect feasibility of this plan.[/say]")

		saynn("[say=alexrynard]I know, but we've worked on this project for several years, Captain. Just one month, you can check our status whenever you want, and if there's any problem, we can stop the project right, but please, let us have another try.[/say]")

		saynn("[say=captain]OK, deal, one last month, if you can provide a prototype that showing enough reliability, then we can continue this project. Otherwise, we will cancel this project and close this lab immediately.[/say]")

		saynn("[say=alexrynard]Thanks, Captain[/say]")

		saynn("The messages end there.")

		addButton("Back", "..", "look_messages")

	if(state == "readed_message_1"):
		saynn("You check the second record")

		saynn("[say=captain]Any update?[/say]")

		saynn("[say=alexrynard]Captain, I think you are correct, the full simulated android idea was fatally flaw at start.[/say]")

		saynn("[say=captain]So you agree with me, and decide to stop this project.[/say]")

		saynn("[say=alexrynard]Yes, but can I point a substitute solution?[/say]")

		saynn("[say=captain]Go on.[/say]")

		saynn("[say=alexrynard]So, Captain, you concern is the robot will lie to you, cause you cannot read their mind, right?[/say]")

		saynn("[say=captain]That's the point.[/say]")

		saynn("[say=alexrynard]And this does happened for advance self-supervised AI, which even the most proficient engineer cannot check their memory directly. But how about we restrict the AI to the traditional one, the engineers design the feature and job for it, and supervise it status. And you can supervise these engineers. They are people, so they are reliable.[/say]")

		saynn("[say=captain]What if the AI cheat the engineers.[/say]")

		saynn("[say=alexrynard]Nearly impossible to traditional one, with lack of reinforcement learning technique. They cannot learn anything from the new conditions. The only thing they can do and remember is the pre-build function inside. Here's a demo.....[/say]")

		saynn("The messages end there.")

		addButton("Back", "..", "look_messages")

	if(state == "do_enable_power"):
		saynn("=========================================")
		saynn("Nano Android Prototype Remote Control")
		saynn("=========================================")
		saynn("[color=red]Warning: Unidentified lifeform detected. Please ensure the assembly room is cleared before proceeding with activation.[/color]")

		saynn("Hum, a warning shown on the screen, what will do you now?")

		addButton("ACTIVATE", "Safety regulations? Just scary tricks, nothing more.\n(Content Warning: Force Transformation, Inanimate Transformation)", "do_activate")
		addDisabledButton("leave", "Yeah, rules don't exist without a reason. We can just leave this room and see what will happened\n (Sorry, not implemented yet qwq)")
		addButton("CANCEL", "Better think twice", "datapad")
	if(state == "do_activate"):
		# addCharacter("NanoSystem")
		playAnimation(StageScene.Solo, "defeat")

		saynn("You just press the button anyway")

		saynn("Suddenly, a huge flash light just blind your eye and huge electrical shock just pass through your body.")

		addButton("Continue", "Ouch", "machine_wakesup")
	if(state == "machine_wakesup"):
		playAnimation(StageScene.TentaclesTease, "inside", {bodyState={naked=true, hard=true}})
		
		saynn("[say=NanoSystem]Detected available android template. Use the template for nano assembling[/say]")

		saynn("You feel a sudden, latex tentacles shoot out from the walls, gripping you with cold, unyielding force. You thrash instinctively, but the tentacles are relentless, trying to pull you toward the center of the facility.")

		saynn("[say=pc]Wha?! I'm not android template![/say]")
		addButton("Run", "Try to get away from it", "machine_try_run")

	if(state == "machine_try_run"):
		playAnimation(StageScene.TentaclesSex, "tease", {bodyState={naked=true, hard=true}})
		GM.pc.removeAllRestraints()
		for slot in InventorySlot.getAll():
			if slot == InventorySlot.Neck:
				continue
			GM.pc.getInventory().clearSlot(slot)
		saynn("You try your best to get to the door you entered. Unfortunately, it seems locked by this system. Before you notice, several latex tentacles grip your arm and leg, hold you in to the air.")
		addButton("Struggle", "Try to stop it", "machine_try_stop")
	if(state == "machine_try_stop"):
		
		var thePC = GM.pc
		var _theSpecies = thePC.getSpecies()
		saynn("You try to pull the goo tentacles away, but it doesn't work. The black goo starts climbing your legs, arm, and than covering your whole body.")

		saynn("[say=pc]Help! Can anyone hear me?[/say]")

		saynn("You yell, cry, but no one response. Without warning, several tentacles start to penetrate every holes in your body. Huge amount of black goos flux into your mouth.")
		
		saynn("[say=NanoSystem]Switching to Standard Guard Body Module[/say]")	

		var description = "You feel those black goo flow to your crotch. Suddenly, great pleasure shocks your head, making you hard to think anything."
		GM.pc.setGender(Gender.Androgynous)
		if(!GM.pc.hasVagina()):
			createPart(BodypartSlot.Vagina)
			description += "You grow a pussy right below your crotch. "
		if(!GM.pc.hasPenis()):
			createPart(BodypartSlot.Penis)
			description += "A giant cock grow from your pussy. "
		else:
			description += "Your cock now transform into 40cm long. "
		var _penis = GM.pc.getBodypart(BodypartSlot.Penis)
		_penis.lengthCM = 40
		var _breasts = GM.pc.getBodypart(BodypartSlot.Breasts)
		playAnimation(StageScene.TentaclesSex, "sex", {pcCum=true, bodyState={naked=true, hard=true}})
		if(_breasts.size > BreastsSize.FOREVER_FLAT):
			if(_breasts.size < BreastsSize.O):
				description += "And your breast constantly grow to the maximum size"
				_breasts.size = BreastsSize.O
		else:
			var NewBreasts = GlobalRegistry.createBodypart("humanbreasts")
			NewBreasts.size = BreastsSize.O
			GM.pc.giveBodypartUnlessSame(NewBreasts)
			description += "And your breast constantly grow to the maximum size"
		saynn(description)
		saynn("You fight to hold on to your thoughts, your memories, but they’re shooting away with your cum, drowned out by the relentless pleasure. You feel the goo flow in your body progressly replace every fragment of your body. Strangely, you feel that becoming an android isn't that bad....")
		
		saynn("[say=pc]Obey.....[/say]")
		
		var pcSkinData={
		"hair": {"r": Color("ff21253e"),"g": Color("ff4143a8"),"b": Color("ff000000"),},
		"penis": {"r": Color("ff242424"),"g": Color("ff070707"),"b": Color("ff01b2f9"),},
		}
		thePC.pickedSkin="HumanSkin"
		thePC.pickedSkinRColor=Color("ff080808")
		thePC.pickedSkinGColor=Color("ff363636")
		thePC.pickedSkinBColor=Color("ff678def")
		
		thePC.setSpecies(["nanoAndroid"]) # yeah this magical function change PC's species 
		

		for bodypartSlot in pcSkinData:
			if(!thePC.hasBodypart(bodypartSlot)):
				continue
			var bodypart = thePC.getBodypart(bodypartSlot)
			var bodypartSkinData = pcSkinData[bodypartSlot]
			if(bodypartSkinData.has("skin")):
				bodypart.pickedSkin = bodypartSkinData["skin"]
			if(bodypartSkinData.has("r")):
				bodypart.pickedRColor = bodypartSkinData["r"]
			if(bodypartSkinData.has("g")):
				bodypart.pickedGColor = bodypartSkinData["g"]
			if(bodypartSkinData.has("b")):
				bodypart.pickedBColor = bodypartSkinData["b"]
		thePC.updateAppearance()
	

		addButton("Obey", "....", "machine_complete")

	if(state == "machine_complete"):
		playAnimation(StageScene.TentaclesSex, "fast", {pcCum=true,bodyState={naked=true, hard=true}})
		saynn("The transformation continue, you hard think anything except the system command.")

		saynn("[say=alexrynard]Gosh, the damn door, what happened[/say]")

		saynn("A familiar voice with smashing sound from outside. Is it someone in your database?")

		saynn("[say=alexrynard]OK. System interrupt, and force open[/say]")

		addButton("Continue", "Alex rush in", "alexrynard_break")

	if(state == "alexrynard_break"):
		addCharacter("alexrynard")
		playAnimation(StageScene.Beg, "beg", {
			pc="pc",npc="alexrynard", pcCum=true,
			bodyState={naked = true, hard = true},
			npcBodyState={},
		})
		saynn("[say=alexrynard]{pc.name}! Are you OK? Response me if you can still listening[/say]")

		saynn("[say=pc]Serial number confirmed: System Manager. Initiating greeting protocol. Greeting Sir, what can I do for you?[/say]")

		saynn("You knee down, awaiting your master's command...")

		saynn("[say=alexrynard]No.. NO! Not again.... Backup memory set! That should work![/say]")

		saynn("[say=pc]Sir, is there any problem?[/say]")

		saynn("Alex quickly check the falling datapad, entering some command, and a medical purpose table appear")

		saynn("[say=alexrynard]Now, go and lay on that machine.[/say]")
		
		saynn("[say=pc]Yes, sir.[/say]")
		addButton("OBEY", "follow the command", "memory_injection")
	
	if(state == "memory_injection"):
		playAnimation(StageScene.BDSMMachineAltFuck, "fastdouble", {
			pc="pc",npc="pc",
			bodyState={naked = true, hard = true},
			npcBodyState={naked = true, hard = true},
		})
		saynn("As you lay on that machine, the manipulater hold you belly down, with your hand and leg fixed by the grips. Then, two dildos emerge, simutaneously penetrate your both hole. Before you react, excessive liquid squirt into your body.")
		saynn("[say=alexrynard]Hope this will work....[/say]")
		saynn("Your mind shocked by drastic impact, faded into unconscious.")
		
		
		GM.main.setModuleFlag("NanoRevolutionModule","NanoAttackSceneHappened",true)
		addButton("Faded", "You just lost your conscious", "Alex_wakey")

	if(state == "Alex_wakey"):
		playAnimation(StageScene.GivingBirth, "idle", {
			pc="pc",npc="pc",
		})
		aimCameraAndSetLocName("eng_workshop")
		GM.pc.setLocation("eng_workshop")
		saynn("You wake up and notice that you are back into the engineer workshop, Alex sitting beside you, manipulating on his datapad.")
		addButton("Alex?", "He saved you?", "Alex_talk")

	if(state == "Alex_talk"):
		playAnimation(StageScene.Hug, "hug", {pc="alexrynard", npc="pc",npcbodyState={naked = true, hard = true}})

		saynn("[say=pc]Alex?[/say]")

		saynn("[say=alexrynard]Thank goodness, you finally awake.[/say]")

		saynn("Alex hugs you tightly.")

		saynn("[say=alexrynard]Do you remember me? Do you remember your name? Please... tell me your name if still remember everything.[/say]")

		addButton(GM.pc.getName(), "Yes, I still remember it", "Alex_plain")
		addButton(GM.pc.getInmateNumber(), "You haven't seen Alex panic that much, and you want to trick him a little bit more.", "Alex_joke")

	if(state == "Alex_plain"):
		saynn("[say=pc]It’s {pc.name}. I…[/say]")
		saynn("[say=alexrynard]Shhh, stop talking. It’s over now, and I’m here. Sit down, and let’s figure out what just happened.[/say]")
		addButton("Sit","Explain every thing","Alex_explain")
	if(state == "Alex_joke"):
		saynn("[say=pc]Android {pc.inmateNumber}, what can I help you sir.[/say]")
		saynn("Alex face turns to pale, staring at you. Notable tears start flowing from his eyes.")
		saynn("[say=pc]OK, OK! Sorry! Just kidding. I'm {pc.name}. You're Alex, my best friend.[/say]")
		saynn("Alex hugs you tighter.")
		saynn("[say=pc]Sorry, I..[/say]")
		saynn("[say=alexrynard]Shhh, stop talking. It’s over now, and I’m here. Sit down, and let’s figure out what just happened.[/say]")
		addButton("Sit","Explain every thing","Alex_explain")
	if(state == "Alex_explain"):
		playAnimation(StageScene.Duo, "sit", {pc = "pc", npc="alexrynard",
		})
		saynn("You explain your thoughts and actions after entering the assembling room.")

		saynn("[say=alexrynard]That's why we set up a restricted engineering area. \"Curiosity killed the cat.\" We sometimes use this to tease our feline coworkers, but it also serves as a reminder to be cautious when faced with something unfamiliar. Your curiosity really got you into trouble this time. You weren't meant to be in that area, and now look at what's happened.[/say]")
		
		saynn("You start inspecting your skin, now covered in some kind of shiny, black, goo-like substance. You try to stretch it out, but it doesn’t budge.")
		
		addButton("My Body?","Made of goo?","Alex_explain_2")

	if(state == "Alex_explain_2"):

		saynn("[say=alexrynard]Well, your old body? It’s been converted into carbon-based fuel for your new silicon-based form. In other words, your entire body—brain, heart, everything—has been replaced by nanosystems.[/say]")
		
		saynn("You still feel like you’re trapped in that nightmare, but with a clearer mind, it’s hard to doubt his intentions.")
		
		saynn("[say=pc]Am I, I mean {pc.name}, dead?[/say]")

		saynn("[say=alexrynard]Yes and no. It’s like the Ship of Theseus paradox. You might seem like just a nano-duplicate of {pc.name} with {pc.hisHer} memories, but consider this: all the cells in our bodies are replaced at least once every ten years. This nano-assembly process just speeds that up. So, theoretically, you’re still alive—you’ve just changed the material of your body.[/say]")

		saynn("Seeing you are still a bit confused, Alex added")

		saynn("[say=alexrynard]The assembly machine you encountered is actually a beta version of our current production line. It can generate nano-androids that perfectly simulate living thoughts. However, at the end of testing, we realized that this process actually requires a living subject. So, we paused that plan and instead created less vivid, but more reliable—and, well, ethically correct—nano-androids.[/say]")

		saynn("[say=pc]So I'm the only one.[/say]")

		saynn("[say=alexrynard]Yes, you are the prototype of this version. Fortunately, the beta version worked, and you’ve retained your memories. Since this prototype was designed to simulate intelligent life, you can still respond to external stimuli just as you did before.[/say]")

		saynn("You check your body, wondering how you’ll ever explain this truth to your friends..")

		saynn("[say=alexrynard]To avoid excessive panic, I added a cognitive filtering system to your collar. This will make everyone see you as a normal inmate, though with a strange skin color. In other words, you’ll still be recognized as a regular inmate.[/say]")

		addButton("Collar?","why?","Alex_explain_3")

	if(state == "Alex_explain_3"):
		
		saynn("You point to the inmate collar around your neck")

		saynn("[say=pc]But why this collar? Can't you just... well, program myself to generate this filter? I mean this could be much safer if you want to control the panic from others.[/say]")

		saynn("[say=alexrynard]First, as I said, I still see you as a living being with free will, so I’d never program you unless absolutely necessary.\n\nSecond, I’ve reprogrammed the collar system to act as a sort of respawn point for your safety. When you defeat and extract the core from some nano-androids, they collapse into black goo and slip away. There’s a working assembly line in this facility that constantly collects this nano-goo and regenerates new androids. This mechanism, however, could be dangerous if you were to accidentally collapse into a pool of goo for some reason.[/say]")

		saynn("Alex glances at his datapad and continues")

		saynn("[say=alexrynard]Think of your collar as a unique assembly line just for you—an anchor that stabilizes your system. So, I strongly advise you not to remove it unless you’re prepared to face the captain. He controls the entire nano-android system, and it could cause serious trouble if he realizes you’ve been converted into a nano-android.[/say]")

		saynn("(Note: That's all the transformation content for now. There will be more system related to your new form in future update.(Yeah that's list in my plan owo))")

		saynn("(Note2: I know cognitive filtering system may not be a good idea, but since adding extra content to all other static character require excessive work, let me just put this idea here now, could be change (or maybe not) in future update :P")

		addButton("Got it","Starting your new life","endthescene")


func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
	if(_action == "Alex_wakey"):
		GM.main.startNewDay()
		GM.pc.afterSleeping()
		GM.main.showLog()
	

	setState(_action)

func getDevCommentary():
	return "I really like Rahi's Senital-X encounter, but unfortunately Senital-X cannot change us to the robot :(, so how about make a new encourter that can force this transformation?"

func hasDevCommentary():
	return true
