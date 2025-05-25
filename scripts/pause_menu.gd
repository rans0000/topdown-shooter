extends Control

@export_file("*tscn") var main_menu_path : String



func _enter_tree() -> void:
	hide()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		var tree := get_tree()
		if tree.paused: resume_game(tree)
		else: pause_game(tree)


func resume_game(tree: SceneTree) -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	tree.paused = false
	self.hide()


func pause_game(tree: SceneTree) -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	tree.paused = true
	self.show()
	$Control/PanelContainer/VBoxContainer/ResumeBtn.grab_focus()


func _on_resume_btn_pressed() -> void:
	resume_game(get_tree())


func _on_main_menu_btn_pressed() -> void:
	get_tree().paused = false
	Global.game_controller.unload_all_scenes()
	Global.game_controller.change_gui_scene(main_menu_path)


func _on_quit_btn_pressed() -> void:
	get_tree().quit()
