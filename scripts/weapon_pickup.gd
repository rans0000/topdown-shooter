extends Node3D

@export_file("*.tres") var weapons: Array[String] = []
@onready var marker: Marker3D = $Marker3D
@onready var interactable: Interactable = $Interactable
var weapon_mesh: MeshInstance3D
var current_weapon: WeaponConfig

func _ready() -> void:
	interactable.action = Callable(self, "collect_weapon")
	_next_weapon()


func collect_weapon(body: Node3D) -> void:
	if weapons.size() > 0 and body.has_method("pickup_weapon"):
		var was_picked = body.pickup_weapon(current_weapon)
		if was_picked:
			weapons.remove_at(0)
			if weapons.size() <= 0:
				queue_free()
			else:
				_next_weapon()

func _next_weapon() -> void:
	if weapons.size() <= 0: return;
	current_weapon = load(weapons[0])
	if weapon_mesh: weapon_mesh.queue_free()
	weapon_mesh = MeshInstance3D.new()
	weapon_mesh.mesh = current_weapon.mesh
	marker.add_child(weapon_mesh)
	weapon_mesh.position = marker.position
