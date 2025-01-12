extends Node2D


@onready var bebop: Node2D = $Bebop

func _ready() -> void:
	bebop.tree_exiting.connect(func():
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_file("res://menus/game_over.tscn")
	)
