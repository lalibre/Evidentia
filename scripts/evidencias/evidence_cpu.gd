extends EvidenciaBase 

func _ready():
	input_pickable = true
	tipo = "CPU"
	estado = "apagado"
	#print("ClickableArea ready")

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		var menu = get_parent().get_node("EvidenciaMenu")
		menu.mostrar_menu(self, get_global_mouse_position())
		print("¡Hiciste clic en el CPU!")
