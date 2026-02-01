extends Area2D

@export var menu_scene = preload("res://Scenes/CpuMenuDialog.tscn")
var menu_instance: Control

func _ready():
	menu_instance = menu_scene.instantiate()
	get_tree().current_scene.add_child(menu_instance)
	menu_instance.hide()
	print("Hola")

func input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("CPU clickeada")   # <-- Esto verifica que el clic funcione
		menu_instance.mostrar(self, get_global_mouse_position())
