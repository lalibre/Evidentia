extends Control
@onready var aciertos = $Panel/AciertosValue
@onready var fallos = $Panel/FallosValue
@onready var evidencias = $Panel/Puntuacion
@onready var texto = $Panel/TextoInforme

#@onready var evaluacion_lbl = $Infore/LabelEvaluacion

func _ready():
	var total_aciertos = Game_Manager.aciertos
	var total_fallos = Game_Manager.fallos
	var evidencias = Game_Manager.registrar_evidencia_recolectada

	aciertos.text =  str(total_aciertos)
	fallos.text = str(total_fallos)
	#evidencias.text = "Puntuación final: %d" % evidencias

	#evaluacion.text = evaluar(puntuacion)

func evaluar(puntos: int) -> String:
	if puntos >= 80:
		return "Excelente análisis forense."
	elif puntos >= 50:
		return "Buen trabajo, aunque hubo errores."
	else:
		return "Análisis deficiente. La evidencia pudo verse comprometida."


func _on_pressed() -> void:
	var ruta = "user://bitacora_forense.txt"

	if FileAccess.file_exists(ruta):
		var archivo = FileAccess.open(ruta, FileAccess.READ)
		var contenido = archivo.get_as_text()
		archivo.close()
		texto.text = contenido
	else:
		texto.text = "No se encontró el reporte."
