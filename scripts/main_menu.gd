extends Control

@export_file("*.tscn") var new_game_path: String
@export_file("*.tscn") var pause_menu_path: String


func _on_play_button_pressed() -> void:
	Global.game_controller.unload_all_scenes()
	Global.game_controller.change_3D_scene(new_game_path)
	Global.game_controller.change_gui_scene(pause_menu_path)


func _on_quit_button_pressed() -> void:
	get_tree().quit()
