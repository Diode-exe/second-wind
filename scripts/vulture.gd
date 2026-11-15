extends CharacterBody2D

@export var move_distance: float = 100.0
@export var duration: float = 1.5

func _ready() -> void:
	# Create a tween that loops forever
	var tween = create_tween().set_loops()
	
	# Smooth out the start and end of each movement
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	
	# Move up (negative Y in 2D) then return to the starting Y position
	var start_y = position.y
	tween.tween_property(self, "position:y", start_y - move_distance, duration)
	tween.tween_property(self, "position:y", start_y, duration)
