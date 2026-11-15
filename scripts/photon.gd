extends Area2D
@onready var wing_with: CharacterBody2D = $"."


func _on_body_entered(body: Node2D) -> void:
	wing_with.add_wing_health()
	queue_free()
 
