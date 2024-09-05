extends PerkBase

func _init():
	id = "NanoCraftingT2"
	skillGroup = "NanoENGR"

func getVisibleName():
	return "Nano Crafting Skill Tier 2 - nano medic"

func getVisibleDescription():
	return "So, you've heard that nano-androids can be used in the medical field, which inspire you to craft some medicine through nano cores.\n" \
	+ "Effect: Now you can upgrade the crafting station in your cell, letting you make some medical stuff. (Still, you need a blueprint set for this)"

func getSkillTier():
	return 0

func getPicture():
	return "res://Modules/NanoRevolution/Images/Perks/NanoCraftT2Perk.png"

