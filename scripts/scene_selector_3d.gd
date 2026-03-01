extends Node3D

var can_interact := false
	
func _ready():

	# Ocultar mouse inmediatamente
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$UI/HelpPanel.show_message("🧭 Bienvenido al simulador forense digital 'Evidentia'.
	🖱 Para moverte, mantén presionado el clic izquierdo y arrastra.
	🚪 Haz clic en una puerta para ingresar a una escena.
	📊 Cuando consideres que has terminado, pulsa el botón 'Finalizar' para evaluar tu 	desempeño.

⚠ Recuerda: cada acción cuenta.")

	# Llamar función que mostrará el mouse luego de un delay
	_show_mouse_after_delay()

func _show_mouse_after_delay() -> void:
	await get_tree().create_timer(8.0).timeout
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	can_interact = true	
	
func input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	pass # Replace with function body.

func _on_help_panel_message_finished() -> void:
	# Mostrar mouse *solo cuando el mensaje terminó de verdad*
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	can_interact = true
