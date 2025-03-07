class_name ScarletBoss
extends Boss

@onready var states: Node = $States
@onready var fire_rate_timer: Timer = %FireRateTimer
@onready var move_side_state: TimedStateComponent = %MoveSideState
@onready var pause_state: TimedStateComponent = %PauseState
@onready var projectile_spawner_component: SpawnerComponent = %ProjectileSpawnerComponent
@onready var center_muzzle: Marker2D = $CenterMuzzle
@onready var projectile_eye: SpawnerComponent = %ProjectileEye

@onready var healthbar: ProgressBar = $CanvasLayer/Healthbar
@onready var stats_component: StatsComponent = $StatsComponent
@onready var laser_audio: VariablePitchAudioStreamPlayer = $LaserAudio
@onready var fire_eye_rate: Timer = %FireEyeRate
@onready var eye_audio: VariablePitchAudioStreamPlayer = $EyeAudio


func _ready() -> void:
	super()
	healthbar.init_health(stats_component.health)
	# Conecta las señales del componente StatsComponent
	stats_component.health_changed.connect(_on_health_changed)
	for state in states.get_children():
		state = state as StateComponent
		state.disable()
		
	move_side_component.velocity.x = [-90,90].pick_random()
	# Habilitar disparo
	fire_rate_timer.timeout.connect(fire_lasers)
	fire_eye_rate.timeout.connect(fire_eye)
	move_side_state.state_finished.connect(pause_state.enable)
	pause_state.state_finished.connect(move_side_state.enable)
	# Iniciar el primer estado
	move_side_state.enable()

# Disparo constante usando el temporizador
func fire_lasers() -> void:
	laser_audio.play_with_variance()
	projectile_spawner_component.spawn(center_muzzle.global_position)
	
func fire_eye() -> void:
	eye_audio.play_with_variance()
	projectile_eye.spawn(center_muzzle.global_position)
	
# Actualiza la barra de vida cuando cambia la salud
func _on_health_changed() -> void:
	healthbar._set_health(stats_component.health)
