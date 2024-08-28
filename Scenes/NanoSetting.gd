extends SceneBase

var nanoSpeciesDict = {}
var nanoGenderDict = {}
var baseGenderDict = {}
var eventsDict = {}
var timesCame = 0
var totalWeight = 0
var pickedSpeciesToChange = ""
var pickedgenderToChange = ""

func are_keys_equal(dict1: Dictionary, dict2: Dictionary) -> bool:
	var keys1 = dict1.keys()
	var keys2 = dict2.keys()
	if keys1.size() != keys2.size():
		return false
	for key in keys1:
		if not keys2.has(key):
			return false
	return true

func add_panel():
	saynn("=============================================")

	saynn("Nano Android Feedback - Inmate Version")

	saynn("=============================================")

func setSpeciesWeight(species,chance):
	nanoSpeciesDict[species] = chance
	setModuleFlag("NanoRevolutionModule", "NanoAndroidSpeciesDistr",nanoSpeciesDict)

func setGenderWeight(gender,chance):
	nanoGenderDict[gender] = chance
	setModuleFlag("NanoRevolutionModule", "NanoAndroidGuardGenderDistr",nanoGenderDict)

func _init():
	sceneID = "NanoSetting"
	
func _initScene(_args = []):
	# check if extra mod added
	var allSpecies = GlobalRegistry.getAllSpecies()
	var basicSpeciesDict = {}
	for speciesID in allSpecies:
		var specie = allSpecies[speciesID]
		if(!specie.canBeUsedForNPCType("guard")):
			continue
		
		var weight = GM.main.getEncounterSettings().getSpeciesWeight(speciesID)
		if(weight != null && weight > 0.0):
			basicSpeciesDict[speciesID] =  weight
	nanoSpeciesDict = getModuleFlag("NanoRevolutionModule", "NanoAndroidSpeciesDistr",{})
	if (!are_keys_equal(nanoSpeciesDict,basicSpeciesDict)):
		print("different key detect, erase original")
		nanoSpeciesDict = basicSpeciesDict
		setModuleFlag("NanoRevolutionModule", "NanoAndroidSpeciesDistr",nanoSpeciesDict)

	var allgenders = NpcGender.getAll()
	for gender in allgenders:
		baseGenderDict[gender] = NpcGender.getDefaultWeight(gender)
	nanoGenderDict = getModuleFlag("NanoRevolutionModule", "NanoAndroidGenderDistr",baseGenderDict)
	

	timesCame = 0
	if(_args.size() > 0):
		setState(_args[0])

