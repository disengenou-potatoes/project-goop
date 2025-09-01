extends CharacterBody2D

@export var friction = 1000
@export var accel = 1500
@export var health = 100
var speed = 400
@export var max_speed = 600
@export var slow_speed = 400

var direction = Vector2.ZERO

func _physics_process(delta):
	if Input.is_action_pressed("run"):
		speed = max_speed
	elif Input.is_action_just_released("run"):
		speed = slow_speed
	
	direction = Input.get_vector("left", "right", "up", "down")
	velocity += direction * accel * delta
	velocity = velocity.limit_length(speed)
	
	if direction == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	move_and_slide()
#movement all done
func take_damage(amount: int):
	health -= amount
	$"invinciblity frames".start()
	$Sprite2D.hide()
func _on_invinciblity_frames_timeout() -> void:
	$Sprite2D.show()

func _process(float):
	if health == 0:
		queue_free()
