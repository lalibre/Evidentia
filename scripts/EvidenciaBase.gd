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
	print("EvidenceBase ready")

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		var menu = get_tree().get_current_scene().get_node("EvidenciaMenu")
		if menu:
			menu.mostrar_menu(self, get_global_mouse_position())
			print("¡Hiciste clic en:", tipo, "!")
		else:
			print("EvidenciaMenu no encontrado")

func aplicar_accion(accion: String):
	print(estado)
	match accion.to_lower():
		"apagar":
			if estado == "encendido":
				if caracteristicas.get("pierde_datos_al_apagar", false):
					Game_Manager.sumar_puntos(-10)
				estado = "apagado"
				print("%s apagada" % tipo)
		"desconectar":
			if estado == "apagado":
				print("%s desconectada correctamente" % tipo)
				Game_Manager.sumar_puntos(5)
			else:
				print("Error: No puedes desconectar %s encendida" % tipo)
				Game_Manager.sumar_puntos(-5)
		"adquisición encendido":
			if estado == "encendido":
				Game_Manager.sumar_puntos(10)
			else:
				Game_Manager.sumar_puntos(-5)
		"recolectar":
			print("Recolectando %s..." % tipo)
	emit_signal("estado_cambiado", estado)
