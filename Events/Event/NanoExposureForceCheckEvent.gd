extends EventBase
var NanoGuardGenerator = preload("res://Modules/NanoRevolution/Characters/Dynamic/Generator/NanoGuardGenerator.gd")

func _init():
	id = "NanoExposureForceCheckEvent"
func registerTriggers(es):
	es.addTrigger(self, Trigger.HighExposureInmateEvent)

func react(_triggerID, _args):
	if(!getModuleFlag("NanoRevolutionModule", "NanoMeetHumoi", false)):
		runScene("NanoSetting")
		return true
	var guardPoolSize = 5
	var sexDollPool = GM.main.getDynamicCharacterIDsFromPool("SexDoll")
	var guardPool = GM.main.getDynamicCharacterIDsFromPool("NanoGuard")
	if(guardPool.size() > 5):
		guardPoolSize = guardPool.size()

	# have some chance to meet your sex Doll, 1->16% 
	if RNG.chance((sexDollPool.size() * 100.0)/guardPoolSize):
		var idToUse = NpcFinder.grabNpcIDFromPool("SexDoll")
		if(GM.ES.triggerReact(Trigger.TalkingToDynamicNPC, [idToUse])):
			return true
		
		runScene("NanoMeetSexDollScene", [idToUse])

		return true



	var encounterLevel = RNG.randi_range(0, 5)
	if(_args.size() > 0):
		encounterLevel = _args[0]
		
	NpcFinder.grabNpcIDFromPool("SexDoll")
	var idToUse = grabNpcIDFromPoolOrGenerate("NanoGuard", [], NanoGuardGenerator.new(), {NpcGen.Level: encounterLevel})
	
	if(idToUse == null || idToUse == ""):
		return false
		
	if(GM.ES.triggerReact(Trigger.TalkingToDynamicNPC, [idToUse])):
		return true
		
	runScene("NanoExposureForceCheckScene", [idToUse])

	return true


func getPriority():
	return 10
