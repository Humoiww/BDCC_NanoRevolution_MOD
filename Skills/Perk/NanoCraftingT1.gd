extends PerkBase

func _init():
	id = "NanoCraftingT1"
	skillGroup = "NanoENGR"

func getVisibleName():
	return "Nano Crafting Skill Tier 1"

func getVisibleDescription():
	return "So, you just notice that this core is easy to shape anything, which brings you an idea to build a crafting station in your cell.\n" \
	+ "Effect: Now you can make some basic stuff with your nano cores"

func getSkillTier():
	return 0

func getPicture():
	return "res://Modules/NanoRevolution/Images/Perks/NanoCraftT1Perk.png"

