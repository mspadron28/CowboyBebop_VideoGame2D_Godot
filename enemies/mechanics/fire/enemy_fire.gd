class_name EnemyFire
extends Node2D

@onready var stats_component: StatsComponent = $StatsComponent
@onready var flash_component: FlashComponent = $FlashComponent
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready var hitbox_component: HitboxComponent = $HitboxComponent
@onready var shake_component: ShakeComponent = $ShakeComponent
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var destroyed_component: DestroyedComponent = $DestroyedComponent
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

#ESTADOS
@onready var states: Node = $States
@onready var move_side_state: TimedStateComponent = %MoveSideState
@onready var move_side_component: MoveComponent = %MoveSideComponent
@onready var move_down_state: TimedStateComponent = %MoveDownState
@onready var fire_rate_timer: Timer = %FireRateTimer
@onready var pause_state: TimedStateComponent = %PauseState
@onready var projectile_spawner_component: SpawnerComponent = %ProjectileSpawnerComponent
@onready var center_muzzle: Marker2D = $CenterMuzzle
#MUSICA
@onready var variable_pitch_audio_stream_player: VariablePitchAudioStreamPlayer = $VariablePitchAudioStreamPlayer


func _ready() -> void:
	
	visible_on_screen_notifier_2d.screen_exited.connect(queue_free)
	hurtbox_component.hurt.connect(func(hitbox: HitboxComponent):
		flash_component.flash()
		shake_component.tween_shake()
		variable_pitch_audio_stream_player.play_with_variance()
	)
	stats_component.no_health.connect(queue_free)
	hitbox_component.hit_hurtbox.connect(destroyed_component.destroy.unbind(1))

func _process(delta: float) -> void:
	animate_the_ship()

func animate_the_ship() -> void:
	if move_side_component.velocity.x < 0:
		animated_sprite_2d.play("bank_left")
	elif move_side_component.velocity.x > 0:
		animated_sprite_2d.play("bank_right")
	else:
		animated_sprite_2d.play("center")
