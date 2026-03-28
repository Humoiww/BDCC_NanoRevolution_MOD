# ThemeManager.gd
extends Node
class_name ThemeManager


# Change the entire UI theme to the given color (default: SkyBlue)
static func change_theme(panelcolor: Color = Color8(25, 25, 35)) -> void:
	var DEFAULT_PANEL_COLOR = Color8(53,34,93)
	# build a fresh Theme
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
	# t.set_color("font_color", "Control", txtcolor)
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
	# recolor_game_ui_panels(Color8(25, 25, 35))
	recolor_game_ui_panels(panelcolor)
	VisualServer.set_default_clear_color(Color.black)



static func recolor_game_ui_panels(bg_color: Color) -> void:
	var tree = Engine.get_main_loop() as SceneTree
	if tree == null:
		return

	var root = tree.get_root()
	if root == null:
		return

	var left_panel = root.find_node("LeftPanel", true, false)
	var right_panel = root.find_node("RightPanel", true, false)

	_recolor_panel_node(left_panel, bg_color)
	_recolor_panel_node(right_panel, bg_color)


static func _recolor_panel_node(panel_node, bg_color: Color) -> void:
	if panel_node == null:
		return

	if !(panel_node is Control):
		return

	var sb = panel_node.get_stylebox("panel")
	if sb == null:
		return

	var copy = sb.duplicate()
	if copy is StyleBoxFlat:
		copy.bg_color = bg_color
		panel_node.add_stylebox_override("panel", copy)


static func _apply_theme_recursively(node: Node, theme: Theme) -> void:
	if node is Control:
		node.theme = theme
	for child in node.get_children():
		if child is Node:
			_apply_theme_recursively(child, theme)
