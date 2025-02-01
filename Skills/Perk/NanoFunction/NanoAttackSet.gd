extends PerkBase

func _init():
	id = "NanoAttackSet"
	skillGroup = "NanoFunction"

func getVisibleName():
	return "Nano Attacks"

func getVisibleDescription():
	return "As you get familiar with your new body, we realize some basic attacks in your database. \n" \
	+ "Effect: Unlock several attacking movements, these movements will get more powerful when your Embrace Nano level increase."

func getSkillTier():
	return 0

func getPicture():
	return "res://Images/Items/generic/chip.png"

func addsAttacks():
	return ["NanoHeatGrenade","NanoLatexRegeneration","NanolLatexBarrage","NanoLatexSlam","NanoLatexStrike"]
