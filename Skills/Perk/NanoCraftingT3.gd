extends PerkBase

func _init():
	id = "NanoCraftingT3"
	skillGroup = "NanoENGR"

func getVisibleName():
	return "Nano Crafting Skill Tier 3 - nano Controller Upgrade"

func getVisibleDescription():
	return "You profficient skill allow you to upgrade your controller using nano cores.\n" \
	+ "Effect: You can upgrade your controller in your cell, giving it more charge capacity.)"

func getRequiredPerks():
	return ["NanoCraftingT1"]

func getSkillTier():
	return 2

func getPicture():
	return "res://Modules/NanoRevolution/Images/Perks/NanoCraftT3Perk.png"

