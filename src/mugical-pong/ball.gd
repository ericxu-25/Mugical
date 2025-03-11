extends CharacterBody2D


const SPEED = 50.0
#const JUMP_VELOCITY = -400.0

func _ready() -> void:
	velocity = Vector2(-SPEED, 0)

func _physics_process(delta: float) -> void:
	var collision := move_and_collide(velocity)
	if collision:
		var normal := collision.get_normal()
		velocity = velocity.bounce(normal)

#func _physics_process(delta: float) -> void:
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
