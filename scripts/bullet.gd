extends Node3D
class_name Bullet

var speed := 50



func _physics_process(delta: float) -> void:
	position -= transform.basis.z * speed * delta


func _on_expiry_timer_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node3D) -> void:
	if 'take_damage' in body :
		body.take_damage(30)
	queue_free()
