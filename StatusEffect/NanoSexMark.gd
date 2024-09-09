extends StatusEffectBase

func _init():
	id = "NanoSexMark"
	isBattleOnly = false

	alwaysCheckedForNPCs = false
	alwaysCheckedForPlayer = false
	priorityDuringChecking = 90
	
func shouldApplyTo(_npc):
	#if(_npc.menstrualCycle != null && _npc.menstrualCycle.isVisiblyPregnant()):
	#	return true
	return false

func getEffectName():
	return "Sex Doll Mark"

func getEffectDesc():
	return "A symbol indicating "+character.getName()+" is under sex doll mode."

func getEffectImage():
	if(character.isPregnant()):
		return "res://Images/StatusEffects/WombMarkGlowing.png"
	
	return "res://Images/StatusEffects/WombMark.png"

func getIconColor():
	return IconColorDarkPurple

func getBuffs():
	return [
		buff(Buff.FertilityBuff, [200]),
		buff(Buff.CrossSpeciesCompatibilityBuff, [100]),
		buff(Buff.PregnancySpeedBuff, [100]),
	]
