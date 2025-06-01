extends StateLocomotion

func enter() -> void:
	super()
	fsm.animation_ctrl.move_actor(Vector2.ZERO)

func  physics_process(_delta: float) -> State:
	var move_vec2D := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	if not move_vec2D == Vector2.ZERO:
		return movement_state
	return null
