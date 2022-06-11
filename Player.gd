extends KinematicBody2D

const UP = Vector2(0, -1)
const gravity = 30
const maxFallSpeed = 200
const maxSpeed = 300
const jumpForce = 700
const accel = 10

var motion = Vector2()
var facing_right = true

func _ready():
	pass
	
func _physics_process(delta):
	
	motion.y += gravity 
	if motion.y > maxFallSpeed:
		motion.y += maxFallSpeed * delta
	
	if facing_right == true:
		$Sprite.scale.x = 1
	else:
		$Sprite.scale.x = -1
	
	motion.x = clamp(motion.x, -maxSpeed, maxSpeed)
	
	if Input.is_action_pressed("right"):
		motion.x += accel
		facing_right = true
		$AnimationPlayer.play("walk")
	elif Input.is_action_pressed("left"):
		motion.x -= accel
		facing_right = false
		$AnimationPlayer.play("walk")
	else:
		motion.x = lerp(motion.x, 0, 0.2)
		$AnimationPlayer.play("idle")
	if is_on_floor():
		if Input.is_action_pressed("jump"):
			motion.y = -jumpForce 
	
	if is_on_floor():
		if Input.is_action_pressed("crouch"):
			$AnimationPlayer.play("crouch")
	
	if !is_on_floor():
		if motion.y < 0:
			$AnimationPlayer.play("jump")
		elif motion.y > 0:
			$AnimationPlayer.play("fall")
	
	motion = move_and_slide(motion, UP)
