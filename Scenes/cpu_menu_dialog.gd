extends Control

@onready var typewriter = $Panel/TypewriterEffect/CanvasLayer/Control/RichTextLabel
@onready var progress_bar = $Panel/ProgressBar
@onready var status_label = $Panel/StatusLabel
var evidencia_actual: Node
var completed_actions: int = 0
var total_actions: int = 3


func _ready():
	print("DEBUG: hijos de Panel:", $Panel.get_children())
	print("DEBUG: nodo TywriterEffect:", get_node_or_null("Panel/TywriterEffect"))
	# Aquí lanzas el primer mensaje
	typewriter.start_typing("¡Atención! El sistema está en riesgo. Selecciona la siguiente acción para asegurar la evidencia antes de que sea alterada:")
	$Panel/HBoxContainer/Memory.pressed.connect(_on_memory_pressed)
	$Panel/HBoxContainer/Network.pressed.connect(_on_network_pressed)
	$Panel/HBoxContainer/Malware.pressed.connect(_on_malware_pressed)
	
	
func show_message(msg: String):
	typewriter.start_typing(msg)

func _on_memory_pressed():
	_start_action("Adquiriendo memoria volátil...", "Memoria adquirida con éxito.")

func _on_network_pressed():
	_start_action("Capturando tráfico de red...", "Captura de red finalizada.")

func _on_malware_pressed():
	_start_action("Analizando muestras de malware...", "Malware identificado y almacenado.")

func _start_action(start_msg: String, end_msg: String):
	# Reinicia barra y muestra mensaje inicial
	progress_bar.value = 0
	status_label.text = start_msg

	# Tween para animar la barra (3 seg de ejemplo)
	var tween = create_tween()
	tween.tween_property(progress_bar, "value", 100, 3.0)

	# Al terminar, mostramos el mensaje final
	tween.tween_callback(Callable(self, "_show_end_message").bind(end_msg))

func _show_end_message(end_msg: String):
	status_label.text = end_msg
	completed_actions += 1
	if completed_actions >= total_actions:
		_all_actions_completed()
		
func _all_actions_completed():
	hide() 
	typewriter.hide()



func mostrar(evidencia: Node, global_pos: Vector2):
	evidencia_actual = evidencia
	self.set_position(global_pos)
	self.show()  # Mostrar la ventana

func _on_button_pressed(action: String):
	if evidencia_actual:
		evidencia_actual.aplicar_accion(action)
	hide()
