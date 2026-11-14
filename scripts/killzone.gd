extends Area2D

@onready var timer: Timer = $Timer
@onready var player_node: Node2D = $"../../../../Player"
@onready var game: Node2D = $".."
@onready var white: Sprite2D = $"../white"
#@onready var player: CharacterBody2D = get_tree().current_scene

func _on_body_entered(body: Node2D) -> void:
	print("You died!")
	timer.start()

func _on_timer_timeout() -> void:
	player_node.attach_wings()
