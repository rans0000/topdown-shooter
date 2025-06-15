extends State
class_name StateLocomotion

@export var move_speed := 5.0
@export var idle_state: State
@export var movement_state: State

const _RAY_LENGTH := 1000.0
var speed_blend := Vector2.ZERO
var stance := Constants.STANCE_MODE.WALK
static var is_crouching := false

func enter() -> void:
	super()
	fsm.animation_ctrl.move_actor(Vector2.ZERO, is_crouching)


func process(_delta: float) -> State:
	_look_at_reticle()
	return null


func unhandled_input(_event: InputEvent) -> State:
	_handle_crouch()
	return null


func _look_at_reticle() -> void:
	parent.look_at(parent.target_position, Vector3.UP)


func _handle_crouch() -> State:
	if Input.is_action_just_pressed("action_crouch"):
		print("toggle crouch...")
		if is_crouching:
			stance = Constants.STANCE_MODE.WALK
		else:
			stance = Constants.STANCE_MODE.CROUCH
		is_crouching = not is_crouching
		fsm.animation_ctrl.set_crouching(is_crouching)
	return null
