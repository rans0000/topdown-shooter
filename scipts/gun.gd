extends Node3D
class_name Gun

var BulletScene :PackedScene = preload("res://scenes/weapons/bullet.tscn")
@onready var muzzle: Marker3D = $GunMuzzle



func _input(event: InputEvent) -> void:
	if (event is InputEventMouseButton or event is InputEventJoypadButton) and Input.is_action_just_pressed("primary_attack"):
		var bullet = BulletScene.instantiate()
		#bullet.position = muzzle.position
		get_tree().get_first_node_in_group('SpawnGroup').add_child(bullet)
		bullet.global_transform = muzzle.global_transform
