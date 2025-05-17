extends CharacterBody3D
class_name Enemy

var health := 100.00


func take_damage(damage:float) -> void:
	health -= damage
	
	if health <= 0:
		die()


func die() -> void:
	queue_free()
