extends ProgressBar

@onready var damage_bar: ProgressBar = $DamageBar
@onready var timer: Timer = $Timer

var health = 0 : set = _set_health

func _set_health(new_health):
	var prev_health = health
	health = min(max_value, new_health)
	value = health
	#Cuando es atacado
	if health <= 0:
		queue_free()
	
	if health < prev_health:
		timer.start()
	else: #Cuando es curado
		damage_bar.value = health
	
	

func init_health(_health):
	health = _health
	max_value = health
	value = health
	damage_bar.max_value = health
	damage_bar.value = health

#Cuando se acabe el timer la barra de daño toma el valor de la barra de vida
func _on_timer_timeout() -> void:
	damage_bar.value = health
