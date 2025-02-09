extends Node2D

@export var CactusEnemyScene: PackedScene
@export var HealthScene: PackedScene
@export var MiniDon: PackedScene
@export var MiniDima: PackedScene
@export var Cactus2EnemyScene: PackedScene
@export var DimadonEnemyScene: PackedScene
@export var StarEnemyScene: PackedScene
var margin = 8
var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width")

@onready var spawner_component: SpawnerComponent = %SpawnerComponent
@onready var cactus_enemy_spawn_timer: Timer = $CactusEnemySpawnTimer
@onready var star_enemy_spawn_timer: Timer = $StarEnemySpawnTimer
@onready var cactus_2_enemy_spawn_timer: Timer = $Cactus2EnemySpawnTimer
@onready var mini_don_timer: Timer = $MiniDonTimer
@onready var mini_dima_timer: Timer = $MiniDimaTimer
@onready var health_timer: Timer = $HealthTimer


@onready var dimadon_boss_timer: Timer = $DimadonBossTimer


var dimadon_boss_node: Node2D = null # Referencia al jefe cuando aparece

# Configuración inicial
func _ready() -> void:
	# Conecta el temporizador de los enemigos normales
	cactus_enemy_spawn_timer.timeout.connect(handle_spawn.bind(CactusEnemyScene, cactus_enemy_spawn_timer))
	star_enemy_spawn_timer.timeout.connect(handle_spawn.bind(StarEnemyScene, star_enemy_spawn_timer))
	cactus_2_enemy_spawn_timer.timeout.connect(handle_spawn.bind(Cactus2EnemyScene, cactus_2_enemy_spawn_timer))
	mini_don_timer.timeout.connect(handle_spawn.bind(MiniDon, mini_don_timer))
	mini_dima_timer.timeout.connect(handle_spawn.bind(MiniDima, mini_dima_timer))
	
	health_timer.timeout.connect(handle_spawn.bind(HealthScene, health_timer))
	# Conecta el temporizador para la aparición del jefe
	dimadon_boss_timer.timeout.connect(spawn_dimadon_boss)

# Función para manejar la aparición de enemigos normales
func handle_spawn(enemy_scene: PackedScene, timer: Timer) -> void:
	spawner_component.scene = enemy_scene
	spawner_component.spawn(Vector2(randf_range(margin, screen_width), 16))
	timer.start()

# Función para manejar la aparición del jefe
func spawn_dimadon_boss() -> void:
	spawner_component.scene = DimadonEnemyScene
	dimadon_boss_node = spawner_component.spawn(Vector2(8,50)) # Aparece centrado en la pantalla

	# Conecta la señal de eliminación del jefe para cambiar de escena
	dimadon_boss_node.tree_exiting.connect(func():
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_file("res://menus/fin_mision2/menu.tscn")
		Global.unlockedLevels += 1
	)
