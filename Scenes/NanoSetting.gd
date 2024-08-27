extends SceneBase

var nanoSpeciesDict
var events = GlobalRegistry.getEvents()


func are_keys_equal(dict1: Dictionary, dict2: Dictionary) -> bool:
	var keys1 = dict1.keys()
	var keys2 = dict2.keys()
	
	if keys1.size() != keys2.size():
		return false
	
	for key in keys1:
		if not keys2.has(key):
			return false
	
	return true


func _init():
	sceneID = "NanoSetting"
	


func _run():
	if(state == ""):
		addCharacter("humoi")
		playAnimation(StageScene.Duo, "stand", {pc = "pc", npc="humoi"})
		saynn("You look around, a lilac inmate with a strangle datapad walks toward you.")

		saynn("[say=humoi]Ah, a new face. Let me check… inmate number {pc.inmateNumber}, {pc.name} right? [/say]")

		saynn("She is holding her datapad, seemingly typing something.")

		saynn("[say=pc]Yes, that's me. Uh.. you are an inmate right?[/say]")

		saynn("[say=humoi]100% natural lilac inmate~ My name is humoi, good to see you. About this datapad? I have a part-time job from the medical department to check inmate psychological status.[/say]")

		addButton("Psychological?","How can an inmate do such things?","keep_ask")
	if(state == "keep_ask"):
		saynn("[say=pc]Psychological status?[/say]")

		saynn("[say=humoi]Well, several months ago, BDCC started the android assistant program, a program that lets these androids assist some tough tasks, like inspecting inmates. It works at first, but progressively, multiple cases indicate that these androids, especially their punishment mechanic, may cause some mental problems. [/say]")

		saynn("She sighs a little, and continues.")

		saynn("[say=humoi]Though I really like their size and punishment, I don't want others to feel uncomfortable with it. So I asked Eliza, the doctor in charge of the medical team here, to address this issue by using questionnaires. We will collect inmates' responses periodically, report their requirements to the engineering department and apply the changes.[/say]")

		saynn("She's getting closer.")

		saynn("[say=humoi]Now, do you have time to fill this little questionnaire for me? You can use me after you answering whole question~ [/say]")

		saynn("Hum, maybe that's why she suggested a questionnaire solution to the medic.")

		addButton("Certainly","I can do that. (Note: this questionnaire actually is an in-game setting scene for you to adjust the nano android spawning rule.)","Start_survey")
		addButton("Nope","I don't care about android settings. Default is just fine","no_change")
		addButton("Sex?","Check if the survey is really necessary.","skip_and_sex")
	if(state == "Start_survey"):
		saynn("She smiles, passing the datapad to you.")

		saynn("[say=humoi]Excellent, here you are. Just listen your heart and answer these questions.[/say]")

		addButton("Datapad","","Enter_survey")

	if(state == "Enter_survey"):
		saynn("=============================================")

		saynn("Nano Android Feedback - Inmate Version")

		saynn("=============================================")

		saynn("Welcome, this survey is intended to listen to all inmates' advice about the nano android program.")

		saynn("- [agree] I acknowledge my records will be used for adjusting the android generating rule and evaluating the prison safety index.")

		saynn("- [decline] Exit the survey.")

		addButton("agree","go to question 1","Q1")

	if(state == "Q1"):
		saynn("=============================================")

		saynn("Nano Android Feedback - Inmate Version")

		saynn("=============================================")

		saynn("Question 1:")

		saynn("Currently our android gender distribution is:")

		saynn("Do you feel comfortable with that?")

		addButton("Yes","go to question 2","Q2")

	if(state == "Q2"):

		saynn("=============================================")

		saynn("Nano Android Feedback - Inmate Version")

		saynn("=============================================")

		saynn("Question 2:")

		saynn("Currently our android species distribution is:")

		saynn("Do you feel comfortable with that?")

		saynn("Also, if there's a new species entering or leaving BDCC, your record about this part will be erased. Please submit another record after that.")

		addButton("Yes","go to question 3","Q3")
	if(state == "Q3"):

		saynn("=============================================")

		saynn("Nano Android Feedback - Inmate Version")

		saynn("=============================================")

		saynn("Question 3:")

		saynn("Currently our android body size range is:")

		saynn("Do you feel comfortable with that?")

		addButton("Yes","go to question 4","Q4")

	if(state == "Q4"):

		saynn("=============================================")

		saynn("Nano Android Feedback - Inmate Version")

		saynn("=============================================")

		var allevents = GlobalRegistry.getEvents()
		print(allevents)
		saynn("Question 4:")

		saynn("Now among all events when you walk around in cell area, you have probality to get frisked by nano guard.")

		saynn("Do you feel comfortable with that?")
		
		addButton("Yes","go to the last question","Q_end")

	if(state == "Q_end"):

		saynn("=============================================")

		saynn("Nano Android Feedback - Inmate Version")

		saynn("=============================================")

		saynn("Final Question:")

		saynn("Do you have any suggestions or questions related to this new program? If so, please click the ISSUE button.")

		saynn("(Well, this question is kind of weird. The ISSUE button is a hyperlink connected to the Github issue page of this mod. You can make your suggestions there ^V^)")
		
		addButton("No","That's it","finish_answer")
		addButton("ISSUE","I have some suggestion. (This will open your browser)","issue")

	if(state == "issue"):
		saynn("You've been redirect to the issue page.")

		saynn("[say=humoi]Thanks so much for your suggestion. Now, looks like someone is waiting for {pc.hisHer} rewards~[/say]")

	if(state == "finish_answer"):
		saynn("You complete all these questions. Humoi grab her datapad back and smile.")

		saynn("[say=humoi]Looks like someone is waiting for {pc.hisHer} rewards~[/say]")


	if(state == "no_change"):
		saynn("[say=pc]Sorry,I am quite busy now.[/say]")

		saynn("Humoi chuckles and grabs the datapad back.")

		saynn("[say=pc]It's fine. Just remember, you are free to find me and change your options. I'm lilac, so you know you can find me. See you around~[/say]")

		addButton("Leave","Boring survey","endthescene")

	if(state == "skip_and_sex"):
		saynn("[say=pc]May I use you without such survey.[/say]")

		saynn("Humoi giggles and grabs the datapad back.")

		saynn("[say=pc]Well, it seems someone is pretty horny today. Yes, use me as an useless sextory~[/say]")

		saynn("(end scene)")

		addButtonWithChecks("Sex!", "Time to fuck them!", "startsexasdom", [], [ButtonChecks.CanStartSex])

		
func _react(_action: String, _args):
	
	if(_action == "keep_ask"):
		
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
		endScene()
		return

	setState(_action)


func _react_scene_end(_tag, _result):
	if(_tag in ["subbysex", "domsex"]):
		endScene()

