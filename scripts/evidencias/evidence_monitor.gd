extends EvidenciaBase

func _ready():
	input_pickable = true
	tipo = "monitor"
	estado = "apagado"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		var menu = get_parent().get_node("EvidenciaMenu")
		menu.mostrar_menu(self, get_global_mouse_position(), estado)