func _run():
	if(state == ""):
		addCharacter("humoi")
		playAnimation(StageScene.Duo, "stand", {pc = "pc", npc="humoi"})
		saynn("You look around and see a lilac, fluffy dragon with a strange datapad walking toward you.")

		saynn("[say=humoi]Ah, a new face. Let me check… inmate number {pc.inmateNumber}, {pc.name} right? [/say]")

		saynn("She is holding her datapad, seemingly typing something.")

		saynn("[say=pc]Yes, that's me. Uh.. you are an inmate right?[/say]")

		saynn("[say=humoi]100% pure lilac inmate~ My name is humoi, good to see you.[/say]")

		addButton("Datapad?","How can an inmate have this?","keep_ask")
	if(state == "keep_ask"):
		saynn("[say=humoi]This datapad? It’s for my part-time job with the medical department, checking on inmates' psychological status.[/say]")

		saynn("[say=pc]Psychological status?[/say]")

		saynn("[say=humoi]Yeah, a few months ago, XYZ launched the android assistant program, where androids help with tough tasks, like inspecting inmates. It seemed to work at first, but over time, multiple cases showed that these androids—especially their punishment mechanisms—might be causing some mental health issues.[/say]")

		saynn("She sighs a little, and continues.")

		saynn("[say=humoi]Though I really like their size and punishment, I didn’t want others to feel uncomfortable with it, so I asked Eliza, the doctor in charge of the medical team here, to address the issue through questionnaires. We collect the inmates' responses periodically, report their needs to the engineering department, and implement any necessary changes.[/say]")

		saynn("She's moving closer.")

		saynn("[say=humoi]Now, do you have time to fill out this quick questionnaire for me? You can use me after you answering whole question~ [/say]")

		saynn("Well, maybe that's why she suggested a questionnaire solution to the medic.")

		addButton("Certainly","I can do that. \n(Note: this questionnaire actually is an in-game setting scene for you to adjust the nano android spawning rule.)","Start_survey")
		addButton("Nope","I don't care about android settings. Default is just fine","no_change")
		addButton("Sex?","Check if the survey is really necessary.","skip_and_sex")

	if(state == "see_again"):
		addCharacter("humoi")
		playAnimation(StageScene.Duo, "stand", {pc = "pc", npc="humoi"})
		saynn("You stand in Humoi's cell.")
		saynn("[say=humoi]Oh, hi {pc.name}. Up for another round?[/say]")

		addButton("Certainly","Do the survey","Start_survey")
		addButton("Sex?","You just come here for ","skip_and_sex")
		addButton("Leave","Sorry, wrong cell","endthescene")
		
	if(state == "Start_survey"):
		saynn("She smiles, passing the datapad to you.")

		saynn("[say=humoi]Excellent, here you go. Just follow your instincts and answer these questions.[/say]")

		addButton("Datapad","","Enter_survey")

	if(state == "Enter_survey"):
		add_panel()

		saynn("Welcome! This survey is designed to gather feedback from all inmates about the nano-android program.")
		
		saynn("Please note: Your participation is voluntary, and all responses will be kept confidential. The information collected will be used solely for improving the nano-android program and ensuring overall safety.")

		saynn("- [Agree] I understand that my responses will be used to adjust the android generation protocols and assess the prison's safety index.")

		saynn("- [Decline] Exit the survey.")

		addButton("agree","start survey","menu")

	if(state == "menu"):
		add_panel()

		saynn("Question Menu, click question number button to submit according response.")

		saynn("- [Q1] Nano Android Gender")

		saynn("- [Q2] Nano Android Race")

		saynn("- [Q3] Nano Android Body Attribute")

		saynn("- [Q4] Nano Android Check Frequency")

		saynn("- [ISSUE] Send an issue to the engineering team")

		saynn("- [decline] Exit the survey.")

		addButton("Q1_gender","go to question 1","Q1")
		addButton("Q2_species","go to question 2","Q2")
		addButton("Q3_size","go to question 3","Q3")
		addButton("Q4_frequency","go to question 4","Q4")
		addButton("ISSUE","make a suggestion","Q_end")

	if(state == "Q1"):
		add_panel()

		saynn("Question 1:")

		saynn("Currently our android gender distribution is:")

		nanoGenderDict = getModuleFlag("NanoRevolutionModule", "NanoAndroidGenderDistr",baseGenderDict)
		for gender in nanoGenderDict:
			var weight = nanoGenderDict[gender]
			sayn(str(gender)+": "+str(Util.roundF(weight*100.0, 1))+"%")
			
		sayn("")


		saynn("Are you comfortable with this? If you'd like to adjust, please click \"Edit\" to make changes.")
		
		addButton("Yes","go to question 2","Q2")

	if(state == "Q1_menu"):
		addButton("Back", "Close this menu", "")
		
		sayn("Relative chances for the gender of encountered npcs:")
		nanoGenderDict = getModuleFlag("NanoRevolutionModule", "NanoAndroidGenderDistr",baseGenderDict)
		for gender in nanoGenderDict:
			var genderName = gender
			var weight = nanoGenderDict[gender]
			sayn(str(genderName)+": "+str(Util.roundF(weight*100.0, 1))+"%")
			addButton(gender,"Change the chance of this gender", "genderchancemenu", [gender])
		sayn("")

	if(state == "genderchancemenu"):
		var gender = pickedgenderToChange
		saynn("The current chance for "+gender +" is "+str(Util.roundF(nanoGenderDict[gender]*100.0, 1))+"%")

		addButton("Back", "Go back to the previous menu", "Q3_menu")
		# addButton("Default", "Set back to default chance", "setgenderchance", [gender, -1.0])
		for chance in [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0, 1.2, 1.5, 2.0, 3.0]:
			addButton(str(Util.roundF(chance*100.0))+"%", "Pick this chance", "setgenderchance", [gender, chance])

	if(state == "Q2"):

		add_panel()

		saynn("Question 2:")

		saynn("Currently our android reference species distribution is:")

		nanoSpeciesDict = getModuleFlag("NanoRevolutionModule", "NanoAndroidSpeciesDistr",{})
		var species = GlobalRegistry.getAllPlayableSpecies()
		for speciesID in species:
			var speciesObject:Species = species[speciesID]
			var speciesName = speciesObject.getVisibleName()
			
			var weight = nanoSpeciesDict[speciesID]
			sayn(str(speciesName)+": "+str(Util.roundF(weight*100.0, 1))+"%")
		sayn("")
		saynn("Are you comfortable with this? If you'd like to adjust, please click \"Edit\" to make changes.")
		
		saynn("Please note that if a new species enters or leaves BDCC, your record for this section will be erased. You'll need to submit a new record afterward.")

		addButton("Yes","go to question 3","Q3")
		addButton("Edit","I want to edit","Q2_menu")
		addButton("Last","I want to review the last question","Q1")
		addButtonAt(10,"Menu","Back to main menu","menu")
		addButtonAt(14,"End","End the survey","finish_answer")


	if(state == "Q2_menu"):
		addButton("Back", "Close this menu", "")
		
		sayn("Relative chances for the species of encountered npcs:")
		var species = GlobalRegistry.getAllPlayableSpecies()
		for speciesID in species:
			var speciesObject:Species = species[speciesID]
			var speciesName = speciesObject.getVisibleName()
			
			var weight = nanoSpeciesDict[speciesID]
			sayn(str(speciesName)+": "+str(Util.roundF(weight*100.0, 1))+"%")
			addButton(speciesName, "Change the chance of this species", "specieschancemenu", [speciesID])
		sayn("")

	if(state == "specieschancemenu"):
		var species = pickedSpeciesToChange
		var speciesObject:Species = GlobalRegistry.getSpecies(species)
		var speciesName = speciesObject.getVisibleName()
		saynn("The current chance for "+speciesName+" is "+str(Util.roundF(nanoSpeciesDict[species]*100.0, 1))+"%")

		addButton("Back", "Go back to the previous menu", "Q3_menu")
		# addButton("Default", "Set back to default chance", "setspecieschance", [species, -1.0])
		for chance in [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0, 1.2, 1.5, 2.0, 3.0]:
			addButton(str(Util.roundF(chance*100.0))+"%", "Pick this chance", "setspecieschance", [species, chance])

	if(state == "Q3"):
		add_panel()

		saynn("Question 3:")

		saynn("Currently our android visible component size range is:")
		var cockMin = getModuleFlag("NanoRevolutionModule", "NanoAndroidMinCockSize",0)
		var cockMax = getModuleFlag("NanoRevolutionModule", "NanoAndroidMaxCockSize",40)
		var breastMin = getModuleFlag("NanoRevolutionModule", "NanoAndroidMinCupSize",BreastsSize.FLAT)
		var breastMax = getModuleFlag("NanoRevolutionModule", "NanoAndroidMaxCupSize",BreastsSize.O)
		sayn("Penis Length :" + str(cockMin) + "~" + str(cockMax) + "cm")
		sayn("Breast Size :" + BreastsSize.breastSizeToCupString(breastMin) + " ~ " + BreastsSize.breastSizeToCupString(breastMax))

		saynn("Are you comfortable with this? If you'd like to adjust, please click \"Edit\" to make changes.")

		addButton("Yes","go to question 4","Q4")
		addButton("Edit","I want to edit","Q3_menu")
		addButton("Last","I want to review the last question","Q2")
		addButtonAt(10,"Menu","Back to main menu","menu")
		addButtonAt(14,"End","End the survey","finish_answer")



	if(state == "Q4"):
		var weighEvents = GM.ES.eventTriggers[Trigger.HighExposureInmateEvent]
		totalWeight = 0
		
		var targetWeight = 0
		for i in range(weighEvents.events.size()):
			
			if(weighEvents.events[i].id == "NanoExposureForceCheckEvent"):
				weighEvents.weights[i] = getModuleFlag("NanoRevolutionModule", "NanoAndroidGuardAppearWeight", 10)
				targetWeight = weighEvents.weights[i]
			else:
				totalWeight += weighEvents.weights[i]
		var prob = float(targetWeight)/(float(targetWeight) + totalWeight)
		print(prob)
		var probability = ("%.2f" % (prob*100)) + "%"


		add_panel()

		saynn("Question 4:")

		saynn("While walking around the cell area, you have a "+  probability +" chance of being frisked by a nano guard.")

		saynn("Are you comfortable with this? If you'd like to adjust, please click \"Edit\" to make changes.")
		
		
		addButton("Yes","go to the last question","Q_end")
		addButton("Edit","I want to edit","Q4_menu")
		addButton("Last","I want to review the last question","Q3")
		addButtonAt(10,"Menu","Back to main menu","menu")
		addButtonAt(14,"End","End the survey","finish_answer")

	if(state == "Q4_menu"):
		add_panel()
		var weighEvents = GM.ES.eventTriggers[Trigger.HighExposureInmateEvent]
		totalWeight = 0
		
		var targetWeight = 0
		for i in range(weighEvents.events.size()):
			
			if(weighEvents.events[i].id == "NanoExposureForceCheckEvent"):
				weighEvents.weights[i] = getModuleFlag("NanoRevolutionModule", "NanoAndroidGuardAppearWeight", 10)
				targetWeight = weighEvents.weights[i]
			else:
				totalWeight += weighEvents.weights[i]
			print(weighEvents.events[i].id)
			print(weighEvents.weights[i])
		var prob = float(targetWeight)/(float(targetWeight) + totalWeight)
		print(prob)
		var probability = ("%.2f" % (prob*100)) + "%"
		saynn("While walking around the cell area, you have a "+  probability +" chance of being frisked by a nano guard.")

		saynn("Change the probability through following selection. Click the Done button if you are satisfied with current selection. ")

		saynn("Please note that it's not possible to completely avoid inmate encounters, so you can only increase this setting up to 99%")

		addButton("0%", "Change the probability", "Q4_edit", [0])
		addButton("25%", "Change the probability", "Q4_edit", [0.25])
		addButton("50%", "Change the probability", "Q4_edit", [0.5])
		addButton("75%", "Change the probability", "Q4_edit", [0.75])
		addButton("99%", "Change the probability", "Q4_edit", [0.99])
		addButton("-15%", "Change the probability", "Q4_edit", [prob-0.15])
		addButton("-5%", "Change the probability", "Q4_edit", [prob-0.05])
		addButton("-1%", "Change the probability", "Q4_edit", [prob-0.01])
		addButton("+1%", "Change the probability", "Q4_edit", [prob+0.01])
		addButton("+5%", "Change the probability", "Q4_edit", [prob+0.05])
		addButton("+15%", "Change the probability", "Q4_edit", [prob+0.15])
		addButtonAt(14,"Done","Save changes","Q4")



	if(state == "Q_end"):

		add_panel()

		saynn("Final Question:")

		saynn("Do you have any suggestions or questions related to this new program? If so, please click the ISSUE button.")

		saynn("(Well, this question is kind of weird. The ISSUE button is a hyperlink connected to the Github issue page of this mod. You can make your suggestions there ^V^)")
		
		addButton("No","That's it","finish_answer")
		addButton("ISSUE","I have some suggestion. \n(Note: This will open your browser)","issue")
		addButtonAt(10,"Menu","Back to main menu","menu")
		addButtonAt(14,"End","End the survey","finish_answer")

	if(state == "issue"):
		add_panel()
		saynn("You've been redirect to the issue page.")

		saynn("Your response has been recorded successfully. If you wish to edit your response, click \"Menu\" to review your answers. You can now click the \"Leave\" button and return the datapad to its owner.")
		addButtonAt(10,"Menu","Back to main menu","menu")
		addButtonAt(14,"Leave","End the survey","return_datapad")

	if(state == "finish_answer"):
		add_panel()
		saynn("Your response has been recorded successfully. If you wish to edit your response, click \"Menu\" to review your answers. You can now click the \"Leave\" button and return the datapad to its owner.")
		addButtonAt(10,"Menu","Back to main menu","menu")
		addButtonAt(14,"Leave","End the survey","return_datapad")

	if(state == "return_datapad"):
		saynn("You complete all these questions. Humoi grab her datapad back and giggles.")

		saynn("[say=humoi]Looks like someone is waiting for {pc.hisHer} rewards~[/say]")

		addButtonWithChecks("Sex!", "Time to fuck them!", "startsexasdom", [], [ButtonChecks.CanStartSex])
		addButton("Leave","No interest for now","endthescene")

	if(state == "no_change"):
		saynn("[say=pc]Sorry,I am quite busy now.[/say]")

		saynn("Humoi chuckles and grabs the datapad back.")
		
		saynn("[say=humoi]It's fine. Just remember, you are free to find me and change your options. I'm lilac, so you know you can find me. See you around~[/say]")

		addButton("Leave","Boring survey","endthescene")

	if(state == "skip_and_sex"):
		saynn("Humoi giggles and put the datapad beside.")

		saynn("[say=humoi]Looks like someone is pretty horny today. Yes, use me as an useless sextory~[/say]")

		addButtonWithChecks("Sex!", "Time to fuck them!", "startsexasdom", [], [ButtonChecks.CanStartSex])
		addButton("Leave","You changed your idea","after_sex")

	if(state == "after_sex"):
		if(!getModuleFlag("NanoRevolutionModule", "NanoMeetHumoi", false)):
			if(timesCame < 1):
				saynn("[say=humoi]Stop now? Ok, if you really in hurry. Just remember, you are free to find me and change your options. I'm lilac, so you know where you can find me. See you around~[/say]")
			elif(timesCame < 5):
				saynn("[say=humoi]Wow, thanks for such good sex. Just remember, you are free to find me and change your options. I'm lilac, so you know where you can find me. See you around~[/say]")
			elif(timesCame < 10):
				saynn("[say=humoi]Hey... hey... I'm nearly exhausted. I kinda like you now~ come to my cell later, so you can edit your answer, and... you know, rewards heh heh..[/say]")
			else:
				saynn("[say=humoi]...sex...so..much..cumming.....come...my..room....change.....rewards~[/say]")
				saynn("Humoi colapse on the floor. Maybe she is noticing you to change your answer in her lilac cell if you want")
		else:
			if(timesCame < 1):
				saynn("[say=humoi]Stop now? Ok, if you really in hurry. See you around.[/say]")
			elif(timesCame < 5):
				saynn("[say=humoi]Wow, thanks for such good sex. See you around~[/say]")
			elif(timesCame < 10):
				saynn("[say=humoi]Hey... hey... I'm nearly exhausted. You are really a good partner, we should do that again~[/say]")
			else:
				saynn("[say=humoi]...sex...so..much..cumming....Ahhh.....I...am....yours.....[/say]")
				saynn("Humoi colapse on the floor.")
		addButton("Leave","Should go now","endthescene")
		
