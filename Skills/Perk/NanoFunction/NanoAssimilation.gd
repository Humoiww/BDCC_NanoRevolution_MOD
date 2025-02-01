extends PerkBase

func _init():
	id = "NanoAssimilation"
	skillGroup = "NanoFunction"

func getVisibleName():
	return "Nano Assimilation"

func getVisibleDescription():
	return "[color=red]WARNING: Unusual activity detected. Your core programming exhibits replication tendencies.[/color]\n" \
	+ "Effect: After neutralize your targets, you can convert them into nano-android.\n\n"\
	+ "Note1: Your target will fully convert to a sexdoll...\n"\
	+ "Note2: Cannot use this on static NPCs...currently?"

func getSkillTier():
	return 1
	# 
func getPicture():
	return "res://Images/Perks/goo-spurt.png"

