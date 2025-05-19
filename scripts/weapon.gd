@tool

extends Node3D
class_name Weapon

var weapon_index := 0
var fire_mode : int
var BulletScene : PackedScene = preload("res://scenes/weapons/bullet.tscn")
@onready var muzzle : Marker3D = $Muzzle
@onready  var weapon_mesh : MeshInstance3D = %WeaponMesh
@export_file("*.tres") var weapon_paths: Array[String]
@export var weapon : WeaponConfig:
	set(value):
		weapon = value
		if Engine.is_editor_hint():
			load_weapon()
var target_pos: Vector3:
	set(pos):
		#target_pos = pos * muzzle.global_position.y
		target_pos = pos



#func _process(_delta: float) -> void:
	#DebugDraw3D.draw_line(muzzle.global_position, target_pos, Color(1, 1, 0))


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
	bullet.look_at(target_pos, Vector3.UP)
