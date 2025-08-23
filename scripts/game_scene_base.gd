extends Control

@export var cpu_encendida := false  # editable desde código
@onready var info_panel_scene = preload("res://Scenes/info_panel.tscn")
var info_panel_instance

func _ready():
	var ui_container = $CanvasLayer/UIX
	info_panel_instance = ui_container.get_node("InfoPanel")
	# Conectar ScoreLabel y LogPanel
	Game_Manager.score_label = info_panel_instance.get_node("InfoPanel/VBoxContainer/ScoreLabel")
	Game_Manager.log_panel = info_panel_instance.get_node("InfoPanel/VBoxContainer/ScrollContainer/LogPanel")

	# Verificar si realmente encontró los nodos
	print("Lo que encontró de nodos")
	print("score_label:", Game_Manager.score_label)
	print("log_panel:", Game_Manager.log_panel)
