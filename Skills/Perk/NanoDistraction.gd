extends PerkBase

func _init():
	id = "NanoDistraction"
	skillGroup = "NanoENGR"

func getVisibleName():
	return "Detection Error"

func getVisibleDescription():
	return "Attention is NOT all you need\n" \
	+ "Effect: You just notice that these androids' AI are not that strong. Now you can simply distract them and escape."

func getSkillTier():
	return 0

func getPicture():
	return "res://Modules/NanoRevolution/Images/Perks/NanoDistractPerk.png"

