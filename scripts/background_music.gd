extends AudioStreamPlayer
@onready var background_music: AudioStreamPlayer = $"."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	background_music.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !background_music.playing:
		background_music.play()
