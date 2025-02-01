extends PerkBase

func _init():
	id = "NanoEdit"
	skillGroup = "NanoFunction"

func getVisibleName():
	return "Nano Edit"

func getVisibleDescription():
	return "You are made with nano robot, of course you can freely change your body \n" \
	+ "Effect: You can change your body through your Nano Controller"

func getSkillTier():
	return 0
	# Images/Perks/goo-spurt.png
func getPicture():
	return "res://Images/StatusEffects/mask.png"

