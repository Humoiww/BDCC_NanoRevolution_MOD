extends PerkBase

func _init():
	id = "NanoCraftingT2"
	skillGroup = "NanoENGR"

func getVisibleName():
	return "Nano Crafting Skill Tier 2 - nano medic"

func getVisibleDescription():
	return "So, you've heard that nano-androids can be used in the medical field, which inspire you to craft some medicine through nano cores.\n" \
	+ "Effect: Now you can make some medical stuff. (Still, you need a blueprint set for this)"

func getRequiredPerks():
	return ["NanoCraftingT1"]

func getSkillTier():
	return 1

func getPicture():
	return "res://Modules/NanoRevolution/Images/Perks/NanoCraftT2Perk.png"

