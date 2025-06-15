extends CharacterBody3D

@export var camera: Camera3D
@onready var locomotion_fsm: StateMachine = $LocomotionFSM
#@onready var weapon: Weapon = $Weapon
@onready var _bounds := get_viewport().get_visible_rect().size
@onready var _player_ui: PlayerUI = $PlayerUI
var cursor_position := Vector2.ZERO
var target_position := Vector3.ZERO
var _joystick_acceleration := 10;


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	locomotion_fsm.init()


func _process(delta: float) -> void:
	_player_ui.set_reticule_position(cursor_position)
	locomotion_fsm.process(delta)

func _physics_process(delta: float) -> void:
	_handle_joystick_motion()
	_calculate_target()
	
	#calculate_weapon_sway()
	locomotion_fsm.physics_process(delta)
	move_and_slide()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		cursor_position = get_viewport().get_mouse_position()
	locomotion_fsm.unhandled_input(event)


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


func _handle_joystick_motion() -> void:
	var joy_vector = Input.get_vector("camera_left", "camera_right","camera_up","camera_down") * _joystick_acceleration
	if joy_vector == Vector2.ZERO: return
	cursor_position = Vector2(clampf(cursor_position.x + joy_vector.x, 0, _bounds.x),clampf(cursor_position.y + joy_vector.y, 0, _bounds.y) )


#func calculate_weapon_sway() -> void:
##	@todo: calculate sway properly
	#var distanceSquared := position.distance_squared_to(target_position)
	#var distance_factor := remap(distanceSquared, 0, 400, 0, 5)
	#var velocity_factor := velocity.length() / 3
	#var crouch_factor := 1.0 if stance == Constants.STANCE_MODE.CROUCH else 5.0
	#var sway:float = distance_factor + velocity_factor + weapon.settings.bullet_spread + weapon.recoil + crouch_factor
	#player_ui.set_weapon_sway(sway)
	#weapon.weapon_sway_angle = sway
