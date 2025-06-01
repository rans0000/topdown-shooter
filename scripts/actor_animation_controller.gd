extends Node
class_name ActorAnimationController

@export var anim_tree: AnimationTree

func move_actor(move_2D: Vector2) -> void:
	#var loco:AnimationNodeBlendSpace2D = anim_tree.get("parameters/locomotion")
	anim_tree.set("parameters/locomotion/blend_position", move_2D)
