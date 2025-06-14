extends Node3D

@export var guns: Array[WeaponConfig] = []
@onready var interactable: Interactable = $Interactable


func _ready() -> void:
	interactable.action = Callable(self, "collect_weapon")


func collect_weapon(body: Node3D) -> void:
	if guns.size() > 0 and body.is_in_group("PlayerGroup"):
		guns.remove_at(0)
		print("weapon collected!!")
		queue_free()
