extends Node2D

@onready var credits_container = $CreditsContainer
@export var scroll_speed: float = 50.0  # Velocidad de desplazamiento en píxeles por segundo
@export var screen_height: float = 720.0  # Altura de la pantalla (ajústala según tu resolución)

var total_height: float = 0.0  # Altura total de los créditos

func _ready():
	# Calcular la altura total del contenido para saber cuándo detener el desplazamiento
	for child in credits_container.get_children():
		if child is Label:
			total_height = max(total_height, child.offset_bottom)
		elif child is Sprite2D:
			total_height = max(total_height, child.position.y + (child.texture.get_height() * child.scale.y / 2))
	
	# Asegurarse de que el contenedor empiece fuera de la pantalla
	credits_container.position.y = screen_height

func _process(delta):
	# Mover el contenedor hacia arriba
	credits_container.position.y -= scroll_speed * delta
	
	# Si todo el contenido ha salido de la pantalla, opcionalmente reiniciar o terminar
	if credits_container.position.y < -total_height:
		# Opcional: Reiniciar los créditos
		credits_container.position.y = screen_height
		# Opcional: Cambiar de escena o detener
		# get_tree().change_scene_to_file("res://menus/main_menu.tscn")

func _input(event):
	# Opcional: Saltar los créditos con una tecla (ejemplo: Escape)
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://menus/main_menu.tscn")
