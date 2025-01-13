extends ParallaxBackground


@onready var far_stars_layer: ParallaxLayer = %FarStarsLayer
@onready var close_stars_layer: ParallaxLayer = %CloseStarsLayer

func _process(delta: float) -> void:

	far_stars_layer.motion_offset.y += 5 * delta
	close_stars_layer.motion_offset.y += 20 * delta


func _on_salir_pressed() -> void:
	get_tree().quit()


func _on_iniciar_pressed() -> void:
	get_tree().change_scene_to_file("res://misiones/mission1/mission1.tscn")


func _on_continuar_m_1_pressed() -> void:
	get_tree().change_scene_to_file("res://misiones/mission2/mission2.tscn")


func _on_continuar_m_2_pressed() -> void:
	get_tree().change_scene_to_file("res://misiones/mission3/mission3.tscn")


func _on_continuar_m_3_pressed() -> void:
	get_tree().change_scene_to_file("res://misiones/mission4/mission4.tscn")


func _on_final_game_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/principal/menu.tscn")
