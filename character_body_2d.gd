extends CharacterBody2D

const SPEED = 100.0
const RUN_SPEED = 150.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump input
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get horizontal input
	var direction := Input.get_axis("ui_left", "ui_right")
	var is_running := Input.is_action_pressed("ui_shift") # requires ui_shift in Input Map
	var current_speed := RUN_SPEED if is_running else SPEED

	# Horizontal movement and animation
	if direction != 0:
		velocity.x = direction * current_speed

		# Choose animation
		if is_running:
			animated_sprite.animation = "run"
			animated_sprite.speed_scale = 3.0
		else:
			animated_sprite.animation = "walk"
			animated_sprite.speed_scale = 2.0

		animated_sprite.flip_h = direction > 0
		animated_sprite.play()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite.animation = "stand"
		animated_sprite.speed_scale = 1.0
		animated_sprite.play()

	# Airborne animation override
	if not is_on_floor():
		animated_sprite.animation = "jump"
		animated_sprite.play()

	move_and_slide()
