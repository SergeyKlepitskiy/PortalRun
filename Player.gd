extends CharacterBody2D

var double_jump = false;
const SPEED = 500.0
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var axisX = Input.get_action_strength("left") - Input.get_action_strength("right")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		$AnimatedSprite.play("jump")
	if is_on_floor():
		double_jump = true
		$AnimatedSprite.play("idle")
		if Input.is_action_pressed("left"):
			$AnimatedSprite.set("flip_h", true)
			$AnimatedSprite.play("run")
		if Input.is_action_pressed("right"):
			$AnimatedSprite.set("flip_h", false)
			$AnimatedSprite.play("run")
	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY
		double_jump = true
		if Input.is_action_just_pressed("jump") and double_jump:
			velocity.y = JUMP_VELOCITY
			double_jump = false
	
	

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	
	move_and_slide()
	if Input.is_action_just_released("left") or Input.is_action_just_released("right"):
		$AnimatedSprite.play("idle")
func teleport():
	if not Global.blue_opened:
		pass
	else:
		position = Global.blue_pos
