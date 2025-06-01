extends State

@export var move_speed := 5.0
const _RAY_LENGTH := 1000.0
var speed_blend := Vector2.ZERO

func enter() -> void:
	super()
	fsm.animation_ctrl.move_actor(Vector2.ZERO)


func process(_delta: float) -> State:
	_look_at_reticle()
	return null


func  physics_process(_delta: float) -> State:
	move_player()
	return null


func unhandled_input(_event: InputEvent) -> State:
	return null


func _look_at_reticle() -> void:
	parent.look_at(parent.target_position, Vector3.UP)


func move_player() -> void:
	var move_vec2D := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := Vector3(move_vec2D.x, 0, move_vec2D.y)
	var target_vec2D := Vector2(parent.target_position.x, parent.target_position.z).normalized()
	var speed = remap(move_vec2D.dot(target_vec2D), -1, 1, 1, 2) * parent.stance.speed_multiplier * move_speed
	parent.velocity = direction * speed
	parent.move_and_slide()
	
	var forward_factor := parent.global_transform.basis.z.dot(direction)
	var strafe_factor := parent.global_transform.basis.x.dot(direction)
	speed_blend = lerp(speed_blend, Vector2(strafe_factor, forward_factor), 0.1)
	fsm.animation_ctrl.move_actor(speed_blend)
