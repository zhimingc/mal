extends KinematicBody2D

export var ACCELERATION = 50
export var DRAG = .9
export var MAX_SPEED = 7.5

var velocity = Vector2()

func _physics_process(delta):
	var axis = get_move_input()
	if axis.length() <= 0.0:
		# $AnimationPlayer.play("PC_idle")
		pass
	else:
		apply_acceleration(axis * ACCELERATION * delta)
		#$AnimationPlayer.play("PC_walk")
	
	apply_drag()
	move_and_slide(velocity)

func _process(delta):
	var mousePos = get_viewport().get_mouse_position()
	look_at(mousePos)

func get_move_input():
	var axis = Vector2()
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return axis

func apply_acceleration(acceleration):
	velocity += acceleration
	if velocity.length() >= MAX_SPEED:
		velocity = velocity.normalized() * MAX_SPEED

func apply_drag():
	velocity *= DRAG
