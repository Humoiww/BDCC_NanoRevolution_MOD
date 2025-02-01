extends Attack

func _init():
	id = "NanoHeatGrenade"
	category = Category.Special
	aiCategory = AICategory.Defensive
	aiScoreMultiplier = 0.8
	
func getVisibleName(_context = {}):
	return "Heat grenade"
	
func getVisibleDesc(_context = {}):
	return "Throw a prototype grenades to induce your oponent's lust."
	
func _doAttack(_attacker, _receiver, _context = {}):

	if(checkMissed(_attacker, _receiver, DamageType.Lust)):
		return genericMissMessage(_attacker, _receiver)
	
	if(checkDodged(_attacker, _receiver, DamageType.Lust)):
		return genericDodgeMessage(_attacker, _receiver)
	
	var text = "{receiver.name} breathe in the pink mist and feel extremely horny, many dirty thoughts pass through {receiver.hisHer} head. Maybe surrendering isn’t such a bad idea.."
	text += "\n\n"
	text += "[say=attacker]"+RNG.pick(["Yeah, just enjoy it.", "Stop resist, embrace it.", "If you submit, we can do something really fun~"])+"[/say]"
	return {
		text = text,
		lust = RNG.randi_range(30, 80)+ GM.pc.getSkillLevel("NanoFunction"),
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	return "{attacker.name} pulls out one of the prototype grenades out of {attacker.hisHer} chest cavity, throws it in {receiver.name}'s direction. A [b]big pink smoke[/b] trail following it in the air!"

func getAttackSoloAnimation():
	return "throw"

func getExperience():
	return [[Skill.Combat, 10],["NanoFunction", 10]]

func getRequirements():
	return [AttackRequirement.FreeArms, AttackRequirement.FreeHands]
