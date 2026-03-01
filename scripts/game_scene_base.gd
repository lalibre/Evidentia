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
	$UI/HelpPanel.show_message("🧪 Escena del crimen

Te encuentras en un entorno con posibles evidencias digitales.

🔍 Haz clic sobre los dispositivos para inspeccionarlos.
Cada dispositivo puede requerir una acción distinta según su estado.

✔ Las decisiones correctas suman puntos.
✖ Las acciones incorrectas restan puntos.

📌 Cuando creas haber gestionado todas las evidencias relevantes, 
pulsa el botón 'Finalizar' para cerrar la escena y ver tu puntuación.")

	# Llamar función que mostrará el mouse luego de un delay
	_show_mouse_after_delay()

func _show_mouse_after_delay() -> void:
	await get_tree().create_timer(8.0).timeout
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	can_interact = true	
