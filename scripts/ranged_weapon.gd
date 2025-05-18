@tool

extends Node3D
class_name RangedWeapon

var BulletScene : PackedScene = preload("res://scenes/weapons/bullet.tscn")
@onready var muzzle : Marker3D = $Muzzle
@onready  var weapon_mesh : MeshInstance3D = %WeaponMesh
var fire_mode : int
@export var weapon_type : RangedWeaponConfig:
	set(value):
		weapon_type = value
		if Engine.is_editor_hint():
			load_weapon()
const weapon_paths := ["res://data/comrade_rifle.tres", "res://data/hamster_pistol.tres"];
var weapon_index := 0


func _ready() -> void:
	load_weapon()


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("primary_attack"):
		var bullet = BulletScene.instantiate()
		get_tree().get_first_node_in_group('SpawnGroup').add_child(bullet)
		bullet.global_transform = muzzle.global_transform
	if Input.is_action_just_pressed("action_weapon_switch"):
		weapon_index = (weapon_index + 1) % weapon_paths.size()
		print(weapon_index)
		weapon_type = load(weapon_paths[weapon_index])
		load_weapon()


func load_weapon() -> void:
	weapon_mesh.mesh = weapon_type.mesh
	muzzle.position = weapon_type.muzzle_position
	pass
