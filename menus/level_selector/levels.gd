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



func _on__pressed() -> void:
	get_tree().change_scene_to_file("res://misiones/mission1/mission1.tscn")
