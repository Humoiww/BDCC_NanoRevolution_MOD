extends Attack

func _init():
	id = "NanoLatexStrike"
	category = Category.Physical
	aiCategory = AICategory.Offensive
	
func getVisibleName(_context = {}):
	return "Latex Strike"
	
func getVisibleDesc(_context = {}):
	return "Strike with your latex-covered fist. This one won't miss no matter what!"
	
func _doAttack(_attacker, _receiver, _context = {}):
	#if(checkMissed(_attacker, _receiver, DamageType.Physical)):
	#	return genericMissMessage(_attacker, _receiver)
	
	#if(checkDodged(_attacker, _receiver, DamageType.Physical)):
	#	return genericDodgeMessage(_attacker, _receiver)
	
	var text = "{attacker.name} lunges forward, delivering a swift and forceful strike with {attacker.his} latex-covered fist, inflicting sharp pain upon impact."
	if(RNG.chance(10+ GM.pc.getSkillLevel("NanoFunction")) && _receiver.addEffect(StatusEffect.Bleeding)):
		text += " Sharp edges of {attacker.name}'s fist caused {receiver.name} to start [color=red]bleeding[/color]."
	return {
		text = text,
		pain = 30 + GM.pc.getSkillLevel("NanoFunction"),
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	var text = "{attacker.name} assumes a focused stance, ready to strike with precision. This one won't miss no matter what!"

	return text

func getRequirements():
	return [AttackRequirement.FreeArms, AttackRequirement.FreeHands, AttackRequirement.CanSee]
	

func getAttackSoloAnimation():
	return "punch"

#func getRecieverArmorScaling(_attacker, _receiver, _damageType) -> float:
#	return 3.0
func getExperience():
	return [[Skill.Combat, 10],["NanoFunction", 10]]
