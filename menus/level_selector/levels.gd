extends GridContainer

@onready var levels: GridContainer = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(levels.get_child_count()):
		Global.levels.append(i+1)
		
	for level in levels.get_children():
		if str_to_var(level.name) in range(Global.unlockedLevels+1):
			level.disabled = false
		else:
			level.disabled = true




func _on_retornar_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/principal/menu.tscn")


func _on__pressed1() -> void:
	get_tree().change_scene_to_file("res://misiones/mission1/mission1.tscn")


func _on__pressed2() -> void:
	get_tree().change_scene_to_file("res://misiones/mission2/mission2.tscn")


func _on__pressed3() -> void:
	get_tree().change_scene_to_file("res://misiones/mission3/mission3.tscn")


func _on__pressed4() -> void:
	get_tree().change_scene_to_file("res://misiones/mission4/mission4.tscn")


func _on_opciones_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/extras/settings/settings-menu.tscn")
