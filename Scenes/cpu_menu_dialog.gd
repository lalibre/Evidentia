extends Control

var evidencia_actual: Node

func mostrar(evidencia: Node, global_pos: Vector2):
	evidencia_actual = evidencia
	self.set_position(global_pos)
	self.show()  # Mostrar la ventana

func _on_button_pressed(action: String):
	if evidencia_actual:
		evidencia_actual.aplicar_accion(action)
	hide()
