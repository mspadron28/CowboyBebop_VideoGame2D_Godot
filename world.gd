extends Node2D

#@onready var ship: Node2D = $Ship
@onready var bebop: Node2D = $Bebop
#@onready var vault_boss: VaultBoss = $VaultBoss
#@onready var dimadon_boss: DimadonBoss = $DimadonBoss


func _ready() -> void:
	bebop.tree_exiting.connect(func():
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_file("res://menus/game_over.tscn")
	)
