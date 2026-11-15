extends CharacterBody2D

@onready var camera_2d: Camera2D = $Camera2D
@onready var wing_with: CharacterBody2D = $"."
@onready var player: Sprite2D = $Player
@onready var animation_player: AnimationPlayer = $Player/AnimationPlayer

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var camera_zoom = Vector2(2, 2)

func _physics_process(delta: float) -> void:
	camera_2d.zoom = camera_zoom
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("space"):
		wing_flap()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if direction < 0:
			player.flip_h = true
		else:
			player.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func wing_flap():
	animation_player.play("flap")
	animation_player.queue("RESET")
