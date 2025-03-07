class_name Tita
extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var move_component: MoveComponent = $MoveComponent
@onready var spawner_component: SpawnerComponent = $SpawnerComponent
@onready var fire_rate_timer: Timer = $FireRateTimer
@onready var scale_component: ScaleComponent = $ScaleComponent
@onready var center_muzzle: Marker2D = $CenterMuzzle
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready var flash_component: FlashComponent = $FlashComponent
@onready var shake_component: ShakeComponent = $ShakeComponent
# Para los corazones
@onready var stats_component: StatsComponent = $StatsComponent
@onready var life_node: Control = $CanvasLayer/Life
@onready var bebop_fire: VariablePitchAudioStreamPlayer = $BebopFire

func _ready() -> void:
	# Conecta los cambios de salud con la actualización de los corazones
	stats_component.health_changed.connect(update_hearts)
	# Inicializa los corazones según la salud máxima
	update_hearts()
	fire_rate_timer.timeout.connect(fire_lasers)
	hurtbox_component.hurt.connect(func(hitbox: HitboxComponent):
		scale_component.tween_scale()
		flash_component.flash()
		shake_component.tween_shake()
	)

func fire_lasers() -> void:
	animated_sprite_2d.play("shoot")  # Reproduce la animación de disparo
	bebop_fire.play_with_variance()
	spawner_component.spawn(center_muzzle.global_position)
	scale_component.tween_scale()

func _process(delta: float) -> void:
	animate_the_ship()

func animate_the_ship() -> void:
	if animated_sprite_2d.animation != "shoot": 
		if move_component.velocity.x < 0:
			animated_sprite_2d.play("bank_left")
		elif move_component.velocity.x > 0:
			animated_sprite_2d.play("bank_right")
		else:
			animated_sprite_2d.play("center")

# Actualiza la visualización de los corazones
func update_hearts() -> void:
	var current_health = stats_component.health
	life_node.on_player_life_changed(current_health)

func heal(amount: int) -> void:
	stats_component.health += amount
	update_hearts()
