extends Control


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://menus/level_selector/levels.tscn")



func _on_continuar_m_1_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/level_selector/levels.tscn")


func _on_retornar_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/principal/menu.tscn")
