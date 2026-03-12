extends Area2D
class_name EvidenciaBase

signal estado_cambiado(nuevo_estado)

# 1. Definición estandarizada de estados
enum Estado {
	ENCENDIDO,
	APAGADO,
	DESCONECTADO,
	ADQUISICION_REALIZADA,
	RECOLECTADO,
	REPORTADO,
	EVIDENCIADO
}

@export var tipo : String = ""
# 2. Variable de estado usando el Enum
@export var estado_actual : Estado = Estado.ENCENDIDO

@export var caracteristicas : Dictionary = {
	"pierde_datos_al_apagar": true,
	"es_extraible": false
}

@export var sprite_por_estado : Dictionary = {}
@onready var sprite = $Sprite2D

@onready var cpu_dialog_scene = preload("res://Scenes/CpuMenuDialog.tscn")
var cpu_dialog_instance: Control

func _ready():
	input_pickable = true

# 3. Función central para cambiar estados
func cambiar_estado(nuevo_estado: Estado):
	estado_actual = nuevo_estado
	emit_signal("estado_cambiado", estado_actual)
	print("Estado de ", tipo, " cambiado a: ", Estado.keys()[nuevo_estado])

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		var menu = get_tree().get_current_scene().get_node("EvidenciaMenu")
		if menu:
			# Convertimos el enum a String solo para la UI si es necesario, 
			# o pasamos el entero directamente
			menu.mostrar_menu(self, get_global_mouse_position(), estado_actual)
			print("¡Hiciste clic en:", tipo, "!")
		else:
			print("EvidenciaMenu no encontrado")

# --- Métodos de Diálogo ---

func abrir_dialogo_cpu():
	cpu_dialog_instance = cpu_dialog_scene.instantiate()
	get_tree().current_scene.add_child(cpu_dialog_instance)

func abrir_dialogo_clave():
	var clave_scene = preload("res://Scenes/CpuClaveDialog.tscn")
	var clave_instance = clave_scene.instantiate()
	get_tree().current_scene.add_child(clave_instance)
	clave_instance.connect("clave_correcta", Callable(self, "_on_clave_correcta"))

func _on_clave_correcta():
	abrir_dialogo_cpu()
	cambiar_estado(Estado.ADQUISICION_REALIZADA)
	Game_Manager.registrar_en_bitacora("Clave correcta para adquisición en vivo de %s." % tipo)
	Game_Manager.registrar_acierto()

# --- Lógica de la Máquina de Estados ---

func aplicar_accion(accion: String):
	print("Acción recibida: %s" % accion)
	
	match accion.to_lower():
		"apagar":
			_manejar_apagar()
		"desconectar":
			_manejar_desconectar()
		"adquisición":
			_manejar_adquisicion()
		"recolectar":
			_manejar_recolectar()
		"reportar":
			_manejar_reportar()

# Métodos privados de lógica para mantener limpio el match
func _manejar_apagar():
	print(estado_actual)
	if estado_actual == Estado.ENCENDIDO:
		if caracteristicas.get("pierde_datos_al_apagar", false):
			Game_Manager.registrar_en_bitacora("Se apagó %s y se perdieron datos." % tipo)
			Game_Manager.registrar_fallo()
	else:	
		Game_Manager.registrar_en_bitacora("Se apagó %s sin pérdida de datos." % tipo)
		Game_Manager.registrar_acierto()
	cambiar_estado(Estado.APAGADO)

func _manejar_desconectar():
	if estado_actual == Estado.APAGADO:
		Game_Manager.registrar_acierto()
		Game_Manager.registrar_en_bitacora("Se desconectó %s correctamente." % tipo)
		cambiar_estado(Estado.DESCONECTADO)
	else:
		Game_Manager.registrar_en_bitacora("Error: Intento de desconectar %s sin apagar." % tipo)
		Game_Manager.registrar_fallo()

func _manejar_adquisicion():
	if estado_actual == Estado.ENCENDIDO:
		if tipo == "CPU":
			abrir_dialogo_clave()
		else:
			Game_Manager.registrar_en_bitacora("Adquisición en vivo (foto) de %s realizada." % tipo)
			cambiar_estado(Estado.ADQUISICION_REALIZADA)
	else:
		Game_Manager.registrar_fallo()

func _manejar_recolectar():
	if estado_actual == Estado.EVIDENCIADO:
		Game_Manager.registrar_fallo()
		Game_Manager.registrar_en_bitacora("Se recolectó %s sin reporte previo." % tipo)
	else:
		Game_Manager.registrar_en_bitacora("La evidencia %s ha sido recolectada oportunamente." % tipo)		
		Game_Manager.registrar_acierto()
	
	Game_Manager.registrar_evidencia_recolectada()
	cambiar_estado(Estado.RECOLECTADO)

func _manejar_reportar():
	Game_Manager.registrar_en_bitacora("Reportando evidencia %s a policía forense." % tipo)
	Game_Manager.registrar_acierto()
	cambiar_estado(Estado.REPORTADO)
