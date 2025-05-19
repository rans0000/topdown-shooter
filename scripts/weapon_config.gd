extends Resource
class_name WeaponConfig

@export var name : String
@export var mesh: Mesh
@export var muzzle_position: Vector3
@export var cool_down :float = 0.2
@export var weapon_sway : float = 0.15
@export var recoil : float = 1
@export var recoil_duration : float = 0.3
@export var is_automatic : bool = false

@export_category("Sounds")
@export var firing_sfx : Array[AudioStream]
@export var reload_sfx : AudioStream
@export var empty_sfx : AudioStream

@export_category("Bullet stats")
@export var damage : float
@export var bullet_spread : float
@export var max_mag : int
@export var bullet_amount : int = 1
@export var bullet_life : float = 3.0
@export var bullet_speed : float = 200
