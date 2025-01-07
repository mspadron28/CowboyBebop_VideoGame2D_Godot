class_name Boss
extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var flash_component: FlashComponent = $FlashComponent
@onready var shake_component: ShakeComponent = $ShakeComponent
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready var move_side_component: MoveComponent = %MoveSideComponent

func _ready() -> void:
	hurtbox_component.hurt.connect(func(hitbox: HitboxComponent):
		flash_component.flash()
		shake_component.tween_shake()
	)

func _process(delta: float) -> void:
	animate_the_ship()

func animate_the_ship() -> void:
	if move_side_component.velocity.x < 0:
		animated_sprite_2d.play("bank_right")
	elif move_side_component.velocity.x > 0:
		animated_sprite_2d.play("bank_left")
	else:
		animated_sprite_2d.play("center")
