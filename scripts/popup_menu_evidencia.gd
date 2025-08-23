# evidencia_menu.gd
extends PopupMenu

var evidencia_actual : Node

func mostrar_menu(evidencia: Node, global_position: Vector2):
	evidencia_actual = evidencia
	set_position(global_position)
	popup()

func _on_id_pressed(id: int):
	var accion = get_item_text(id)
	if evidencia_actual:
		evidencia_actual.aplicar_accion(accion)
	hide()


func _on_boton_guardar_pressed() -> void:
	pass # Replace with function body.
