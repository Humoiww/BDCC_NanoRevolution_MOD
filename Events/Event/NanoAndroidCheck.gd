extends EventBase
var NanoGuardGenerator = preload("res://Modules/NanoRevolution/Characters/Dynamic/Generator/NanoGuardGenerator.gd")
var ThemeManager = preload("res://Modules/NanoRevolution/UI/Theme/themeManager.gd")

func _init():
	id = "NanoAndroidCheck"

func registerTriggers(es):
	es.addTrigger(self, Trigger.EnteringRoom)

func updateEverything():
	# update occurance
	var weighEvents = GM.ES.eventTriggers[Trigger.HighExposureInmateEvent]	
	for i in range(weighEvents.events.size()):
		# print("brute force load flag")
		if(weighEvents.events[i].id == "NanoExposureForceCheckEvent"):
			weighEvents.weights[i] = getModuleFlag("NanoRevolutionModule", "NanoAndroidGuardAppearWeight", 10)
	if getModuleFlag("NanoRevolutionModule", "NanoMeetHumoi", false):
		if (!getModuleFlag("NanoRevolutionModule", "NanoHasController",false)):
			addMessage("Hey! I just notice that you haven't got the nano controller yet, take this and have fun~")
			setModuleFlag("NanoRevolutionModule", "NanoHasController",true)
			GM.pc.getInventory().addItemID("NanoController")

	# will delete the effect disable transform?
	#var sexDollPool = GM.main.getDynamicCharacterIDsFromPool("SexDoll")
#	for androidID in sexDollPool:



func generateAndroidBaseCount(count):
	for _i in range(count):
		var idToUse = grabNpcIDFromPoolOrGenerate("NanoGuard", [], NanoGuardGenerator.new(), {NpcGen.Level: 1})
		# GlobalRegistry.getModule("NanoRevolutionModule").NIS.spawnPawn(idToUse)
		GM.main.IS.spawnPawn(idToUse)
			
func clockBasedAndroidSpawn():
	var count = 5
	var currentTime = GM.main.getTime()
	print(currentTime)
	if((currentTime >= 21600) and (!getModuleFlag("NanoRevolutionModule", "NanoIsGenerateThisMorning",false))):
		# Every morning, the system will generate 5 new/not new android based on account
		generateAndroidBaseCount(count)
		setModuleFlag("NanoRevolutionModule", "NanoIsGenerateThisMorning",true)
	


	

func run(_triggerID, _args):
	# saynn("Hello owo")
	# test even
	# so, a brute force way to keep the save
	updateEverything()
	# clockBasedAndroidSpawn()

	# addButton("DEBUG GEN","generate_android pawn????","generate_android")

	addButton("DEBUG THEME","switch current theme????","switch_scene")
	addButton("DEBUG CONTAMINATION", "Add 20 contamination to player", "add_contamination")
	addButton("DEBUG WALK", "Force walk to Humoi's cell", "force_walk")
	

func getPriority():
	return 1

func onButton(_method, _args):
	if(_method == "generate_android"):
		generateAndroidBaseCount(1)

	if(_method == "add_contamination"):
		var module = GlobalRegistry.getModule("NanoRevolutionModule")
		if module != null:
			module.addContamination(GM.pc, 20)
	
	if(_method == "force_walk"):
		GM.main.IS.startInteraction("ForceWalkToHumoiInteraction", {main = "pc"})
		# emit_signal("triggered")

	if(_method == "switch_scene"):
		var _u = 1

		ThemeManager.change_theme()
		# change_theme_to_skyblue() 
		# emit_signal("triggered")


func change_theme_to_skyblue() -> void:
	# 1) Build the SkyBlue theme
	var path = "res://GlobalTheme.tres"
	var base_theme = ResourceLoader.load(path)
	if base_theme == null:
		push_error("ThemeModule: Not found: " + path)
		return

	# 2) 深拷贝一份，以免改到磁盘上的资源 deeeeeeep copy!
	var t = base_theme.duplicate(true)
	# var sky = Color8(135, 206, 235)
	# # var t = Theme.new()
	t.set_color("font_color", "Control", Color.skyblue)
	# var panel_sb = StyleBoxFlat.new()
	# panel_sb.bg_color = sky
	# t.set_stylebox("panel", "Panel", panel_sb)
	# var btn_sb = StyleBoxFlat.new()
	# btn_sb.bg_color = sky
	# t.set_stylebox("normal", "Button", btn_sb)

	# 2) Grab the SceneTree and root viewport
	var tree = Engine.get_main_loop() as SceneTree
	var root_vp = tree.get_root()

	# 3) Recursively apply to every Control
	_apply_theme_recursively(root_vp, t)

	VisualServer.set_default_clear_color(Color.green)


func _apply_theme_recursively(node: Node, theme: Theme) -> void:
	if node is Control:
		node.theme = theme
	for child in node.get_children():
		if child is Node:
			_apply_theme_recursively(child, theme)
