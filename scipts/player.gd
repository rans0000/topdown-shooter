extends CharacterBody3D

@export var camera: Camera3D
@onready var bounds := get_viewport().get_visible_rect().size
@onready var cursor: MeshInstance2D = $PlayerUI/Cursor
var move_speed := 200.0
var cursor_position := Vector2.ZERO
var joystick_acceleration := 10;




func _physics_process(delta: float) -> void:
	move_player(delta)
	move_and_slide()
	handle_joystick_motion()
	look_at_camera()


func move_player(delta:float) -> void:
	var move_vec2D := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := Vector3(move_vec2D.x, 0, move_vec2D.y) * move_speed * delta
	velocity = direction + direction


func look_at_camera() -> void:
	cursor.position = cursor_position
	var state = get_world_3d().direct_space_state
	var origin = camera.project_ray_origin(cursor_position)
	var end = origin + camera.project_ray_normal(cursor_position) * 1000
	var query = PhysicsRayQueryParameters3D.create(origin, end, 0b00000000_00000000_00000000_00000001)
	var result := state.intersect_ray(query)
	if result.is_empty(): return
	
	var pos = result.position;
	var target := Vector3(pos.x, position.y, pos.z)
	look_at(target, Vector3.UP)


func handle_joystick_motion() -> void:
	var joy_vector = Input.get_vector("camera_left", "camera_right","camera_up","camera_down") * joystick_acceleration
	if joy_vector == Vector2.ZERO: return
	cursor_position = Vector2(clampf(cursor_position.x + joy_vector.x, 0, bounds.x),clampf(cursor_position.y + joy_vector.y, 0, bounds.y) )
	


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		cursor_position = get_viewport().get_mouse_position()
	elif event is InputEventJoypadMotion:
		handle_joystick_motion()
