@tool

extends Node3D
class_name Weapon

var weapon_index := 0
var BulletScene : PackedScene = preload("res://scenes/weapons/bullet.tscn")
@onready var muzzle : Marker3D = $Muzzle
@onready  var weapon_mesh : MeshInstance3D = %WeaponMesh
@onready var cooldown_timer: Timer = $Timers/CooldownTimer
@export_file("*.tres") var weapon_paths: Array[String]
@export var settings : WeaponConfig:
	set(value):
		settings = value
		if Engine.is_editor_hint():
			load_weapon()
var target_pos: Vector3:
	set(pos):
		#target_pos = pos * muzzle.global_position.y
		target_pos = pos
var weapon_sway_angle: float:
	set(value):
		#weapon_sway_angle = deg_to_rad(randf_range(-PI/2, PI/2) * value)
		weapon_sway_angle = deg_to_rad(randf_range(-value, value))
var recoil := 0.0
var _recoil_tween: Tween
var _is_firing: bool = false



#func _process(_delta: float) -> void:
	#DebugDraw3D.draw_line(muzzle.global_position, target_pos, Color(1, 1, 0))


func _ready() -> void:
	weapon_sway_angle = 0
	load_weapon()


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("primary_attack"):
		fire_weapon()
	if Input.is_action_just_pressed("action_weapon_switch"):
		switch_weapon()


func switch_weapon() -> void:
	set_firing(false)
	weapon_index = (weapon_index + 1) % weapon_paths.size()
	settings = load(weapon_paths[weapon_index])
	load_weapon()


func load_weapon() -> void:
	weapon_mesh.mesh = settings.mesh
	muzzle.position = settings.muzzle_position
	cooldown_timer.stop()
	cooldown_timer.wait_time = settings.cool_down


func fire_weapon() -> void:
	if _is_firing: return
	
	var bullet = BulletScene.instantiate() as Bullet
	get_tree().get_first_node_in_group('SpawnGroup').add_child(bullet)
	bullet.configure(settings.bullet_speed, settings.damage, settings.bullet_life)
	bullet.global_transform = muzzle.global_transform
	bullet.look_at(target_pos, Vector3.UP)
	bullet.rotate(Vector3.UP, weapon_sway_angle)
	set_firing(true)


func set_firing(value: bool) -> void:
	if value:
		_recoil_tween = get_tree().create_tween()
		_is_firing = true
		recoil = settings.recoil
		cooldown_timer.start()
		_recoil_tween.tween_property(self, "recoil", 0, settings.recoil_duration).set_ease(Tween.EASE_IN)
	else:
		recoil = 0
		_recoil_tween.stop()


func _on_cooldown_timer_timeout() -> void:
	_is_firing = false
