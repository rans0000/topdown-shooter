extends Control
class_name PlayerUI

@onready var reticule: Node2D = $Reticule

func set_weapon_sway(value:float) -> void:
	reticule.offset = value


func set_reticule_position(pos: Vector2) -> void:
	reticule.position = pos
