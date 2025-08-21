extends Node3D

@onready var pivot: Node3D = $Pivot
@onready var cam: Camera3D = $Pivot/Camera3D

@export var h_sensibilidad := 0.005
@export var v_sensibilidad := 0.005

@export var highlight_color := Color(1, 0.8, 0.2, 1)
var previous_visual: MeshInstance3D = null
var previous_original_modulate := Color(1,1,1,1)

var rotando := false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

# Rotación con mouse
func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			rotando = event.pressed
	elif event is InputEventMouseMotion and rotando:
		pivot.rotate_y(-event.relative.x * h_sensibilidad)
		cam.rotate_x(-event.relative.y * v_sensibilidad)
		var rot_x_deg = clamp(rad_to_deg(cam.rotation.x), -60, 60)
		cam.rotation.x = deg_to_rad(rot_x_deg)

func _process(delta):
	_actualizar_hover()

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		_on_click()

# Hover por raycast
func _actualizar_hover():
	var mouse_pos: Vector2 = get_viewport().get_mouse_position()
	var from = cam.project_ray_origin(mouse_pos)
	var dir = cam.project_ray_normal(mouse_pos)
	var to = from + dir * 2000.0

	var query = PhysicsRayQueryParameters3D.create(from, to)
	var result = get_world_3d().direct_space_state.intersect_ray(query)

	if result:
		var collider = result.get("collider")
		var door_node = _find_door_node_from_collider(collider)
		if door_node:
			_highlight_door(door_node)
			return
	_remove_highlight()

func _find_door_node_from_collider(collider: Node) -> Node:
	var node := collider
	while node:
		if node.is_in_group("doors"):
			return node
		node = node.get_parent()
	return null

func _highlight_door(door_node: Node):
	var visual = door_node.get_node_or_null("Visual")
	if visual and visual is MeshInstance3D:
		if previous_visual and previous_visual != visual:
			previous_visual.modulate = previous_original_modulate
		previous_original_modulate = visual.modulate
		visual.modulate = highlight_color
		previous_visual = visual

func _remove_highlight():
	if previous_visual:
		previous_visual.modulate = previous_original_modulate
		previous_visual = null

# Click en puerta
func _on_click():
	var mouse_pos: Vector2 = get_viewport().get_mouse_position()
	var from = cam.project_ray_origin(mouse_pos)
	var dir = cam.project_ray_normal(mouse_pos)
	var to = from + dir * 2000.0

	var query = PhysicsRayQueryParameters3D.create(from, to)
	var result = get_world_3d().direct_space_state.intersect_ray(query)

	if result:
		var collider = result.get("collider")
		var door_node = _find_door_node_from_collider(collider)
		if door_node:
			var cpu_on = false
			var door_name = door_node.name.to_lower()
			if "on" in door_name or "right" in door_name:
				cpu_on = true
			_start_case_intro(cpu_on)


func _start_case_intro(cpu_encendida: bool) -> void:
	var packed = preload("res://Scenes/CaseIntroScene.tscn")
	var intro = packed.instantiate()
	intro.set("cpu_encendida", cpu_encendida)
	get_tree().root.add_child(intro)
	queue_free()
