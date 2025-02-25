extends Control

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://menus/extras/creditos/credits.tscn")

func _on_final_game_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/extras/creditos/credits.tscn")


func _on_salir_pressed() -> void:
	get_tree().quit()
