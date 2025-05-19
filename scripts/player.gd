extends CharacterBody3D

@export var camera: Camera3D
@onready var weapon: Weapon = $Weapon
@onready var bounds := get_viewport().get_visible_rect().size
@onready var player_ui: PlayerUI = $PlayerUI
var move_speed := 300.0
var cursor_position := Vector2.ZERO
var target_position := Vector3.ZERO
var joystick_acceleration := 10;
var move_mode := Constants.MOVE_MODE.WALK
var is_crouching := false


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


func _physics_process(delta: float) -> void:
	move_player(delta)
	handle_joystick_motion()
	look_at_camera()
	calculate_weapon_sway()
	move_and_slide()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		cursor_position = get_viewport().get_mouse_position()
	elif event is InputEventJoypadMotion:
		handle_joystick_motion()
	handle_sprint()
	handle_crouch()


func move_player(delta:float) -> void:
	var move_vec2D := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := Vector3(move_vec2D.x, 0, move_vec2D.y)
	var target_vec2D := Vector2(target_position.x, target_position.z).normalized()
	var speed := remap(move_vec2D.dot(target_vec2D), -1, 1, 1, 2) * move_speed * move_mode
	velocity = direction  * speed * delta


func look_at_camera() -> void:
	player_ui.set_reticule_position(cursor_position)
	var state = get_world_3d().direct_space_state
	var origin:Vector3 = camera.project_ray_origin(cursor_position)
	var end :Vector3= origin + camera.project_ray_normal(cursor_position) * 1000
	var query = PhysicsRayQueryParameters3D.create(origin, end, 0b00000000_00000000_00000000_00000001)
	var result := state.intersect_ray(query)
	if result.is_empty(): return
	
	var pos = result.position;
	target_position = Vector3(pos.x, position.y, pos.z)
	look_at(target_position, Vector3.UP)
	weapon.target_pos = pos + (origin - pos).normalized()


func handle_joystick_motion() -> void:
	var joy_vector = Input.get_vector("camera_left", "camera_right","camera_up","camera_down") * joystick_acceleration
	if joy_vector == Vector2.ZERO: return
	cursor_position = Vector2(clampf(cursor_position.x + joy_vector.x, 0, bounds.x),clampf(cursor_position.y + joy_vector.y, 0, bounds.y) )


func handle_sprint() -> void:
	if Input.is_action_pressed("action_sprint"):
		move_mode = Constants.MOVE_MODE.SPRINT
	if Input.is_action_just_released("action_sprint"):
		move_mode = Constants.MOVE_MODE.WALK


func handle_crouch() -> void:
	if Input.is_action_just_pressed("action_crouch"):
		if is_crouching:
			move_mode = Constants.MOVE_MODE.WALK
			scale = Vector3(1, 1, 1)
		else:
			move_mode = Constants.MOVE_MODE.CROUCH
			scale = Vector3(1, 0.5, 1)
		is_crouching = not is_crouching


func calculate_weapon_sway() -> void:
#	@todo: calculate sway properly
	var distanceSquared := position.distance_squared_to(target_position)
	var distance_factor := remap(distanceSquared, 0, 400, 0, 5)
	var velocity_factor := velocity.length() / 10
	var sway:float = distance_factor + velocity_factor + weapon.settings.bullet_spread + weapon.recoil
	player_ui.set_weapon_sway(sway * 3)
	weapon.weapon_sway_angle = sway
