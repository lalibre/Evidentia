extends Node3D

func _input(event):
	pass
	#print(event)


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	pass # Replace with function body.
