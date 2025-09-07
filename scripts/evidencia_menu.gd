extends PopupMenu

var evidencia_actual: Node

func mostrar_menu(evidencia: Node, global_position: Vector2, estado):
	evidencia_actual = evidencia
	clear()
	var menu = $PopupMenu
	menu.clear()
	
	
		
func _on_id_pressed(id: int):
	var accion = get_item_text(id)
	if evidencia_actual:
		evidencia_actual.aplicar_accion(accion)
	hide()
