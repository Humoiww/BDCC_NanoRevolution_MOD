extends PerkBase

func _init():
	id = "NanoSexMode"
	skillGroup = "NanoENGR"

func getVisibleName():
	return "Sex Mode"

func getVisibleDescription():
	return "Hum, I wonder what how this trigger works...\n" \
	+ "Effect: Now you can trigger nano android's sex module after defeating them."

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Perks/nested-hearts2.png"

