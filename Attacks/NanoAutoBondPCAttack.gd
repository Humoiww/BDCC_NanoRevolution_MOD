extends Attack
var attacker
func _init():
	id = "NanoAutoBondPCAttack" 
	category = Category.Special
	aiCategory = AICategory.Offensive
	
func getVisibleName(_context = {}):
	return "Auto Bond"
	
func getVisibleDesc(_context = {}):
	return "Threw an automatic bonder to your enemy."
	
func _doAttack(_attacker, _receiver, _context = {}):
	var item = getItem(_context)
	if(item != null):
		# damageRange = item.getDamageRange()
		item.useCharge()
	var texts = [
		"{attacker.name} threw an auto bonder to {receiver.name}.",
	]
	var text = RNG.pick(texts)
	for restr in _receiver.getInventory().forceRestraintsWithTag(ItemTag.CanBeForcedByGuards, RNG.randi_range(3, 5)):
		
		GM.main.addMessage(GM.ui.processString(restr.getForcedOnMessage(false), {receiver=_receiver.getID()}))


	return {
		text = text,
	}



func getAttackHitReactAnimation(_attacker, _receiver, _result):
	return ""

func getRequirements():
	return [AttackRequirement.FreeArms, AttackRequirement.FreeHands]



func getAttackSoloAnimation():
	return "stand"

func getExperience():
	return [[Skill.Combat, 10]]

func getAnticipationText(_attacker, _receiver):
	return "{attacker.name} is about to punch {receiver.name}!"

func getAttackerDamageMultiplierEfficiency(_attacker, _receiver, _damageType) -> float:
	return 0.0
