extends Node2D

@onready var move_component: MoveComponent = $MoveComponent
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var flash_component: FlashComponent = $FlashComponent
@onready var shake_component: ShakeComponent = $ShakeComponent
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready var hitbox_component: HitboxComponent = $HitboxComponent
@onready var destroyed_component: DestroyedComponent = $DestroyedComponent
@onready var stats_component: StatsComponent = $StatsComponent
#Para los estados
@onready var states: Node = $States
@onready var move_side_state: TimedStateComponent = %MoveSideState
@onready var move_down_state: TimedStateComponent = %MoveDownState
@onready var move_side_component: MoveComponent = %MoveSideComponent
@onready var pause_state: TimedStateComponent = %PauseState


func _ready() -> void:
	visible_on_screen_notifier_2d.screen_exited.connect(queue_free)
	hurtbox_component.hurt.connect(func(hitbox: HitboxComponent):
		flash_component.flash()
		shake_component.tween_shake()
	)
	stats_component.no_health.connect(queue_free)
	hitbox_component.hit_hurtbox.connect(destroyed_component.destroy.unbind(1))
	#Para los estados
	for state in states.get_children():
		state = state as StateComponent
		state.disable()
		
	move_side_component.velocity.x = [-100,100].pick_random()
	# Habilitar disparo
	move_down_state.state_finished.connect(move_side_state.enable)
	move_side_state.state_finished.connect(move_down_state.enable)
	
	#pause_state.state_finished.connect(move_down_state.enable)
	# Iniciar el primer estado
	move_down_state.enable()
	
	
