extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("Fade_in")
	await get_tree().create_timer(3).timeout
	animation_player.play("Fade_out")
	await get_tree().create_timer(3).timeout
	animation_player.play("credits_info")
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://menus/principal/menu.tscn")
