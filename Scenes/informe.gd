extends Control
@onready var aciertos = $Panel/AciertosValue
@onready var fallos = $Panel/FallosValue
@onready var score = $Panel/PuntuacionValue
@onready var texto = $Panel/TextoInforme
@onready var evaluacion = $Panel/Evaluacion

#@onready var evaluacion_lbl = $Infore/LabelEvaluacion

func _ready():
	var total_aciertos = Game_Manager.aciertos
	var total_fallos = Game_Manager.fallos
	var evidencias = Game_Manager.registrar_evidencia_recolectada
	var total_acciones = Game_Manager.acciones
	var total_acciones_posibles = Game_Manager.total_acciones_posibles
	
	aciertos.text =  str(total_aciertos)
	fallos.text = str(total_fallos)
	
	var puntuacion = round((total_aciertos / float(total_acciones_posibles)) * 10)
	evaluacion.text = evaluar(puntuacion)
	print(puntuacion)
	score.text = str(puntuacion)

func evaluar(puntos: float) -> String:
	var errores_criticos = Game_Manager.errores_criticos

	if errores_criticos > 0:
		return "Análisis deficiente. Evidencia inadmisible en juicio."
	else:
		if puntos == 10:
			return "Excelente análisis forense."
		elif puntos >= 7:
			return "Desempeño aceptable, aunque hubo errores."
		else:
			return "Análisis regular. La evidencia pudo verse comprometida."


func _on_pressed() -> void:
	var ruta = "user://bitacora_forense.txt"

	if FileAccess.file_exists(ruta):
		var archivo = FileAccess.open(ruta, FileAccess.READ)
		var contenido = archivo.get_as_text()
		archivo.close()
		texto.text = contenido
	else:
		texto.text = "No se encontró el reporte."
