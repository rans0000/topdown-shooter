extends Node
class_name  GameController

@export var world_3D : Node3D
@export var world_2D : Node2D
@export var gui : Control
@onready var splashscreen: Control = $GUI/Splashscreen

var current_3D_scene : Node
var current_2D_scene : Node
var current_gui_scene : Node

func _ready() -> void:
	Global.game_controller = self
	current_gui_scene = splashscreen


func unload_all_scenes() -> void:
	if(current_3D_scene): current_3D_scene.queue_free()
	if(current_2D_scene): current_2D_scene.queue_free()
	if(current_gui_scene): current_gui_scene.queue_free()


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
			world_3D.remove_child(current_3D_scene)
	
	var node = load(scene_path).instantiate()
	world_3D.add_child(node)
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
			world_2D.remove_child(current_2D_scene)
	
	var node = load(scene_path).instantiate()
	world_2D.add_child(node)
	current_2D_scene = node
