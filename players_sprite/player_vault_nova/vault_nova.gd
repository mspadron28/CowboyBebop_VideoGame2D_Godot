extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var move_component: MoveComponent = $MoveComponent
@onready var fire_rate_timer: Timer = $FireRateTimer
@onready var spawner_component: SpawnerComponent = $SpawnerComponent
@onready var center_muzzle: Marker2D = $CenterMuzzle
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready var flash_component: FlashComponent = $FlashComponent
@onready var shake_component: ShakeComponent = $ShakeComponent


func _ready() -> void:
	fire_rate_timer.timeout.connect(fire_lasers)
	hurtbox_component.hurt.connect(func(hitbox: HitboxComponent):
		flash_component.flash()
		shake_component.tween_shake()
	)
func fire_lasers() -> void:
	spawner_component.spawn(center_muzzle.global_position)

func _process(delta: float) -> void:
	animate_the_ship()

func animate_the_ship() -> void:
	if move_component.velocity.x < 0:
		animated_sprite_2d.play("bank_right")
	elif move_component.velocity.x > 0:
		animated_sprite_2d.play("bank_left")
	else:
		animated_sprite_2d.play("center")
