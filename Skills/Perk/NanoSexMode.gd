extends PerkBase

func _init():
	id = "NanoSexMode"
	skillGroup = "NanoENGR"

func getVisibleName():
	return "Introduction to Android Hacking."

func getVisibleDescription():
	return "So, you just notice that your controller can remotely communivate with the android terminal.\n" \
	+ "Effect: Unlock the \"Hack\" move during and after winning an android fight. (And yes, you can simply hack through the panel.)"

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Items/generic/chip.png"

func addsAttacks():
	return ["NanoHackPCAttack"]
