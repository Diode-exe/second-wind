extends CharacterBody2D

func finish_game():
	get_tree().change_scene_to_file("res://scenes/end_screen.tscn")
