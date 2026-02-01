extends AcceptDialog

@onready var info_label: RichTextLabel = $InfoLabel

func _ready():
	print("Hijos directos de VerDialog:", get_children())

func mostrar_info(evidencia: Node, estado: String):
	var texto := ""
	print(evidencia.tipo)
	match evidencia.tipo:
		"CPU":
			match estado:
				"encendido":					
					texto  = "💻 La CPU muestra luces LED parpadeando. 🔊 Se escucha un leve zumbido de ventiladores. 📶 Hay señales de actividad, como si estuviera en uso."
				"apagado":
					texto = "💻 La CPU está sin luces. 🔇 No se perciben sonidos de ventiladores.  🔌 Aún se encuentra conectado a la corriente."
				"desconectado":
					texto = "💻 La CPU no tiene luces ni sonidos. 🔌 El cable de corriente está desconectado.  ✅ Parece listo para ser recolectado."
				"recolectado":
					texto = "✅ El CPU ya ha sido recolectado. 📂 Ahora forma parte de la evidencia almacenada."
		"USB":
			match estado:
				"desconectado":
					texto = "💾 El módulo de memoria está aislado.  ✅ Puede ser recolectado para análisis."
				"recolectado":
					texto = "✅ La memoria ya fue recolectada."
				_:
					texto = "🔍 No hay información disponible para este tipo de evidencia."
		"monitor":
			match estado:
				"encendido":					
					texto  = "💻 📶 Hay señales de actividad, como si estuviera en uso."
				"apagado":
					texto = "💻 No hay luces de encendido detectadas  🔌 El monitor aún se encuentra conectado a la corriente."
				"desconectado":
					texto = "✅ El monitor ahora  puede ser recolectado para análisis."
				"recolectado":
					texto = "✅ El monitor ya fue recolectado."
				_:
					texto = "🔍 No hay información disponible para este tipo de evidencia."
		"cajon":
			match estado:
				"recolectado":
					texto = "✅ ¡Papel encontrado! Las piezas no están en orden…Si logras armarlo, podrías descubrir la clave que necesitamos."
					var clave_scene = preload("res://Scenes/puzzle.tscn")
					var clave_instance = clave_scene.instantiate()
					get_tree().current_scene.add_child(clave_instance)
				_:
					texto = "🔍 No hay información disponible para este tipo de evidencia."

	info_label.text = texto
	reset_size()
	popup_centered()
