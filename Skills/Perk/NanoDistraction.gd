extends PerkBase

func _init():
	id = "NanoDistraction"
	skillGroup = "NanoENGR"

func getVisibleName():
	return "Detection Error"

func getVisibleDescription():
	return "Attention is NOT all you need\n" \
	+ "Effect: You are able to temperarily paralyze the android system through your controller."

func getSkillTier():
	return 0

func getPicture():
	return "res://Modules/NanoRevolution/Images/Perks/NanoDistractPerk.png"

