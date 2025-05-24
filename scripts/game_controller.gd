extends Node
class_name  GameController

@export var world_3D : Node3D
@export var world_2D : Node2D
@export var gui : Control

var current_3D_scene : Node
var current_2D_scene : Node
var current_gui_scene : Node

func _ready() -> void:
	Global.game_controller = self


func change_gui_scene(scene_path: String, delete: bool = true, keep_running: bool = false) -> void:
	if current_gui_scene != null:
		if delete:
			# remove node entirely
			current_gui_scene.queue_free()
		elif  keep_running:
			# keeps in memmory and running
			current_gui_scene.visible = false
		else:
			# keeps in memmory. does not run
			gui.remove_child(current_gui_scene)
	
	var node = load(scene_path).instantiate()
	gui.add_child(node)
	current_gui_scene = node


func change_3D_scene(scene_path: String, delete: bool = true, keep_running: bool = false) -> void:
	if current_3D_scene != null:
		if delete:
			# remove node entirely
			current_3D_scene.queue_free()
		elif  keep_running:
			# keeps in memmory and running
			current_3D_scene.visible = false
		else:
			# keeps in memmory. does not run
			gui.remove_child(current_3D_scene)
	
	var node = load(scene_path).instantiate()
	gui.add_child(node)
	current_3D_scene = node


func change_2D_scene(scene_path: String, delete: bool = true, keep_running: bool = false) -> void:
	if current_2D_scene != null:
		if delete:
			# remove node entirely
			current_2D_scene.queue_free()
		elif  keep_running:
			# keeps in memmory and running
			current_2D_scene.visible = false
		else:
			# keeps in memmory. does not run
			gui.remove_child(current_2D_scene)
	
	var node = load(scene_path).instantiate()
	gui.add_child(node)
	current_2D_scene = node
