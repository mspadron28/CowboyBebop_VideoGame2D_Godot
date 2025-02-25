extends VideoStreamPlayer
@onready var video_stream_player: VideoStreamPlayer = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	video_stream_player.play()  # Inicia el video automáticamente

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://menus/extras/tutorial.tscn")
	
	# Si el video termina, cambia automáticamente de escena
	if not video_stream_player.is_playing():
		get_tree().change_scene_to_file("res://menus/extras/tutorial.tscn")
