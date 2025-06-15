extends StateLocomotion

func enter() -> void:
	super()
	#print("state move ")

func  physics_process(delta: float) -> State:
	var move_vec2D := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	if move_vec2D == Vector2.ZERO:
		return idle_state
	var dir = _move_player(delta, move_vec2D)
	fsm.animation_ctrl.move_actor(Vector2(dir.x, dir.z), is_crouching)
	return null


func unhandled_input(_event: InputEvent) -> State:
	_handle_sprint()
	return null


func _move_player(_delta:float, move_vec2D:Vector2) -> Vector3:
	var direction := Vector3(move_vec2D.x, 0, move_vec2D.y)
	var target_vec2D := Vector2(parent.target_position.x, parent.target_position.z).normalized()
	var angle = Vector3(-parent.basis.z).signed_angle_to(Vector3(direction), Vector3.UP)
	var slope = (Vector3.BACK * move_vec2D.length()).rotated(Vector3.UP, angle)
	var speed = remap(move_vec2D.dot(target_vec2D), -1, 1, 1, 2) * move_speed * stance.speed_multiplier
	parent.velocity = direction  * speed
	return slope


func _handle_sprint() -> void:
	if Input.is_action_just_pressed("action_sprint"):
		stance = Constants.STANCE_MODE.SPRINT
		is_crouching = false;
		fsm.animation_ctrl.set_crouching(false)
	if Input.is_action_just_released("action_sprint"):
		stance = Constants.STANCE_MODE.WALK
