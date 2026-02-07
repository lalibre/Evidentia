# evidencia_menu.gd
extends PopupMenu

var evidencia_actual : Node

func mostrar_menu(evidencia: Node, global_position: Vector2, estado):
	evidencia_actual = evidencia
	print("evidencia")
	print(evidencia)
	var menu = get_tree().current_scene.get_node_or_null("EvidenciaMenu")
	menu.clear()
	match estado:
		"encendido":
			menu.add_item("Inspeccionar")
			menu.add_item("Apagar")
			menu.add_item("Adquisición encendido")
		"adquisicion_realizada":
			menu.add_item("Inspeccionar")
			menu.add_item("Apagar")
		"apagado":
			menu.add_item("Inspeccionar")
			menu.add_item("Desconectar")
		"desconectado":
			menu.add_item("Inspeccionar")
			menu.add_item("Recolectar")
		"evidenciado":
			menu.add_item("Recolectar")
			menu.add_item("Reportar")
		"recolectado":
			menu.add_item("Inspeccionar")
		"reportado":
			menu.add_item("Inspeccionar")
	menu.reset_size()
	var item_count = menu.item_count
	menu.size = Vector2(200, item_count * 28)
	set_position(global_position)
	popup()

func _on_id_pressed(id: int):
	var accion = get_item_text(id)
	if evidencia_actual:
		match accion:
			"Inspeccionar":
				var ver_dialog = preload("res://VerDialog.tscn").instantiate()
				get_tree().current_scene.add_child(ver_dialog)
				print("evidencia_actual")
				print(evidencia_actual)
				ver_dialog.mostrar_info(evidencia_actual, evidencia_actual.estado)
			_:
				evidencia_actual.aplicar_accion(accion)
	hide()


func _on_boton_guardar_pressed() -> void:
	pass # Replace with function body.
