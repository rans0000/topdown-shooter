extends Node3D

@export var camera_target: Node3D
var mouse_acceleration := 7




func _process(_delta: float) -> void:
	#position = lerp(position, camera_target.global_position, mouse_acceleration * delta)
	position = camera_target.global_position
