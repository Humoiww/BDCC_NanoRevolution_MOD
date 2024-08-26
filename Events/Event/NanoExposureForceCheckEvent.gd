extends EventBase
var NanoGuardGenerator = preload("res://Modules/NanoRevolution/Characters/Dynamic/Generator/NanoGuardGenerator.gd").new()
func _init():
	id = "NanoExposureForceCheckEvent"

func registerTriggers(es):
	es.addTrigger(self, Trigger.HighExposureInmateEvent)

func react(_triggerID, _args):
	if(!getModuleFlag("NanoRevolutionModule", "NanoMeetHumoi", false)):
		runScene("NanoExposureForceCheckScene")
		return true

	var encounterLevel = RNG.randi_range(0, 5)
	if(_args.size() > 0):
		encounterLevel = _args[0]
	
	var idToUse = grabNpcIDFromPoolOrGenerate("NanoGuard", [], NanoGuardGenerator, {NpcGen.Level: encounterLevel})
	
	if(idToUse == null || idToUse == ""):
		return false
		
	if(GM.ES.triggerReact(Trigger.TalkingToDynamicNPC, [idToUse])):
		return true
		
	runScene("NanoExposureForceCheckScene", [idToUse])

	return true

func getPriority():
	return 10
