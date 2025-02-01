extends Attack

func _init():
	id = "NanoLatexRegeneration"
	category = Category.Physical
	aiCategory = AICategory.DefensivePain
	aiScoreMultiplier = 0.8
	
func getVisibleName(_context = {}):
	return "Latex Regeneration"
	
func getVisibleDesc(_context = {}):
	return "Grab your oponent and absorb their energy."
	
func _doAttack(_attacker, _receiver, _context = {}):
	var recover = 30 + GM.pc.getSkillLevel("NanoFunction")
	if(checkMissed(_attacker, _receiver, DamageType.Physical)):
		return genericMissMessage(_attacker, _receiver)
	
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		return genericDodgeMessage(_attacker, _receiver)
	
	var text = "{attacker.name} manages to coil {attacker.his} whip around {receiver.name}'s body and pull {receiver.him} close! {attacker.name}'s latex layer rapidly regenerates using {receiver.name}'s stamina!"
	if(_receiver.getStamina() > 0):
		_attacker.addPain(-recover)
		_attacker.addStamina(recover)
	return {
		text = text,
		pain = 5,
		stamina = recover,
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	var text = " {attacker.name} morphs {attacker.his} hand into a latex whip and tries to strike you with it!"

	return text

func getRequirements():
	return [AttackRequirement.FreeArms, AttackRequirement.FreeHands]
	

func getAttackSoloAnimation():
	return "shove"

#func getRecieverArmorScaling(_attacker, _receiver, _damageType) -> float:
#	return 0.0
func getExperience():
	return [[Skill.Combat, 10],["NanoFunction", 10]]