func _react(_action: String, _args):
	
	if(_action in ["keep_ask","see_again"]):
		
		var allSpecies = GlobalRegistry.getAllSpecies()
		var basicSpeciesDict = {}
		for speciesID in allSpecies:
			var specie = allSpecies[speciesID]
			if(!specie.canBeUsedForNPCType("guard")):
				continue
			
			var weight = GM.main.getEncounterSettings().getSpeciesWeight(speciesID)
			if(weight != null && weight > 0.0):
				basicSpeciesDict[speciesID] =  weight
		nanoSpeciesDict = getModuleFlag("NanoRevolutionModule", "NanoAndroidSpeciesDistr",{})
		if (!are_keys_equal(nanoSpeciesDict,basicSpeciesDict)):
			nanoSpeciesDict = basicSpeciesDict
			setModuleFlag("NanoRevolutionModule", "NanoAndroidSpeciesDistr",nanoSpeciesDict)

	if(_action == "startsexasdom"):
		runScene("GenericSexScene", ["pc", "humoi"], "domsex")

	if(_action == "issue"):
		var _ok = OS.shell_open("https://github.com/Humoiww/BDCC_NanoRevolution_MOD/issues/new/choose")

	if(_action == "endthescene"):
		setModuleFlag("NanoRevolutionModule","NanoMeetHumoi",true)
		endScene()
		return

	if(_action == "Q4_edit"):
		if(_args.size() > 0):
			var target_prob = _args[0]
			if(target_prob < 0):
				target_prob = 0
			if(target_prob > 0.99):
				target_prob = 0.99
			var new_weight = float(totalWeight)*target_prob/(1-target_prob)
			print("debug:")
			print(totalWeight)
			print(new_weight)
			setModuleFlag("NanoRevolutionModule", "NanoAndroidGuardAppearWeight", new_weight)
			# var loadedevents = GlobalRegistry.getEvents()
			# var event = loadedevents["NanoExposureForceCheckEvent"]
			# event.updatePrior()
		setState("Q4_menu")
		return
	if(_action == "specieschancemenu"):
		pickedSpeciesToChange = _args[0]	


	if(_action == "setspecieschance"):
		setSpeciesWeight(_args[0], _args[1])
		
		setState("Q3_menu")
		return
	setState(_action)


func _react_scene_end(_tag, _result):
	if(_tag in ["subbysex", "domsex"]):
		var sexresult = _result[0]
		
		if(sexresult.has("subs") && sexresult["subs"].has("humoi")):
			timesCame = sexresult["subs"]["humoi"]["timesCame"]

		setState("after_sex")

