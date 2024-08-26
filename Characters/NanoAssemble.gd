extends Character

func _init():
	id = "NanoSystem"

	npcCharacterType = CharacterType.Generic
	disableSerialization = true
	
func _getName():
	return "NanoSystem"

func getGender():
	return Gender.Other
	
func getSmallDescription() -> String:
	return "Alex's beta assembling line system."

func getSpecies():
	return [Species.Unknown]
	
func getThickness() -> int:
	return 50

func getFemininity() -> int:
	return 50

func createBodyparts():
	pass

func getDefaultEquipment():
	return ["AlexExoskeleton"]
