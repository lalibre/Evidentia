extends Area3D

var default_cursor = Input.CURSOR_ARROW
var interact_cursor = Input.CURSOR_POINTING_HAND

func _ready():
	mouse_entered.connect(_on_mouse_enter)
	mouse_exited.connect(_on_mouse_exit)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func _on_mouse_enter():
	# Cambiar cursor a mano
	Input.set_default_cursor_shape(interact_cursor)

func _on_mouse_exit():
	# Volver al cursor normal
	Input.set_default_cursor_shape(default_cursor)

func _input_event(camera: Camera3D, event: InputEvent, click_position: Vector3, click_normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Puerta clickeada, cargando escena...")
		get_tree().change_scene_to_packed(preload("res://Scenes/GameScene_ComputerOff.tscn"))

func input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	pass # Replace with function body.
