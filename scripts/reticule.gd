extends Node2D


const _length := 10
const _color := Color.WHITE
const line_thickness := 2
var offset := 0.0



func _process(_delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	draw_line(Vector2(0, -offset), Vector2(0, -_length - offset), _color, line_thickness)
	draw_line(Vector2(0, offset), Vector2(0, _length + offset), _color, line_thickness)
	draw_line(Vector2(offset, 0), Vector2(_length + offset, 0), _color, line_thickness)
	draw_line(Vector2(-offset, 0), Vector2(-_length - offset, 0), _color, line_thickness)
