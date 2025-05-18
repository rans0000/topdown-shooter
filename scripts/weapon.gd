@tool

extends Node3D
class_name Weapon

@onready var muzzle : Marker3D = $Muzzle
@onready  var weapon_mesh : MeshInstance3D = %WeaponMesh
var BulletScene : PackedScene = preload("res://scenes/weapons/bullet.tscn")
@export var weapon : WeaponConfig:
	set(value):
		weapon = value
		if Engine.is_editor_hint():
			load_weapon()
var weapon_index := 0
var fire_mode : int
const weapon_paths := ["res://data/comrade_rifle.tres", "res://data/hamster_pistol.tres"];


func _ready() -> void:
	load_weapon()


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("primary_attack"):
		fire_weapon()
	if Input.is_action_just_pressed("action_weapon_switch"):
		weapon_index = (weapon_index + 1) % weapon_paths.size()
		weapon = load(weapon_paths[weapon_index])
		load_weapon()


func load_weapon() -> void:
	weapon_mesh.mesh = weapon.mesh
	muzzle.position = weapon.muzzle_position


func fire_weapon() -> void:
	var bullet = BulletScene.instantiate() as Bullet
	get_tree().get_first_node_in_group('SpawnGroup').add_child(bullet)
	bullet.configure(weapon.bullet_speed, weapon.damage, weapon.bullet_life)
	bullet.global_transform = muzzle.global_transform
