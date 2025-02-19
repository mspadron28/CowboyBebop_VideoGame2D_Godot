extends Node2D

@export var BebopScene: PackedScene
@export var TitaScene: PackedScene

var current_player: Node2D
var bebop: Node2D
var tita: Node2D
var tita_alive: bool = true

func _ready() -> void:
	# Instanciar los personajes desde las escenas exportadas
	bebop = BebopScene.instantiate()
	tita = TitaScene.instantiate()
	add_child(bebop)
	add_child(tita)

	# Inicialmente, Bebop es el personaje activo
	current_player = bebop
	tita.visible = false  # Oculta a Tita al inicio
	tita.set_physics_process(false)  # Deshabilita el procesamiento de física de Tita al inicio
	tita.set_process_input(false)  # Deshabilita la entrada de Tita
	tita.set_process(false)  # Deshabilita cualquier otro proceso de Tita
	tita.get_node("CanvasLayer").visible = false  # Oculta el HUD de Tita al inicio
	tita.get_node("HurtboxComponent").set_deferred("monitorable", false)  # Deshabilita la hurtbox de Tita al inicio
	tita.get_node("HurtboxComponent").set_deferred("monitoring", false)

	# Deshabilita el disparo de Tita al inicio
	var tita_fire_timer = tita.get_node("FireRateTimer")
	if tita_fire_timer:
		tita_fire_timer.stop()

	bebop.tree_exiting.connect(func():
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_file("res://menus/game_over.tscn")
	)

	# Conectar el evento de salud de Tita para cambiar automáticamente a Bebop si Tita muere
	var tita_stats = tita.get_node("StatsComponent")
	tita_stats.health_changed.connect(func():
		if tita_stats.health <= 0:
			tita_alive = false
			switch_character(bebop)
	)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_up") and tita_alive:
		switch_character(tita)
	elif Input.is_action_just_pressed("ui_down"):
		switch_character(bebop)

func switch_character(new_player: Node2D) -> void:
	if new_player != current_player and new_player != null:
		current_player.visible = false  # Oculta el personaje actual
		current_player.set_physics_process(false)  # Deshabilita el procesamiento de física
		current_player.set_process_input(false)  # Deshabilita la entrada
		current_player.set_process(false)  # Deshabilita cualquier otro proceso
		current_player.get_node("CanvasLayer").visible = false  # Oculta el HUD del personaje actual
		current_player.get_node("HurtboxComponent").set_deferred("monitorable", false)  # Deshabilita la hurtbox del personaje anterior
		current_player.get_node("HurtboxComponent").set_deferred("monitoring", false)

		# Deshabilita el disparo del personaje anterior
		var current_fire_timer = current_player.get_node("FireRateTimer")
		if current_fire_timer:
			current_fire_timer.stop()

		new_player.visible = true  # Muestra el nuevo personaje
		new_player.set_physics_process(true)  # Habilita el procesamiento de física
		new_player.set_process_input(true)  # Habilita la entrada
		new_player.set_process(true)  # Habilita cualquier otro proceso
		new_player.position = current_player.position  # Mantiene la posición actual
		new_player.get_node("CanvasLayer").visible = true  # Muestra el HUD del nuevo personaje
		new_player.get_node("HurtboxComponent").set_deferred("monitorable", true)  # Habilita la hurtbox del nuevo personaje
		new_player.get_node("HurtboxComponent").set_deferred("monitoring", true)

		# Habilita el disparo del nuevo personaje
		var new_fire_timer = new_player.get_node("FireRateTimer")
		if new_fire_timer:
			new_fire_timer.start()

		current_player = new_player  # Cambia la referencia del personaje activo


func _on_retornar_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/principal/menu.tscn")
