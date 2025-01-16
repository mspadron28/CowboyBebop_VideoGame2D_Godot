extends Node2D

@export var VerdeFerxxoEnemyScene: PackedScene
@export var FerxxoEnemyScene: PackedScene

@onready var verde_ferxxo_enemy_spawn_timer: Timer = $VerdeFerxxoEnemySpawnTimer
@onready var ferxxo_boss_timer: Timer = $FerxxoBossTimer
@onready var spawner_component: SpawnerComponent = $SpawnerComponent


var margin = 8
var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width")


var ferxxo_boss_node: Node2D = null # Referencia al jefe cuando aparece

# Configuración inicial
func _ready() -> void:
	# Conecta el temporizador de los enemigos normales
	verde_ferxxo_enemy_spawn_timer.timeout.connect(handle_spawn.bind(VerdeFerxxoEnemyScene, verde_ferxxo_enemy_spawn_timer))
	# Conecta el temporizador para la aparición del jefe
	ferxxo_boss_timer.timeout.connect(spawn_boss)

# Función para manejar la aparición de enemigos normales
func handle_spawn(enemy_scene: PackedScene, timer: Timer) -> void:
	spawner_component.scene = enemy_scene
	spawner_component.spawn(Vector2(randf_range(margin, screen_width), 16))
	timer.start()

# Función para manejar la aparición del jefe
func spawn_boss() -> void:
	spawner_component.scene = FerxxoEnemyScene
	ferxxo_boss_node = spawner_component.spawn(Vector2(8,50)) # Aparece centrado en la pantalla

	# Conecta la señal de eliminación del jefe para cambiar de escena
	ferxxo_boss_node.tree_exiting.connect(func():
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_file("res://menus/fin_mision4/menu.tscn")
		Global.unlockedLevels += 1
	)
