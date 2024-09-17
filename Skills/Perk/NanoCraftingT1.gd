extends PerkBase

func _init():
	id = "NanoCraftingT1"
	skillGroup = "NanoENGR"

func getVisibleName():
	return "Nano Crafting Skill Tier 1"

func getVisibleDescription():
	return "So, you just notice that this core is easy to shape anything, which brings you an idea to build a crafting station in your cell.\n" \
	+ "Effect: Now you can unlock the crafting station in your cell. (However, crafting from scratch is really tough. You’ll need to ask someone to get the blueprint for these.) \n\n" \
	+ "Hint: For now, you can interact with two characters who are well-versed in this. Maybe ask them for help?\n" \
	+ "Extra Hint: In current version, only humoi can offer you blueprint, so yeah, go and ask her."

func getSkillTier():
	return 0

func getPicture():
	return "res://Modules/NanoRevolution/Images/Perks/NanoCraftT1Perk.png"

