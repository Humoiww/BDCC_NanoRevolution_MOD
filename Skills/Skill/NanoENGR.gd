extends SkillBase

func _init():
	id = "NanoENGR"

func getVisibleName():
	return "Nano Engineering"

func getVisibleDescription():
	return "Shows how skilled you can haddle with those nano android and stuffs"

func getPerkTiers():
	return [
		[0],
		[5],
		[10],
	]
