extends EventBase
var NanoGuardGenerator = preload("res://Modules/NanoRevolution/Characters/Dynamic/Generator/NanoGuardGenerator.gd")


func _init():
	id = "NanoAndroidCheck"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoom)

func updateEverything():
	# update occurance
	var weighEvents = GM.ES.eventTriggers[Trigger.HighExposureInmateEvent]	
	for i in range(weighEvents.events.size()):
		# print("brute force load flag")
		if(weighEvents.events[i].id == "NanoExposureForceCheckEvent"):
			weighEvents.weights[i] = getModuleFlag("NanoRevolutionModule", "NanoAndroidGuardAppearWeight", 10)
	if getModuleFlag("NanoRevolutionModule", "NanoMeetHumoi", false):
		if (!getModuleFlag("NanoRevolutionModule", "NanoHasController",false)):
			addMessage("Hey! I just notice that you haven't got the nano controller yet, take this and have fun~")
			setModuleFlag("NanoRevolutionModule", "NanoHasController",true)
			GM.pc.getInventory().addItemID("NanoController")


func generateAndroidBaseCount(count):
	for _i in range(count):
		var idToUse = grabNpcIDFromPoolOrGenerate("NanoGuard", [], NanoGuardGenerator.new(), {NpcGen.Level: 1})
		# GlobalRegistry.getModule("NanoRevolutionModule").NIS.spawnPawn(idToUse)
		GM.main.IS.spawnPawn(idToUse)
			
func clockBasedAndroidSpawn():
	var count = 5
	var currentTime = GM.main.getTime()
	print(currentTime)
	if((currentTime >= 21600) and (!getModuleFlag("NanoRevolutionModule", "NanoIsGenerateThisMorning",false))):
		# Every morning, the system will generate 5 new/not new android based on account
		generateAndroidBaseCount(count)
		setModuleFlag("NanoRevolutionModule", "NanoIsGenerateThisMorning",true)
	


	

func run(_triggerID, _args):
	# saynn("Hello owo")
	# test even
	# so, a brute force way to keep the save
	updateEverything()
	# clockBasedAndroidSpawn()

	# addButton("DEBUG GEN","generate_android pawn????","generate_android")
	# var thePC = GM.pc
	# var pcColor = thePC.getBaseSkinColors()
	# print(thePC.getSpecies().has("nanoAndroid"))
	# if((thePC.getSpecies().has("nanoAndroid")) &&
	# ((thePC.getBaseSkinID() != "HumanSkin") || (pcColor != [Color("ff080808"),Color("ff363636"),Color("ff678def")]))):
				
	# 	var pcSkinData={
	# 	"hair": {"r": Color("ff21253e"),"g": Color("ff4143a8"),"b": Color("ff000000"),},
	# 	"penis": {"r": Color("ff242424"),"g": Color("ff070707"),"b": Color("ff01b2f9"),},
	# 	}
	# 	thePC.pickedSkin="HumanSkin"
	# 	thePC.pickedSkinRColor=Color("ff080808")
	# 	thePC.pickedSkinGColor=Color("ff363636")
	# 	thePC.pickedSkinBColor=Color("ff678def")
		
	# 	thePC.setSpecies(["nanoAndroid"]) # yeah this magical function change PC's species 
	# 	thePC.updateAppearance()

	# 	for bodypartSlot in pcSkinData:
	# 		if(!thePC.hasBodypart(bodypartSlot)):
	# 			#Log.error(getID()+" doesn't have "+str(bodypartSlot)+" slot but we're trying to paint it anyway inside paintBodyparts()")
	# 			continue
	# 		var bodypart = thePC.getBodypart(bodypartSlot)
	# 		var bodypartSkinData = pcSkinData[bodypartSlot]
	# 		if(bodypartSkinData.has("skin")):
	# 			bodypart.pickedSkin = bodypartSkinData["skin"]
	# 		if(bodypartSkinData.has("r")):
	# 			bodypart.pickedRColor = bodypartSkinData["r"]
	# 		if(bodypartSkinData.has("g")):
	# 			bodypart.pickedGColor = bodypartSkinData["g"]
	# 		if(bodypartSkinData.has("b")):
	# 			bodypart.pickedBColor = bodypartSkinData["b"]
		# pcSkinData={
		# "hair": {"r": Color("ff21253e"),"g": Color("ff4143a8"),"b": Color("ff000000"),},
		# "penis": {"r": Color("ff242424"),"g": Color("ff070707"),"b": Color("ff01b2f9"),},
		# }
	# if(_args.size() == 0):
	# 	return
	# var roomID = _args[0]
	
	# if(GM.main.canLootRoom(roomID)):
	# 	if(GM.pc.isBlindfolded() && !GM.pc.canHandleBlindness()):
	# 		saynn("You have a strong feeling there is something to loot here but you can't do it while blindfolded..")
	# 	else:
	# 		var room = GM.world.getRoomByID(roomID)
	# 		if(room == null):
	# 			return
			
	# 		var roomMessage = room.lootAroundMessage
	# 		if(roomMessage == null || roomMessage == ""):
	# 			roomMessage = "You notice something that you can loot here."
			
	# 		saynn(roomMessage)
	# 		addButton("Loot", "See what's here", "loot", [roomID])

func getPriority():
	return 1

func onButton(_method, _args):
	if(_method == "generate_android"):
		generateAndroidBaseCount(1)


