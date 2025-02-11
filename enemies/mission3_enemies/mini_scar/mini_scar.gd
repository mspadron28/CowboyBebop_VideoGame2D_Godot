extends EnemyFire

@onready var fire_sound: VariablePitchAudioStreamPlayer = $Fire_Sound

func _ready() -> void:
	super()
		
	for state in states.get_children():
		state = state as StateComponent
		state.disable()
		
	move_side_component.velocity.x = [-120,120].pick_random()
	# Habilitar disparo
	fire_rate_timer.timeout.connect(fire_lasers)
	move_down_state.state_finished.connect(move_side_state.enable)
	move_side_state.state_finished.connect(pause_state.enable)
	
	pause_state.state_finished.connect(move_down_state.enable)
	# Iniciar el primer estado
	move_down_state.enable()


# Disparo constante usando el temporizador
func fire_lasers() -> void:
	fire_sound.play_with_variance()
	projectile_spawner_component.spawn(center_muzzle.global_position)
