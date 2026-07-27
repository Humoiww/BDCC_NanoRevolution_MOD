extends SceneBase

const MODULE_ID = "NanoRevolutionModule"

func _init():
	sceneID = "NanoTransformPCScene"

func _run():
	if state == "":
		saynn("You feel a strange sensation coursing through your veins. The black goo on your skin begins to pulse with a faint light, and your vision blurs for a moment.")
		saynn("Something is... wrong. Or maybe, something is finally becoming right.")
		addButton("Weird", "What is happening to me?", "transforming")
		
	elif state == "transforming":
		var module = GlobalRegistry.getModule(MODULE_ID)
		if module != null:
			module.transformCharToNano(GM.pc.getID())
		GM.pc.addEffect("NanoSexMark")
		saynn("Your body convulses. The world dissolves into a sea of static and data streams. Your flesh and bones are rewritten, your consciousness rebooted into a new, synthetic shell.")
		saynn("You are no longer what you were. You are... more.")
		saynn("You are a Nano Android.")
		addButton("Continue", "Embrace the new self.", "end_scene")

func _react(_action, _args):
	if _action == "end_scene":
		endScene()
		return
	
	setState(_action)
