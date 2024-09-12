extends StatusEffectBase

func _init():
	id = "NanoSexMark"
	isBattleOnly = false

func getEffectName():
	return "Sex Doll Mark"

func getEffectDesc():
	return "A symbol indicating "+character.getName()+" is under sex doll mode."

func getEffectImage():
	
	return "res://Images/StatusEffects/WombMark.png"

func getIconColor():
	return IconColorDarkPurple

func getBuffs():
	return [
		buff(Buff.ForcedObedienceBuff, [200]),
	]
