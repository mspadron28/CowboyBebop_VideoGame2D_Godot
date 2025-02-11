extends "res://enemies/mechanics/movements/enemy_mv.gd"

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	super()


func _process(delta: float) -> void:
	animate_the_ship()

func animate_the_ship() -> void:
	if move_side_component.velocity.x < 0:
		animated_sprite_2d.play("bank_left")
	elif move_side_component.velocity.x > 0:
		animated_sprite_2d.play("bank_right")
	else:
		animated_sprite_2d.play("center")
