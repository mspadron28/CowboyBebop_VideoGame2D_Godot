extends Node2D

@export var heal_amount: int = 1  # Cantidad de vida que restaura el ítem
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

func _ready() -> void:
	visible_on_screen_notifier_2d.screen_exited.connect(queue_free)

func _on_area_2d_area_entered(area: Area2D) -> void:
	var player = area.get_parent()
	if player is Bebop:
		player.heal(heal_amount)
		queue_free()
