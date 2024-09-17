extends PerkBase

func _init():
	id = "NanoExtration"
	skillGroup = "NanoENGR"

func getVisibleName():
	return "Nano Extraction Skill"

func getVisibleDescription():
	return "So, these nano android should be drived by something right? Let's see if we can get something from their body.\n" \
	+ "Effect: Now you can extract nano android's cores after defeating them." 



func getSkillTier():
	return 0

func getPicture():
	return "res://Modules/NanoRevolution/Images/Perks/NanoCorePerk.png"

