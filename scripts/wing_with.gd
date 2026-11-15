extends CharacterBody2D

@onready var camera_2d: Camera2D = $Camera2D
#@onready var wing_with: CharacterBody2D = $"."
@onready var player: Sprite2D = $Player
@onready var animation_player: AnimationPlayer = $Player/AnimationPlayer
@onready var rich_text_label: RichTextLabel = $Camera2D/RichTextLabel
@onready var black: Sprite2D = $"../black"
@onready var black_animation: AnimationPlayer = $"../black/AnimationPlayer"

const SPEED = 300.0
var JUMP_VELOCITY = -400.0

var camera_zoom = Vector2(2, 2)
@export var wing_health = 10
@export var health_init = false

var engulfing = false

func init_wing_health():
	rich_text_label.clear()
	rich_text_label.add_text("Wing health: ")
	rich_text_label.append_text(str(wing_health))

func _physics_process(delta: float) -> void:
	if !health_init:
		init_wing_health()
	camera_2d.zoom = camera_zoom
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	if Input.is_action_just_pressed("space"):
		if is_on_floor():
			update_wings()
		else:
			update_wings(3)

	if Input.is_action_just_pressed("reset"):
		reload_scene()

	if Input.is_action_just_pressed("t_key"):
		wing_health = 1000000

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left_arrow", "right_arrow")
	if direction:
		velocity.x = direction * SPEED
		if direction < 0:
			player.flip_h = true
		else:
			player.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# Loop through every collision from this frame
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		var normal = collision.get_normal()

		if collider.scene_file_path == "res://scenes/question_box.tscn":
			#print("touched question box")
			if collider.has_meta("is_empty"):
				if !collider.get_meta("is_empty"):
					if normal.y > 0.5:
						collider.set_meta("is_empty", true)
						add_wing_health(true)
						collider.swap_texture_to_empty()
				else:
					pass
					#print("empty box")
			else:
				pass
				#print("this box has no metadata")
		elif collider.scene_file_path == "res://scenes/vulture.tscn":
			engulf_black()

func reload_scene():
	get_tree().reload_current_scene()
#
func add_wing_health(random = false):
	if wing_health == null:
		wing_health = 10
	if random:
		wing_health += randi_range(3, 5)
	else:
		wing_health += 1
	rich_text_label.clear()
	rich_text_label.add_text("Wing health: ")
	rich_text_label.append_text(str(wing_health))
	JUMP_VELOCITY = -400

func update_wings(subtract = 1):
	if wing_health == null:
		wing_health = 10
	if wing_health >= 1:
		if wing_health - subtract >= 1:
			wing_health -= subtract
			if wing_health >= 1:
				JUMP_VELOCITY = -400
				velocity.y = JUMP_VELOCITY
				animation_player.play("flap")
				animation_player.queue("RESET")
			else:
				JUMP_VELOCITY = 0
				engulf_black()
		else:
			wing_health = 0
	elif wing_health <= 0:
		JUMP_VELOCITY = 0
		engulf_black()
	rich_text_label.clear()
	rich_text_label.add_text("Wing health: ")
	rich_text_label.append_text(str(wing_health))

func engulf_black():
	black.global_position = player.global_position
	if engulfing:
		return
	engulfing = true
	black.visible = true
	animation_player.stop()
	animation_player.clear_queue()
	black_animation.play("engulf")
	await black_animation.animation_finished
	black.visible = false
	reload_scene()
