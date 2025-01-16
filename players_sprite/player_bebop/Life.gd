extends Control

@export var heart_texture: Texture2D
@export var heart_size: Vector2 = Vector2(40, 40)

func on_player_life_changed(player_hearts: int) -> void:
	# Elimina todos los nodos actuales
	clear_hearts()
	
	# Genera un nodo por cada corazón
	for i in range(player_hearts):
		var heart = TextureRect.new()
		heart.texture = heart_texture
		heart.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED  # Mantén la relación de aspecto
		heart.size_flags_horizontal = Control.SIZE_FILL
		heart.size_flags_vertical = Control.SIZE_FILL
		heart.scale = heart_size / heart_texture.get_size()  # Ajusta el tamaño del corazón
		heart.position = Vector2(i * heart_size.x, 0)  # Posición horizontal en fila
		add_child(heart)

# Limpia todos los nodos hijos
func clear_hearts() -> void:
	for child in get_children():
		child.queue_free()


func _on_retornar_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/principal/menu.tscn")
