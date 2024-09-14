extends PerkBase

func _init():
	id = "NanoCallBackUp"
	skillGroup = "NanoENGR"

func getVisibleName():
	return "Calling Sex Doll"

func getVisibleDescription():
	return "Need a hand... or handjob? Call it!\n" \
	+ "Effect: Now you can use your controller to call your sexdoll to either have sex or help you fighting. \n Note: this function depend on your current situation."

func getRequiredPerks():
	return ["NanoSexMode"]


func getSkillTier():
	return 1

func getPicture():
	return "res://Images/StatusEffects/recruitment.png"

