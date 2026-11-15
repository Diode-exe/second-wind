extends RichTextLabel

@export var move_distance: float = 500.0
@export var duration: float = 15
@onready var credits_music: AudioStreamPlayer2D = $"../CreditsMusic"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	credits_music.play()
	# Create a tween that loops forever
	var tween = create_tween().set_loops()
	
	# Smooth out the start and end of each movement
	tween.set_trans(Tween.TRANS_SINE)
	
	
	# Move up (negative Y in 2D) then return to the starting Y position
	var start_y = position.y
	tween.tween_property(self, "position:y", start_y - move_distance, duration)
	
	tween.tween_property(self, "modulate:a", 0.0, 1.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
