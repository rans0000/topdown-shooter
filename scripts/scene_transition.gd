extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func transition(anim: String, duration: float = 3.0) -> void:
	match anim:
		"fadein":
			animation_player.play("fadein", -1.0, duration)
		"fadeout":
			animation_player.play("fadeout", -1.0, duration)
	pass
