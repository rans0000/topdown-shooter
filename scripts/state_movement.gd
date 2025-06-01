extends State

@export var move_speed := 5.0
@onready var StateIdle: State = $"../Idle"

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
	var new_state = move_player()
	if new_state:
		return new_state
	return null


func unhandled_input(_event: InputEvent) -> State:
	_handle_sprint()
	return null


func _look_at_reticle() -> void:
	parent.look_at(parent.target_position, Vector3.UP)


func move_player() -> State:
	var move_vec2D := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	if move_vec2D == Vector2.ZERO:
		return StateIdle
	
	var direction := Vector3(move_vec2D.x, 0, move_vec2D.y)
	var target_vec2D := Vector2(parent.target_position.x, parent.target_position.z).normalized()
	var speed : float = remap(move_vec2D.dot(target_vec2D), -1, 1, 1, 2) * stance.speed_multiplier * move_speed
	parent.velocity = direction * speed
	parent.move_and_slide()
	
	var forward_factor : float = parent.global_transform.basis.z.dot(direction)
	var strafe_factor : float= parent.global_transform.basis.x.dot(direction)
	speed_blend = lerp(speed_blend, Vector2(strafe_factor, forward_factor) * stance.blend_multiplier, 0.1)
	fsm.animation_ctrl.move_actor(speed_blend)
	return null


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
