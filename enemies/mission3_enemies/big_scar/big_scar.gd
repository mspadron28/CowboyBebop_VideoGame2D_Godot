extends EnemyFire

@onready var fire_sound: VariablePitchAudioStreamPlayer = $Fire_Sound
@onready var projectile_wide_muzzle: SpawnerComponent = $ProjectileWideMuzzle
@onready var projectile_muzzle: SpawnerComponent = $ProjectileMuzzle
@onready var wide_muzzle_left: Marker2D = $WideMuzzleLeft
@onready var wide_muzzle_right: Marker2D = $WideMuzzleRight
@onready var muzzle_left: Marker2D = $MuzzleLeft
@onready var muzzle_right: Marker2D = $MuzzleRight
@onready var fire_rate_timer_wide: Timer = $FireRateTimerWide
@onready var fire_rate_timer_muzzle: Timer = $FireRateTimerMuzzle

func _ready() -> void:
	super()
		
	for state in states.get_children():
		state = state as StateComponent
		state.disable()
		
	move_side_component.velocity.x = [-80,80].pick_random()
	# Habilitar disparo
	fire_rate_timer.timeout.connect(fire_lasers)
	fire_rate_timer_wide.timeout.connect(fire_wide_lasers)
	fire_rate_timer_muzzle.timeout.connect(fire_muzzle_lasers)
	
	
	move_down_state.state_finished.connect(move_side_state.enable)
	move_side_state.state_finished.connect(pause_state.enable)
	
	pause_state.state_finished.connect(move_down_state.enable)
	# Iniciar el primer estado
	move_down_state.enable()


# Disparo constante usando el temporizador
func fire_lasers() -> void:
	fire_sound.play_with_variance()
	projectile_spawner_component.spawn(center_muzzle.global_position)
	
# Disparo constante usando el temporizador
func fire_wide_lasers() -> void:
	fire_sound.play_with_variance()
	projectile_wide_muzzle.spawn(wide_muzzle_left.global_position)
	projectile_wide_muzzle.spawn(wide_muzzle_right.global_position)

# Disparo constante usando el temporizador
func fire_muzzle_lasers() -> void:
	fire_sound.play_with_variance()
	projectile_muzzle.spawn(muzzle_left.global_position)
	projectile_muzzle.spawn(muzzle_right.global_position)
