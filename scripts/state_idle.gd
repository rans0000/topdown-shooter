extends StateLocomotion

func enter() -> void:
	super()
	#print("state idle")
	parent.velocity = Vector3.ZERO
	fsm.animation_ctrl.move_actor(Vector2.ZERO, is_crouching)

func  physics_process(delta: float) -> State:
	super(delta)
	var move_vec2D := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	if not move_vec2D == Vector2.ZERO:
		return movement_state
	return null
