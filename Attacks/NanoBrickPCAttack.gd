extends Attack

func _init():
	id = "NanoBrickPCAttack"
	category = Category.Physical
	aiCategory = AICategory.Offensive
	isWeaponAttack = true
	
func getVisibleName(_context = {}):
	var item = getItem(_context)
	if(item == null):
		return "error"
	
	return item.getVisibleName()
	
func getVisibleDesc(_context = {}):
	var item = getItem(_context)
	if(item == null):
		return "error"
	
	return item.getVisisbleDescription()
	
func _doAttack(_attacker, _receiver, _context = {}):

	
	var damageRange = [0,0]
	
	var item = getItem(_context)
	if(item != null):
		damageRange = item.getDamageRange()
		item.useCharge()
	
	var texts = [
		"{attacker.name} hurls a Nano Brick at {receiver.name}'s head. What a high-tech assault!",
	]
	var text = RNG.pick(texts)

	if(checkMissed(_attacker, _receiver, DamageType.Physical)):
		text = "{attacker.name} throws a Nano Brick but accidentally misses the intended target. The Brick veers off course but follows an unexpected trajectory through the air, ultimately striking {receiver.name}'s head."
	
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		text = "{receiver.name} tries to dodge {attacker.name}'s Nano Brick, but it follows an unexpected path through the air and strikes {receiver.name}'s head."
	
	return {
		text = text,
		pain = RNG.randi_range(damageRange[0], damageRange[1]),
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return itemExists(_context)

func getAttackSoloAnimation():
	return "shove"

func getExperience():
	return [[Skill.Combat, 5]]

func getRecieverArmorScaling(_attacker, _receiver, _damageType) -> float:
	return 0.5

func getAttackerDamageMultiplierEfficiency(_attacker, _receiver, _damageType) -> float:
	return 0.1

func getRequirements():
	return [AttackRequirement.FreeArms, AttackRequirement.FreeHands]
