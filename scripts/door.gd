extends Node3D

@export_file("*.tscn") var scene_path : String


func _on_body_entered(_body: Node3D) -> void:
	Global.game_controller.change_3D_scene(scene_path)
