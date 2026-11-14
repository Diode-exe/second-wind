extends Area2D

@onready var timer: Timer = $Timer
@onready var player_node: Node2D = $"../Player"
@onready var game: Node2D = $".."
@onready var white: Sprite2D = $"../white"
@onready var left_wing_animation: AnimationPlayer = $"Player/left_wing/AnimationPlayer"
@onready var right_wing_animation: AnimationPlayer = $"Player/right_wing/AnimationPlayer"


func _on_body_entered(body: Node2D) -> void:
	print("You died!")
	timer.start()

func _on_timer_timeout() -> void:
	attach_wings()

func attach_wings():
	left_wing_animation.play("left_wing_attach")
	right_wing_animation.play("right_wing_attach")
	game.call_deferred("attach_wings")
	white.visible = true
