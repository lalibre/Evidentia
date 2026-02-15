extends Node
class_name GameManager

var evidencias: Array = []
var puntuacion := 0
var evidencias_recolectadas := 0
var aciertos := 0
var fallos := 0

var score_label: Label = null
var log_panel: RichTextLabel = null
var bitacora_texto := ""


enum EstadoEvidencia {
	ENCENDIDO,
	APAGADO,
	DESCONECTADO,
	RECOLECTADO
}

func _ready():
	var scene_root = get_tree().get_current_scene()
	print("scene_root:", scene_root.name)
	#score_label = scene_root.get_node_or_null("UIX/InfoPanel/VBoxContainer/ScoreLabel")
	#log_panel = scene_root.get_node_or_null("UIX/InfoPanel/VBoxContainer/ScrollContainer/LogPanel")
	
	#print("score_label:", score_label)
	#print("log_panel:", log_panel)
	
func cambiar_a_scene_selector():
	var selector_scene = preload("res://Scenes/scene_selector.tscn").instantiate()
	get_tree().current_scene.free()
	get_tree().current_scene = selector_scene
	get_tree().root.add_child(selector_scene)

func registrar_acierto():
	aciertos += 1
	print("✅ Acierto registrado. Total aciertos:", aciertos)

func registrar_fallo():
	fallos += 1
	print("❌ Fallo registrado. Total fallos:", fallos)

func registrar_evidencia_recolectada():
	evidencias_recolectadas += 1
	print("📦 Evidencia recolectada. Total:", evidencias_recolectadas)

func sumar_puntos(valor: int):
	puntuacion += valor
	if score_label:
		score_label.text = str(puntuacion)
		print("Puntaje actualizado en ScoreLabel:", score_label.text)
		print("score_label es:", Game_Manager.score_label, "Tipo:", Game_Manager.score_label.get_class())
	else:
		print("ScoreLabel es null")
	#print("Puntuación actual:", puntuacion)

func registrar_accion(texto: String):
	if log_panel:
		log_panel.append_text("🕵️ " + texto + "\n")
		var entrada := texto + "\n"
		bitacora_texto += entrada
		
func registrar_en_bitacora(mensaje: String) -> void:
	var timestamp = "[" + Time.get_datetime_string_from_system().substr(11, 8) + "]"  # Solo HH:MM:SS
	var entrada = "[color=blue]" + timestamp + "[/color] " + mensaje
	bitacora_texto += entrada
	print("Contenido de bitácora 1:", bitacora_texto)

	if log_panel:
		if log_panel is RichTextLabel:
			print("¡Es un RichTextLabel!")
		else:
			print("❌ No es un RichTextLabel.")
		log_panel.append_text(entrada + "\n")
		log_panel.scroll_to_line(log_panel.get_line_count() - 1)
	else:
		print("❌ log_panel no está enlazado correctamente.")
		
func guardar_bitacora_en_archivo():
	if not log_panel:
		print("Error: log_panel no encontrado.")
		return

	var ruta = "user://bitacora_forense.txt"
	var archivo = FileAccess.open(ruta, FileAccess.WRITE)
	if archivo:
		archivo.store_string(bitacora_texto)
		archivo.close()
		print("Contenido de bitácora:", bitacora_texto)

		print("Bitácora guardada en:", ruta)
	else:
		print("No se pudo guardar la bitácora.")


func puntuacion_final() -> int:
	return aciertos * 10 - fallos * 5
	
func mostrar_resultados_finales():
	# Mostrar un panel con resultados
	print("🎉 Juego terminado")
	print("Puntaje final:", puntuacion)
	var aciertos = 0
	var fallos = 0
	# Supongamos que llevas contadores separados en GameManager
	print("Aciertos:", aciertos)
	print("Fallos:", fallos)
	# Aquí podrías abrir un PopupPanel con esta información
