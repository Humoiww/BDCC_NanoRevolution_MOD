extends PerkBase

func _init():
	id = "BetterExtration"
	skillGroup = "NanoENGR"

func getVisibleName():
	return "Better Extraction Skill"

func getVisibleDescription():
	return "After so much extraction, you just notice that you can actually extract more cores from a single android.\n" \
	+ "Effect: Now you can choose to extract more core in extraction. However, this extraction could be risky, the more you extract, the higher chance that you will loss everything during this extraction.\n" \
	+ "Generally, your success rate is high at first, but dramatically decrease at certain threshold, which is related to your Nano Engineering level."

func getRequiredPerks():
	return ["NanoExtration"]
	
func getSkillTier():
	return 1

func getPicture():
	return "res://Modules/NanoRevolution/Images/Perks/NanoBetterCorePerk.png"

