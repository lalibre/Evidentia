extends PopupMenu

var evidencia_actual: Node

func mostrar_menu(evidencia: Node, global_position: Vector2):
	evidencia_actual = evidencia
	clear()
	# Determinar opciones dinámicas según estado
	match evidencia.estado:
		evidencia.EstadoEvidencia.ENCENDIDO:
			add_item("Apagar")
			add_item("Adquisición encendida")
			add_item("Desconectar")
			add_item("Recolectar")
		evidencia.EstadoEvidencia.APAGADO, evidencia.EstadoEvidencia.DESCONECTADO:
			add_item("Recolectar")
		evidencia.EstadoEvidencia.RECOLECTADO:
			# No agregar acciones
			return
	set_position(global_position)
	popup()

func _on_id_pressed(id: int):
	var accion = get_item_text(id)
	if evidencia_actual:
		evidencia_actual.aplicar_accion(accion)
	hide()
