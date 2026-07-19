extends EventBase

const MODULE_ID = "NanoRevolutionModule"
var NanoGuardGenerator = preload("res://Modules/NanoRevolution/Characters/Dynamic/Generator/NanoGuardGenerator.gd")
# this whole bunch of stuff just for spawn Humoi qwq

func generate_random_times():
	var mean_time: float = getModuleFlag(MODULE_ID, "NanoCheckTimePeriod", 21600.0)  # 6 hours
	var std_dev: float = 3600
	var time = randf() * std_dev + mean_time  # 6 ~ 7 hours cool down time
	print("next generate time:")
	print(time)
	return time

func _init():
	id = "NanoExposureForceCheckEvent"
func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoom)
	# es.addTrigger(self, Trigger.PCLookingForTrouble)

func react(_triggerID, _args):
	# if (1<2): #no need to use this now xwx
	# 	return 
	# var currentTime = GM.main.getTime()
	# var isLookingForTrouble = (_triggerID == Trigger.PCLookingForTrouble)
	# var lastCheckTime = getModuleFlag("NanoRevolutionModule", "NanoLastCheckTime", 21600)
	# var cooldownTime = currentTime - lastCheckTime
	# var nextCheckTime = getModuleFlag("NanoRevolutionModule", "NanoNextCheckTime", 1800)

	# if((cooldownTime < nextCheckTime) && !isLookingForTrouble):
	# 	return
	# if(GM.pc.getLocation() == GM.pc.getCellLocation()):
	# 	# avoid android break into your room :C
	# 	return
	# setModuleFlag(MODULE_ID, "NanoLastCheckTime", currentTime)
	# setModuleFlag(MODULE_ID, "NanoNextCheckTime", generate_random_times())
	
	if(!getModuleFlag(MODULE_ID, "NanoMeetHumoi", false) && (getModuleFlag(MODULE_ID, "NanoCheckHappened", false) || getModuleFlag(MODULE_ID, "NanoSexDollMeeted", false))):
		runScene("NanoSetting")
		return true


	# var guardPoolSize = 5
	# var sexDollPool = GM.main.getDynamicCharacterIDsFromPool("SexDoll")
	# var guardPool = GM.main.getDynamicCharacterIDsFromPool("NanoGuard")
	# if(guardPool.size() > 5):
	# 	guardPoolSize = guardPool.size()

	# have some chance to meet your sex Doll, 1->16% 
	# if RNG.chance((sexDollPool.size() * 100.0)/guardPoolSize):
	# 	var idToUse = NpcFinder.grabNpcIDFromPool("SexDoll")
	# 	if(GM.ES.triggerReact(Trigger.TalkingToDynamicNPC, [idToUse])):
	# 		return true
		
	# 	runScene("NanoMeetSexDollScene", [idToUse])

	# 	return true



	# var encounterLevel = RNG.randi_range(0, 5)
	# # if(_args.size() > 0):
	# # 	encounterLevel = _args[0]
		
	# NpcFinder.grabNpcIDFromPool("SexDoll")
	# var idToUse = grabNpcIDFromPoolOrGenerate("NanoGuard", [], NanoGuardGenerator.new(), {NpcGen.Level: encounterLevel})
	
	# if(idToUse == null || idToUse == ""):
	# 	return false
		
	# if(GM.ES.triggerReact(Trigger.TalkingToDynamicNPC, [idToUse])):
	# 	return true
		
	# runScene("NanoExposureForceCheckScene", [idToUse])

	# return true


func getPriority():
	return 10
