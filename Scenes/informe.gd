extends Control
@onready var aciertos = $Panel/AciertosValue
@onready var fallos = $Panel/FallosValue
@onready var score = $Panel/PuntuacionValue
@onready var texto = $Panel/TextoInforme
@onready var evaluacion = $Panel/Evaluacion

#@onready var evaluacion_lbl = $Infore/LabelEvaluacion

func _ready():
	aciertos.text = ""
	fallos.text = ""
	score.text = ""
	evaluacion.text = ""
	texto.text = ""
	_actualizar_resultado()
	
func _actualizar_resultado():
	var total_aciertos = Game_Manager.aciertos
	var total_fallos = Game_Manager.fallos
	var evidencias = Game_Manager.registrar_evidencia_recolectada
	var total_acciones = Game_Manager.acciones
	var total_acciones_posibles = Game_Manager.total_acciones_posibles
	
	print(total_acciones_posibles)
	aciertos.text =  str(total_aciertos)
	fallos.text = str(total_fallos)
	
	var puntuacion: float = 0.0
	if total_acciones_posibles > 0:
		puntuacion = round((total_aciertos / float(total_acciones_posibles)) * 10)

	score.text = str(puntuacion)		
	evaluacion.text = evaluar(puntuacion)

func evaluar(puntos: float) -> String:
	var errores_criticos = Game_Manager.errores_criticos

	if errores_criticos > 0:
		return "Análisis erróneo.\nEvidencia inadmisible en juicio."
	else:
		if puntos == 0:
			return "No realizó análisis"
		if puntos == 10:
			return "Excelente análisis forense."
		elif puntos >= 8:
			return "Desempeño aceptable,\naunque hubo errores."
		else:
			return "Análisis regular.\nLa evidencia pudo verse comprometida."


func _on_pressed() -> void:
	var ruta = "user://bitacora_forense.txt"

	if FileAccess.file_exists(ruta):
		var archivo = FileAccess.open(ruta, FileAccess.READ)
		var contenido = archivo.get_as_text()
		archivo.close()
		texto.text = contenido
	else:
		texto.text = "No se encontró el reporte."
