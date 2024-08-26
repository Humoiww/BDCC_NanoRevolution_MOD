extends SceneBase
var nanoSpeciesDict


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
	var allSpecies = GlobalRegistry.getAllSpecies()
	var basicSpeciesDict = []
	for speciesID in allSpecies:
		var specie = allSpecies[speciesID]
		if(!specie.canBeUsedForNPCType("guard")):
			continue
		
		var weight = GM.main.getEncounterSettings().getSpeciesWeight(speciesID)
		if(weight != null && weight > 0.0):
			basicSpeciesDict.append([speciesID, weight])
	nanoSpeciesDict = getModuleFlag("NanoRevolutionModule", "NanoAndroidSpeciesDistr",{})
	if (!are_keys_equal(nanoSpeciesDict,basicSpeciesDict)):
		nanoSpeciesDict = basicSpeciesDict
		setModuleFlag("NanoRevolutionModule", "NanoAndroidSpeciesDistr",nanoSpeciesDict)


func _run():
	if(state == ""):
		saynn("You look around, a lilac inmate with a strangle datapad walks toward you.")

		saynn("[say=humoi]Ah, a new face. Let me check… inmate number {pc.inmateNumber}, {pc.name} right? [/say]")

		saynn("She is holding her datapad, seemingly typing something.")

		saynn("[say=pc]Yes, that's me. Uh.. you are an inmate right?[/say]")

		saynn("[say=humoi]100% natural lilac inmate~ My name is humoi, good to see you. About this datapad? I have a part-time job from the medical department to check inmate psychological status.[/say]")

		saynn("[say=pc]Psychological status?[/say]")

		saynn("[say=humoi]Well, several months ago, BDCC started the android assistant program, a program that lets these androids assist some tough tasks, like inspecting inmates. It works at first, but progressively, multiple cases indicate that these androids, especially their punishment mechanic, may cause some mental problems. [/say]")

		saynn("She sighs a little, and continues.")

		saynn("[say=humoi]Though I really like their size and punishment, I don't want others to feel uncomfortable with it. So I asked Eliza, the doctor in charge of the medical team here, to address this issue by using questionnaires. We will collect inmates' responses periodically, report their requirements to the engineering department and apply the changes.[/say]")

		saynn("She's getting closer.")

		saynn("[say=humoi]Now, do you have time to fill this little questionnaire for me? You can use me after you answering whole question~ [/say]")

		saynn("Hum, maybe that's why she suggested a questionnaire solution to the medic.")

		addButton("Certainly","I can do that. (Note: this questionnaire actually is an in-game setting scene for you to adjust the nano android spawning rule.)","Start_survey")

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

		saynn("=============================================")

		saynn("Nano Android Feedback - Inmate Version")

		saynn("=============================================")

		saynn("Question 2:")

		saynn("Currently our android species distribution is:")

		saynn("Do you feel comfortable with that?")

		saynn("Also, if there's a new species entering or leaving BDCC, your record about this part will be erased. Please submit another record after that.")

		saynn("=============================================")

		saynn("Nano Android Feedback - Inmate Version")

		saynn("=============================================")

		saynn("Question 3:")

		saynn("Currently our android body size range is:")

		saynn("Do you feel comfortable with that?")

		saynn("=============================================")

		saynn("Nano Android Feedback - Inmate Version")

		saynn("=============================================")

		saynn("Question 4:")

		saynn("Do you have any suggestions or questions related to this new program? If so, please click the ISSUE button.")

		saynn("(Well, this question is kind of weird. The ISSUE button is a hyperlink connected to the Github issue page of this mod. You can make your suggestions there ^V^)")

		saynn("You complete all these questions. Humoi grab her datapad back and smile.")

		saynn("[say=humoi]Looks like someone is waiting for {pc.hisher} rewards~[/say]")

	if(state == "I don't care about android settings."):
		saynn("[say=pc]Sorry,I am quite busy now.[/say]")

		saynn("Humoi chuckles and grabs the datapad back.")

		saynn("[say=pc]It's fine. Just remember, you are free to find me and change your options. I'm lilac, so you know you can find me. See you around~[/say]")

		saynn("(end scene)")

	if(state == "Check if the survey is really necessary."):
		saynn("[say=pc]May I use you without such survey.[/say]")

		saynn("Humoi giggles and grabs the datapad back.")

		saynn("[say=pc]Well, it seems someone is pretty horny today. Yes, use me as an useless sextory~[/say]")

		saynn("(end scene)")


func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	setState(_action)

