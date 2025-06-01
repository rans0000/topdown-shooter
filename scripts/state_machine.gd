extends Node
class_name StateMachine

@export var parent: Node3D
@export var current_state: State
@export var animation_ctrl: ActorAnimationController

func init() -> void:
	for child in get_children() as Array[State]:
		child.parent = parent
		child.fsm = self
	
	change_state(current_state)


func change_state(new_state: State) -> void:
	if(current_state):
		current_state.exit()
	current_state = new_state
	current_state.enter()


func process(delta: float) -> void:
	var new_state = current_state.process(delta)
	if new_state:
		change_state(new_state)


func physics_process(delta: float) -> void:
	var new_state = current_state.physics_process(delta)
	if new_state:
		change_state(new_state)


func unhandled_input(event: InputEvent) -> void:
	var new_state = current_state.unhandled_input(event)
	if new_state:
		change_state(new_state)
