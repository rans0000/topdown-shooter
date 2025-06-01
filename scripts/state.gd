extends Node
class_name  State

var parent: Node3D
var fsm: StateMachine

func enter() -> void:
	pass


func exit() -> void:
	pass


func process(_delta: float) -> State:
	return null


func physics_process(_delta: float) -> State:
	return null


func unhandled_input(_event: InputEvent) -> State:
	return null
