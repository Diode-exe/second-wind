extends CharacterBody2D


@onready var bridge: StaticBody2D = $"../Bridges/Bridge"
@onready var bridge_collider: CollisionShape2D = $"../Bridges/Bridge/CollisionShape2D"
@onready var big_slime: Node2D = $"../Slimes/big_slime"
@onready var big_slime_animation: AnimationPlayer = $"../Sprite2D/AnimationPlayer"
@onready var left_wing_animation: AnimationPlayer = $"../wing_gain/Player/left_wing/AnimationPlayer"
@onready var right_wing_animation: AnimationPlayer = $"../wing_gain/Player/right_wing/AnimationPlayer"
@onready var white: Sprite2D = $"../white"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var killzone: Area2D = $"../Sprite2D/Killzone"
@onready var player: CharacterBody2D = $"."
@onready var wing_gain: Node2D = $"../wing_gain"
@onready var wing_gain_sprite: Sprite2D = $"../wing_gain/Player"

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		

	if Input.is_action_just_pressed("down_arrow") and is_on_floor():
		drop_down_bridge()
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		
		if direction < 0:
			animated_sprite_2d.flip_h = true
		else:
			animated_sprite_2d.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# bridge_collider.disabled = false
	# print(bridge_collider.disabled)

	move_and_slide()

func drop_down_bridge():
	if is_on_floor():
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			# Check if the surface normal points upward (floor)
			if collision.get_normal().dot(up_direction) > 0.7:
				var floor_node = collision.get_collider()
				if floor_node.name == "Bridge":
					print("Dropping down through the bridge")
					bridge_collider.disabled = true
					print(bridge_collider.disabled)


func _on_spawn_big_area_area_entered(area: Area2D) -> void:
	big_slime_animation.play("move_down")

func attach_wings():
	wing_gain_sprite.global_position = animated_sprite_2d.global_position
	player.visible = false
	player.process_mode = Node.PROCESS_MODE_DISABLED
	wing_gain.visible = true
	left_wing_animation.play("left_wing_attach")
	left_wing_animation.queue("right_wing_attach")
	right_wing_animation.play("right_wing_attach")
	
	#white.visible = true
