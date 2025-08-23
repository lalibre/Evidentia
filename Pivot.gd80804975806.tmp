extends Node3D

@export var rotation_speed := 0.005
var dragging := false

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		dragging = event.pressed
	elif event is InputEventMouseMotion and dragging:
		rotation.y -= event.relative.x * rotation_speed