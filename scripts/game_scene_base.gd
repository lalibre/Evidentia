extends Control

var can_interact := false

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
	
	
	# Ocultar mouse inmediatamente
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$UI/HelpPanel.show_message("🔍 En esta escena hay posibles evidencias digitales. 
	Examina cada elemento con atención y selecciona la acción correcta al hacer clic sobre ellos.
	💡 Consejo: Toma decisiones con cuidado: 
	Una mala acción puede destruir datos o comprometer la cadena de custodia.")

	# Llamar función que mostrará el mouse luego de un delay
	_show_mouse_after_delay()

func _show_mouse_after_delay() -> void:
	await get_tree().create_timer(8.0).timeout
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	can_interact = true	
