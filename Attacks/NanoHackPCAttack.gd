extends Attack
var attacker
func _init():
	id = "NanoHackPCAttack"
	category = Category.Special
	aiCategory = AICategory.Offensive
	
func getVisibleName(_context = {}):
	return "Hack"
	
func getVisibleDesc(_context = {}):
	return "Hack in target system. Need target"
	
func _doAttack(_attacker, _receiver, _context = {}):

	var texts = [
		"{attacker.name} manages to land a few strong punches on {receiver.name}",
	]
	var text = RNG.pick(texts)
	

	return {
		text = text,
		pain = RNG.randi_range(10,20)
	}
# func doAttack(_attacker, _receiver, _context = {}):
# 	doRequirements(_attacker, _receiver)



func getRequirementText(req):
	var reqtype = req[0]
	if(reqtype == "isNanoAndroid"):
		return "Target should be silicon based creature."
	if(reqtype == "knownKey"):
		return "You should know admin Key to the android."
	if(reqtype == "hasRemainCharge"):
		return "Your controller should have unused charge."


func getRequirementsColorText(_attacker, _receiver):
	var reqs = getRequirements()
	var text = ""
	for req in reqs:
		if(req is String):
			req = [req]
		if(req[0] == "knownKey" and (!GM.main.getModuleFlag("NanoRevolutionModule", "NanoTriggerKeyQuest", false))):
			continue
		var reqText = getRequirementText(req)
		var reqCan = checkRequirement(_attacker, _receiver, req)
		if(reqCan):
			text += reqText
		else:
			text += "[color=red]" + reqText + "[/color]"
		text += "\n"
	
	return text
func checkRequirement(_attacker, _receiver, req):

	var reqtype = req[0]
	if(reqtype == "isNanoAndroid"):
		if!("nanoAndroid"  in _receiver.getSpecies()):
			return false
	if(reqtype == "knownKey"):
		# if know we need key + don't have key
		if (GM.main.getModuleFlag("NanoRevolutionModule", "NanoTriggerKeyQuest", false)  &&  !GM.main.getModuleFlag("NanoRevolutionModule", "NanoKnowAndroidKey", false)):
			return false
	if(reqtype == "hasRemainCharge"):
		if(GM.main.getModuleFlag("NanoRevolutionModule", "NanoControllerRemainCharge", 1) < 0.8):
			return false
	return true

func getAttackHitReactAnimation(_attacker, _receiver, _result):
	if(_result.has("pain") && _result["pain"] > 0):
		return "kneel"
	return ""

func getRequirements():
	return ["isNanoAndroid","knownKey","hasRemainCharge"]

func getAttackSoloAnimation():
	return "punch"

func getExperience():
	return [[Skill.Combat, 10]]

func getAnticipationText(_attacker, _receiver):
	return "{attacker.name} is about to punch {receiver.name}!"

func getAttackerDamageMultiplierEfficiency(_attacker, _receiver, _damageType) -> float:
	return 2.0
