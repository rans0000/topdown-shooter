extends Control

@export_file("*.tscn") var main_menu_path: String
@export var  in_time: float = 0.5
@export var  fadein_time: float = 1.5
@export var  pause_time: float = 1.5
@export var  fadeout_time: float = 1.5
@export var  out_time: float = 0.5
@export var splashscreen_container: Node

var splash_screens : Array


func _ready() -> void:
	get_screens()
	fade()


func get_screens() -> void:
	splash_screens = splashscreen_container.get_children()
	for screens in splash_screens:
		screens.modulate.a = 0.0


func fade() -> void:
	for screen in splash_screens:
		var tween = self.create_tween()
		tween.tween_interval(in_time)
		tween.tween_property(screen, "modulate:a", 1.0, fadein_time)
		tween.tween_interval(pause_time)
		tween.tween_property(screen, "modulate:a", 0.0, fadeout_time)
		tween.tween_interval(out_time)
		await  tween.finished
	Global.game_controller.change_gui_scene(main_menu_path)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_pressed():
		Global.game_controller.unload_all_scenes()
		Global.game_controller.change_gui_scene(main_menu_path, true, false, false)
