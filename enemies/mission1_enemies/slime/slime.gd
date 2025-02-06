extends Enemy
@onready var states: Node = $States

@onready var move_side_component: MoveComponent = %MoveSideComponent

@onready var move_side_state: TimedStateComponent = %MoveSideState
@onready var move_down_state: TimedStateComponent = %MoveDownState
@onready var pause_state: TimedStateComponent = %PauseState

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	move_side_component.velocity.x = [-50,50].pick_random()
	# Habilitar disparo
	move_down_state.state_finished.connect(move_side_state.enable)
	move_side_state.state_finished.connect(pause_state.enable)
	
	pause_state.state_finished.connect(move_down_state.enable)
	# Iniciar el primer estado
	move_down_state.enable()
