extends SkillBase

func _init():
	id = "NanoFunction"

func getVisibleName():
	return "Nano Instinct"

func getVisibleDescription():
	return "A skill set that you learn through your nano instinct."

func getPerkTiers():
	return [
		[0],
		[5],
		[10],
	]
