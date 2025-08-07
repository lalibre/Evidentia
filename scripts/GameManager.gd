extends Node
class_name GameManager

var puntuacion := 0
var score_label: Label
var log_panel: RichTextLabel
var bitacora_texto := ""

func _ready():
	var scene_root = get_tree().get_root()

	score_label = scene_root.get_node_or_null("GameScene_ComputerOff/UIX/InfoPanel/VBoxContainer/ScoreLabel")
	log_panel = scene_root.get_node_or_null("GameScene_ComputerOff/UIX/InfoPanel/VBoxContainer/ScrollContainer/LogPanel")

	print("score_label:", score_label)
	print("log_panel:", log_panel)
	
func sumar_puntos(valor: int):
	puntuacion += valor
	if score_label:
		score_label.text = str(puntuacion)
		print("Puntaje actualizado en ScoreLabel:", score_label.text)
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
