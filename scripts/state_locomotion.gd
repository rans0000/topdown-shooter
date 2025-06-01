extends State
class_name StateLocomotion

@export var move_speed := 5.0
@export var idle_state: State
@export var movement_state: State

const _RAY_LENGTH := 1000.0
var speed_blend := Vector2.ZERO
var stance := Constants.STANCE_MODE.WALK
var is_crouching := false

func enter() -> void:
	super()
	fsm.animation_ctrl.move_actor(Vector2.ZERO)


func process(_delta: float) -> State:
	_look_at_reticle()
	return null


func  physics_process(_delta: float) -> State:
	return movement_state if _is_moving() else idle_state


func unhandled_input(_event: InputEvent) -> State:
	_handle_sprint()
	return null


func _look_at_reticle() -> void:
	parent.look_at(parent.target_position, Vector3.UP)


func _is_moving() -> bool:
	var move_vec2D := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	return not move_vec2D == Vector2.ZERO


func _handle_sprint() -> void:
	if Input.is_action_pressed("action_sprint"):
		stance = Constants.STANCE_MODE.SPRINT
	if Input.is_action_just_released("action_sprint"):
		stance = Constants.STANCE_MODE.WALK


func handle_crouch() -> void:
	if Input.is_action_just_pressed("action_crouch"):
		if is_crouching:
			stance = Constants.STANCE_MODE.WALK
			#scale = Vector3(1, 1, 1)
		else:
			stance = Constants.STANCE_MODE.CROUCH
			#scale = Vector3(1, 0.5, 1)
		is_crouching = not is_crouching
