extends SkillBase

func _init():
	id = "NanoFunct"

func getVisibleName():
	return "Embrace Nano"

func getVisibleDescription():
	return "A skill set that you learn through your nano instinct."

func getPerkTiers():
	return [
		[0],
		[5],
		[10],
	]
