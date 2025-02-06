extends Node2D
#Enemies
@export var CanEnemyScene: PackedScene
@export var MiniEnemyScene: PackedScene
@export var SlimeScene: PackedScene
#BOSS
@export var VaultEnemyScene: PackedScene

var margin = 8
var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width")
@onready var spawner_component: SpawnerComponent = $SpawnerComponent
@onready var can_enemy_spawn_timer: Timer = $CanEnemySpawnTimer
@onready var mini_nova_timer: Timer = $MiniNovaTimer
@onready var slime_timer: Timer = $SlimeTimer

#BOSS
@onready var vault_boss_timer: Timer = $VaultBossTimer
var vault_boss_node: Node2D = null # Referencia al jefe cuando aparece

# Configuración inicial
func _ready() -> void:
	# Conecta el temporizador de los enemigos normales
	can_enemy_spawn_timer.timeout.connect(handle_spawn.bind(CanEnemyScene, can_enemy_spawn_timer))
	mini_nova_timer.timeout.connect(handle_spawn.bind(MiniEnemyScene, mini_nova_timer))
	slime_timer.timeout.connect(handle_spawn.bind(SlimeScene, slime_timer))
	# Conecta el temporizador para la aparición del jefe
	vault_boss_timer.timeout.connect(spawn_boss)

# Función para manejar la aparición de enemigos normales
func handle_spawn(enemy_scene: PackedScene, timer: Timer) -> void:
	spawner_component.scene = enemy_scene
	spawner_component.spawn(Vector2(randf_range(margin, screen_width), 16))
	timer.start()

# Función para manejar la aparición del jefe
func spawn_boss() -> void:
	spawner_component.scene = VaultEnemyScene
	vault_boss_node = spawner_component.spawn(Vector2(8,50)) # Aparece centrado en la pantalla

	# Conecta la señal de eliminación del jefe para cambiar de escena
	vault_boss_node.tree_exiting.connect(func():
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_file("res://menus/fin_mision1/menu.tscn")
		Global.unlockedLevels += 1
	)
