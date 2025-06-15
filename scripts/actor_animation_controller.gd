extends Node
class_name ActorAnimationController

@export var anim_tree: AnimationTree

func set_crouching(is_crouching := true) -> void:
	var tween = create_tween()
	if is_crouching:
		tween.tween_property(anim_tree, "parameters/stand_crouch_blend/blend_amount", 1.0, 0.2)
	else:
		tween.tween_property(anim_tree, "parameters/stand_crouch_blend/blend_amount", 0.0, 0.2)


func move_actor(move_2D: Vector2, is_crouching: bool) -> void:
	if is_crouching:
		anim_tree.set("parameters/crouch_blend/blend_position", move_2D)
	else:
		anim_tree.set("parameters/stand_blend/blend_position", move_2D)
