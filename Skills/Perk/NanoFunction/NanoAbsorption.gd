extends PerkBase

func _init():
	id = "NanoAbsorption"
	skillGroup = "NanoFunction"

func getVisibleName():
	return "Nano Absorb"

func getVisibleDescription():
	return "These androids contain valuable data. Absorbing their essence may enhance your capabilities. \n" \
	+ "Effect: Unlock absorb move after defeat an nano android."

func getSkillTier():
	return 0
	# Images/Perks/goo-spurt.png
func getPicture():
	return "res://Images/Perks/biceps.png"

