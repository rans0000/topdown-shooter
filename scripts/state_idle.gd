extends State
@onready var movement: Node = $"../Movement"

func enter() -> void:
	super()
	fsm.animation_ctrl.move_actor(Vector2.ZERO)


func unhandled_input(_event: InputEvent) -> State:
	var move_vec2D := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	if not move_vec2D == Vector2.ZERO:
		return movement
	return null
