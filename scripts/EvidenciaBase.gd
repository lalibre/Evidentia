extends Area2D
class_name EvidenciaBase

signal estado_cambiado(nuevo_estado)

@export var tipo : String = ""
@export var estado : String = ""
@export var caracteristicas : Dictionary = {
	"pierde_datos_al_apagar": true,
	"es_extraible": false
}

func _ready():
	input_pickable = true
	#print("EvidenceBase ready")

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		var menu = get_tree().get_current_scene().get_node("EvidenciaMenu")
		if menu:
			menu.mostrar_menu(self, get_global_mouse_position())
			#print("¡Hiciste clic en:", tipo, "!")
		else:
			print("EvidenciaMenu no encontrado")

func aplicar_accion(accion: String):
	match accion.to_lower():
		"apagar":
			if estado == "encendido":
				if caracteristicas.get("pierde_datos_al_apagar", false):
					Game_Manager.sumar_puntos(-10)
					Game_Manager.registrar_en_bitacora("Se apagó %s y se perdieron datos." % tipo)
			else:
				Game_Manager.registrar_en_bitacora("Se apagó %s sin pérdida de datos." % tipo)
				Game_Manager.registrar_accion("Se apagó %s sin pérdida de datos." % tipo)
			estado = "apagado"
			print("%s apagada" % tipo)
				
		"desconectar":
			if estado == "apagado":
				print("%s desconectada correctamente" % tipo)
				Game_Manager.sumar_puntos(5)
				Game_Manager.registrar_en_bitacora("Se desconectó %s correctamente." % tipo)
			else:
				Game_Manager.sumar_puntos(-5)
				Game_Manager.registrar_en_bitacora("Error: Se intentó desconectar %s encendida." % tipo)	
				print("Error: No puedes desconectar %s encendida" % tipo)
				Game_Manager.sumar_puntos(-5)
		"adquisición encendido":
			if estado == "encendido":
				Game_Manager.sumar_puntos(10)
				Game_Manager.registrar_en_bitacora("Se hizo adquisición de %s encendida." % tipo)
			else:
				Game_Manager.sumar_puntos(-5)
		"recolectar":
			Game_Manager.registrar_en_bitacora("Se intentó adquisición en %s apagada." % tipo)
			print("Recolectando %s..." % tipo)
	emit_signal("estado_cambiado", estado)
