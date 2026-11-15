extends StaticBody2D
@onready var question_box: StaticBody2D = $"."
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var empty_box_sprite: Sprite2D = $empty_box_sprite

func swap_texture_to_empty():
	sprite_2d.visible = false
	empty_box_sprite.visible = true
