extends SceneBase
class_name NanoFeelWrongScene

func _init():
	sceneID = "NanoFeelWrongScene"

func _initScene(_args = []):
	setState("init")

func _run():
	if state == "init":
		playAnimation(StageScene.TFLook, "head")
		saynn("You feel a strange sensation coursing through your veins. A dull ache spreads from your core, and your thoughts feel... fuzzy, as if they're not entirely your own.")
		saynn("A wave of dizziness washes over you, and you have to lean against a wall to steady yourself. What's happening to you?")
		saynn("Something is definitely wrong. Maybe that quirky liliac, Humoi, would know something about this. It might be a good idea to pay them a visit when you have time.")
		addButton("Continue", "It's probably nothing... for now.", "end_scene")

func _react(_action, _args):
	if _action == "end_scene":
		endScene()
		return
	
	setState(_action)
	return true
