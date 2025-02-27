extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("fade_in_1")
	await get_tree().create_timer(5).timeout
	animation_player.play("fade_out_1")
	await get_tree().create_timer(3).timeout
	animation_player.play("fade_in_2")
	await get_tree().create_timer(7).timeout
	animation_player.play("fade_out_2")
	await get_tree().create_timer(3).timeout
	animation_player.play("fade_in_3")
	await get_tree().create_timer(7).timeout
	animation_player.play("fade_out_3")
	await get_tree().create_timer(3).timeout
	animation_player.play("fade_in_4")
	await get_tree().create_timer(7).timeout
	animation_player.play("fade_out_4")
	await get_tree().create_timer(3).timeout
	animation_player.play("fade_in_5")
	await get_tree().create_timer(7).timeout
	animation_player.play("fade_out_5")
	await get_tree().create_timer(3).timeout
	animation_player.play("fade_in_6")
	await get_tree().create_timer(7).timeout
	animation_player.play("fade_out_6")
	await get_tree().create_timer(3).timeout
	animation_player.play("fade_in_7")
	await get_tree().create_timer(7).timeout
	animation_player.play("fade_out_7")
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://menus/principal/menu.tscn")
