extends Area2D
class_name EvidenciaBase

signal estado_cambiado(nuevo_estado)

@export var tipo : String = ""
@export var estado : String = ""
@export var caracteristicas : Dictionary = {
	"pierde_datos_al_apagar": true,
	"es_extraible": false
}
# Precargar la escena del diálogo
@onready var cpu_dialog_scene = preload("res://Scenes/CpuMenuDialog.tscn")
var cpu_dialog_instance: Control


func _ready():
	input_pickable = true
	#print("EvidenceBase ready")

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		#if estado == "recolectado":
		#	mostrar_mensaje("Esta evidencia ya fue recolectada. No se puede realizar más acciones.")
		#return
		
		# Validar si está desconectada (para abrir puzzle de recolectar)
		if estado == "desconectado":
			abrir_dialogo_recolectar()
		else:
			# Abrir el menú de acciones normal
			var menu = get_tree().get_current_scene().get_node("EvidenciaMenu")
			if menu:
				menu.mostrar_menu(self, get_global_mouse_position(), estado)
				print("¡Hiciste clic en:", tipo, "!")
			else:
				print("EvidenciaMenu no encontrado")

func mostrar_mensaje(texto: String):
	var dialog = AcceptDialog.new()
	get_tree().current_scene.add_child(dialog)
	dialog.dialog_text = texto
	dialog.popup_centered()

# Función que abre un diálogo o puzzle de recolectar
func abrir_dialogo_recolectar():
	# Precargar la escena del puzzle de recolectar
	var puzzle_scene = preload("res://Scenes/options.tscn")
	var puzzle_instance = puzzle_scene.instantiate()

	# Añadir al nodo raíz de la escena actual
	get_tree().current_scene.add_child(puzzle_instance)

	# Opcional: centrar el diálogo en la pantalla
	#if puzzle_instance is WindowDialog:
	#	puzzle_instance.popup_centered()
func abrir_dialogo_cpu():
	print("llega")
	#if not cpu_dialog_instance:
	print("entra")
	cpu_dialog_instance = cpu_dialog_scene.instantiate()
	get_tree().current_scene.add_child(cpu_dialog_instance)
	#cpu_dialog_instance.mostrar(self, get_global_mouse_position())

func abrir_dialogo_clave():
	var clave_scene = preload("res://Scenes/CpuClaveDialog.tscn")
	var clave_instance = clave_scene.instantiate()
	get_tree().current_scene.add_child(clave_instance)

	# Conecta la señal para saber si fue validada
	clave_instance.connect("clave_correcta", Callable(self, "_on_clave_correcta"))

func _on_clave_correcta():
	abrir_dialogo_cpu()
	Game_Manager.registrar_en_bitacora("El usuario ingresó la clave correctamente para adquirir en vivo.")


func aplicar_accion(accion: String):
	print("Esta es la accion: %s" %accion)
	match accion.to_lower():
		"apagar":
			if estado == "encendido":
				if caracteristicas.get("pierde_datos_al_apagar", false):
					Game_Manager.sumar_puntos(-10)
					Game_Manager.registrar_en_bitacora("Se apagó %s y se perdieron datos." % tipo)
					Game_Manager.registrar_fallo()
			else:
				Game_Manager.registrar_en_bitacora("Se apagó %s sin pérdida de datos." % tipo)
				Game_Manager.registrar_accion("Se apagó %s sin pérdida de datos." % tipo)
				Game_Manager.registrar_acierto()
			estado = "apagado"				
		"desconectar":
			if estado == "apagado":
				Game_Manager.registrar_acierto()				
				Game_Manager.registrar_en_bitacora("Se desconectó %s correctamente." % tipo)
				estado = "desconectado"
			else:
				Game_Manager.registrar_en_bitacora("Error: Se intentó desconectar %s encendida." % tipo)	
				Game_Manager.registrar_fallo()		
		"adquisición encendido":
			if estado == "encendido":
				 # Abrir el diálogo de CPU para seleccionar las sub-acciones
				abrir_dialogo_clave()
				Game_Manager.registrar_en_bitacora("Se hizo adquisición de %s encendida." % tipo)
				Game_Manager.registrar_acierto()
			else:
				Game_Manager.registrar_fallo()
		"recolectar":
			if estado == "evidenciado":
				Game_Manager.registrar_fallo()
			else:
				Game_Manager.registrar_acierto()	
			Game_Manager.registrar_en_bitacora("Recolectando  %s" % tipo)
			Game_Manager.registrar_evidencia_recolectada()
			estado = "recolectado"
		"reportar":
			Game_Manager.registrar_en_bitacora("Reportando al policia forense la evidencia %s" % tipo)
			estado = "reportado"
			Game_Manager.registrar_acierto()
	emit_signal("estado_cambiado", estado)
