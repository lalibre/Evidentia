# evidencia_menu.gd
extends PopupMenu

var evidencia_actual : Node

func mostrar_menu(evidencia: Node, global_position: Vector2, estado):
	evidencia_actual = evidencia
	print("evidencia")
	print(evidencia)
	var menu = get_tree().current_scene.get_node_or_null("EvidenciaMenu")
	menu.clear()
	# Accedemos al Enum de la clase base para comparar correctamente
	match estado:
		EvidenciaBase.Estado.ENCENDIDO:
			add_item("Inspeccionar")
			add_item("Apagar")
			add_item("Adquisición")
		
		EvidenciaBase.Estado.ADQUISICION_REALIZADA:
			add_item("Inspeccionar")
			add_item("Apagar")
			
		EvidenciaBase.Estado.APAGADO:
			add_item("Inspeccionar")
			add_item("Desconectar")
			
		EvidenciaBase.Estado.DESCONECTADO:
			add_item("Inspeccionar")
			add_item("Recolectar")
			
		EvidenciaBase.Estado.EVIDENCIADO:
			add_item("Recolectar")
			add_item("Reportar")
			
		EvidenciaBase.Estado.RECOLECTADO, EvidenciaBase.Estado.REPORTADO:
			add_item("Inspeccionar")
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
				print(evidencia_actual)
				var nombre_estado = EvidenciaBase.Estado.keys()[evidencia_actual.estado_actual].to_lower()
				ver_dialog.mostrar_info(evidencia_actual, nombre_estado)
			_:
				evidencia_actual.aplicar_accion(accion)
	hide()


func _on_boton_guardar_pressed() -> void:
	pass # Replace with function body.
