extends Node3D
class_name Bullet

var speed : float
var damage : float
@onready var expiry_timer: Timer = $ExpiryTimer


func _physics_process(delta: float) -> void:
	position -= transform.basis.z * speed * delta
	#print(position)


func configure(_speed: float, _damage: float, _life: float) -> void:
	speed = _speed
	damage = _damage
	expiry_timer.wait_time = _life
	expiry_timer.start()


func _on_expiry_timer_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node3D) -> void:
	if 'take_damage' in body :
		body.take_damage(damage)
	queue_free()
