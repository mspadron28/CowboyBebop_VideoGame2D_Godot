extends Boss

@onready var states: Node = $States
@onready var move_side_state: TimedStateComponent = %MoveSideState
@onready var pause_state: TimedStateComponent = %PauseState
@onready var fire_rate_timer: Timer = %FireRateTimer
@onready var center_muzzle: Marker2D = $CenterMuzzle
@onready var projectile_spawner_component: SpawnerComponent = %ProjectileSpawnerComponent
@onready var stats_component: StatsComponent = $StatsComponent
@onready var healthbar: ProgressBar = $CanvasLayer/Healthbar

@onready var projectile_wow: SpawnerComponent = %ProjectileWow
@onready var fire_wow_rate: Timer = %FireWowRate
@onready var laser_audio: VariablePitchAudioStreamPlayer = $LaserAudio
@onready var wo_w_audio: VariablePitchAudioStreamPlayer = $WoWAudio


func _ready() -> void:
	super()
	healthbar.init_health(stats_component.health)
	# Conecta las señales del componente StatsComponent
	stats_component.health_changed.connect(_on_health_changed)
	for state in states.get_children():
		state = state as StateComponent
		state.disable()
		
	move_side_component.velocity.x = [-50,50].pick_random()
	# Habilitar disparo
	fire_rate_timer.timeout.connect(fire_lasers)
	fire_wow_rate.timeout.connect(fire_wow)
	move_side_state.state_finished.connect(pause_state.enable)
	pause_state.state_finished.connect(move_side_state.enable)
	# Iniciar el primer estado
	move_side_state.enable()

# Disparo constante usando el temporizador
func fire_lasers() -> void:
	laser_audio.play_with_variance()
	projectile_spawner_component.spawn(center_muzzle.global_position)
	
func fire_wow() -> void:
	wo_w_audio.play_with_variance()
	projectile_wow.spawn(center_muzzle.global_position)
	
# Actualiza la barra de vida cuando cambia la salud
func _on_health_changed() -> void:
	healthbar._set_health(stats_component.health)
