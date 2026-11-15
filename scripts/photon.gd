extends Area2D
@onready var wing_with: CharacterBody2D = $"../wing_with"


func _on_body_entered(_body: Node2D) -> void:
	wing_with.add_wing_health()
	queue_free()
 
