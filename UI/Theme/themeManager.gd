# ThemeManager.gd
extends Node
class_name ThemeManager

# Change the entire UI theme to the given color (default: SkyBlue)
func change_theme(color: Color = Color8(135, 206, 235)) -> void:
	# build a fresh Theme
	var t = Theme.new()
	t.set_color("font_color", "Control", color)
	
	var panel_style = StyleBoxFlat.new()
	panel_style.bg_color = color
	t.set_stylebox("panel", "Panel", panel_style)
	
	var btn_style = StyleBoxFlat.new()
	btn_style.bg_color = color
	t.set_stylebox("normal", "Button", btn_style)
	
	# apply it to the root Control of your scene
	var root_vp = get_tree().get_root()
	if root_vp.get_child_count() > 0:
		var scene_root = root_vp.get_child(0)
		if scene_root is Control:
			scene_root.theme = t
			return
	push_error("ThemeManager: could not find a Control root to theme.")
