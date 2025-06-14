extends Area3D
class_name Interactable

@export var base_text := "Interact"
var action: Callable = func():
	pass


func _on_body_entered(body: Node3D) -> void:
	action.call(body)
