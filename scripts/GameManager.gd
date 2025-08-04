extends Node
class_name GameManager

var puntuacion := 0
var score_label: Label
var log_panel: RichTextLabel

func _ready():
	var scene_root = get_tree().get_root()

	score_label = scene_root.get_node_or_null("GameScene_ComputerOff/UIX/InfoPanel/VBoxContainer/ScoreLabel")
	log_panel = scene_root.get_node_or_null("GameScene_ComputerOff/UIX/InfoPanel/VBoxContainer/LogPanel")

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

func registrar_en_bitacora(mensaje: String) -> void:
	if log_panel:
		log_panel.append_text("- " + mensaje + "\n")
		log_panel.append_text("📝 Bitácora inicializada...\n")
		print(log_panel)
	else:
		print("❌ log_panel no está enlazado correctamente.")
