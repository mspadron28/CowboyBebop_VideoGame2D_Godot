extends Enemy


@onready var move_side_component: MoveComponent = %MoveSideComponent
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@onready var states: Node = $States
@onready var move_side_state: TimedStateComponent = %MoveSideState
@onready var pause_state: TimedStateComponent = %PauseState
@onready var fire_rate_timer: Timer = %FireRateTimer
@onready var projectile_spawner_component: SpawnerComponent = %ProjectileSpawnerComponent
@onready var center_muzzle: Marker2D = $CenterMuzzle
@onready var move_down_state: TimedStateComponent = %MoveDownState



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	for state in states.get_children():
		state = state as StateComponent
		state.disable()
		
	move_side_component.velocity.x = [-50,50].pick_random()
	# Habilitar disparo
	fire_rate_timer.timeout.connect(fire_lasers)
	move_down_state.state_finished.connect(move_side_state.enable)
	move_side_state.state_finished.connect(pause_state.enable)
	
	pause_state.state_finished.connect(move_down_state.enable)
	# Iniciar el primer estado
	move_down_state.enable()

# Disparo constante usando el temporizador
func fire_lasers() -> void:
	projectile_spawner_component.spawn(center_muzzle.global_position)
	
func _process(delta: float) -> void:
	animate_the_ship()

func animate_the_ship() -> void:
	if move_side_component.velocity.x < 0:
		animated_sprite_2d.play("bank_left")
	elif move_side_component.velocity.x > 0:
		animated_sprite_2d.play("bank_right")
	else:
		animated_sprite_2d.play("center")
