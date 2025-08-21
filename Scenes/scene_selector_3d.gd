extends Node3D

func _ready():
	$Door1_Area.input_event.connect(_on_door_1_clicked)
	$Door2_Area.input_event.connect(_on_door_2_clicked)

func _on_door_1_clicked(camera, event, click_position, normal, shape_idx):
	if event is InputEventMouseButton and event.pressed: 
		_start_case_intro(false)

func _on_door_2_clicked(camera, event, click_position, normal, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		_start_case_intro(true)

func _start_case_intro(cpu_on: bool):
	var intro_scene = preload("res://Scenes/CaseIntroScene.tscn").instantiate()
	intro_scene.cpu_encendida = cpu_on
	get_tree().root.add_child(intro_scene)
	self.queue_free()
