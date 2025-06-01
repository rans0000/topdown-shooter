extends CharacterBody3D

@export var camera: Camera3D
@export var locomotion_fsm: StateMachine
#@onready var weapon: Weapon = $Weapon
@onready var _bounds := get_viewport().get_visible_rect().size
@onready var _player_ui: PlayerUI = $PlayerUI
#var move_speed := 300.0
var cursor_position := Vector2.ZERO
var target_position := Vector3.ZERO
var stance := Constants.STANCE_MODE.WALK
var _joystick_acceleration := 10;
#var is_crouching := false


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	locomotion_fsm.init()


func _process(delta: float) -> void:
	_player_ui.set_reticule_position(cursor_position)
	locomotion_fsm.process(delta)

func _physics_process(delta: float) -> void:
	_handle_joystick_motion()
	_calculate_target()
	
	#move_player(delta)
	#look_at_camera()
	#calculate_weapon_sway()
	#move_and_slide()
	
	locomotion_fsm.physics_process(delta)


func _input(event: InputEvent) -> void:
	locomotion_fsm.unhandled_input(event)
	
	if event is InputEventMouseMotion:
		cursor_position = get_viewport().get_mouse_position()
	#handle_sprint()
	#handle_crouch()


#func move_player(delta:float) -> void:
	#var move_vec2D := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	#var direction := Vector3(move_vec2D.x, 0, move_vec2D.y)
	#var target_vec2D := Vector2(target_position.x, target_position.z).normalized()
	#var speed := remap(move_vec2D.dot(target_vec2D), -1, 1, 1, 2) * move_speed * stance
	#velocity = direction  * speed * delta


func _calculate_target() -> void:
	var state = get_world_3d().direct_space_state
	var origin:Vector3 = camera.project_ray_origin(cursor_position)
	var end :Vector3= origin + camera.project_ray_normal(cursor_position) * 1000
	var query = PhysicsRayQueryParameters3D.create(origin, end, 0b00000000_00000000_00000000_00000001)
	var result := state.intersect_ray(query)
	if result.is_empty(): return
	
	var pos = result.position;
	target_position = Vector3(pos.x, position.y, pos.z)
	#look_at(target_position, Vector3.UP)
	#weapon.target_pos = pos + (origin - pos).normalized()
#
#
#func look_at_camera() -> void:
	#player_ui.set_reticule_position(cursor_position)
	#var state = get_world_3d().direct_space_state
	#var origin:Vector3 = camera.project_ray_origin(cursor_position)
	#var end :Vector3= origin + camera.project_ray_normal(cursor_position) * 1000
	#var query = PhysicsRayQueryParameters3D.create(origin, end, 0b00000000_00000000_00000000_00000001)
	#var result := state.intersect_ray(query)
	#if result.is_empty(): return
	#
	#var pos = result.position;
	#target_position = Vector3(pos.x, position.y, pos.z)
	#look_at(target_position, Vector3.UP)
	#weapon.target_pos = pos + (origin - pos).normalized()
#
#
func _handle_joystick_motion() -> void:
	var joy_vector = Input.get_vector("camera_left", "camera_right","camera_up","camera_down") * _joystick_acceleration
	if joy_vector == Vector2.ZERO: return
	cursor_position = Vector2(clampf(cursor_position.x + joy_vector.x, 0, _bounds.x),clampf(cursor_position.y + joy_vector.y, 0, _bounds.y) )
#
#
#func handle_sprint() -> void:
	#if Input.is_action_pressed("action_sprint"):
		#stance = Constants.STANCE_MODE.SPRINT
	#if Input.is_action_just_released("action_sprint"):
		#stance = Constants.STANCE_MODE.WALK
#
#
#func handle_crouch() -> void:
	#if Input.is_action_just_pressed("action_crouch"):
		#if is_crouching:
			#stance = Constants.STANCE_MODE.WALK
			#scale = Vector3(1, 1, 1)
		#else:
			#stance = Constants.STANCE_MODE.CROUCH
			#scale = Vector3(1, 0.5, 1)
		#is_crouching = not is_crouching
#
#
#func calculate_weapon_sway() -> void:
##	@todo: calculate sway properly
	#var distanceSquared := position.distance_squared_to(target_position)
	#var distance_factor := remap(distanceSquared, 0, 400, 0, 5)
	#var velocity_factor := velocity.length() / 3
	#var crouch_factor := 1.0 if stance == Constants.STANCE_MODE.CROUCH else 5.0
	#var sway:float = distance_factor + velocity_factor + weapon.settings.bullet_spread + weapon.recoil + crouch_factor
	#player_ui.set_weapon_sway(sway)
	#weapon.weapon_sway_angle = sway
