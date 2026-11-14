extends Node2D

@onready var left_wing_animation: AnimationPlayer = $"Player/left_wing/AnimationPlayer"
@onready var right_wing_animation: AnimationPlayer = $"Player/right_wing/AnimationPlayer"
@onready var white: Sprite2D = $white

func attach_wings():
	left_wing_animation.play("left_wing_attach")
	right_wing_animation.play("right_wing_attach")
	white.visible = true
