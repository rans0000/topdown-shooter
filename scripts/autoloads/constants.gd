extends Node

const STANCE_MODE = {
	CROUCH = {
		speed_multiplier = 0.5,
		blend_multiplier = 0.5
	},
	WALK = {
		speed_multiplier = 1.0,
		blend_multiplier = 1.0
	},
	SPRINT = {
		speed_multiplier = 2.0,
		blend_multiplier = 2.0
	}
}

enum  WEAPON_TYPE {
	MELEE,
	RANGED
}
