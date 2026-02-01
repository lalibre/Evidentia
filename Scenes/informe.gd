extends Control

@onready var aciertos_lbl = $Infore/Aciertos
@onready var fallos_lbl = $Infore/Fallos
@onready var puntuacion_lbl = $Infore/Puntuacion
#@onready var evaluacion_lbl = $Infore/LabelEvaluacion

func _ready():
	var aciertos = Game_Manager.aciertos
	var fallos = Game_Manager.fallos
	var puntuacion = Game_Manager.puntuacion_final

	aciertos_lbl.text = "Aciertos: %d" % aciertos
	fallos_lbl.text = "Fallos: %d" % fallos
	puntuacion_lbl.text = "Puntuación final: %d" % puntuacion

	#evaluacion_lbl.text = evaluar(puntuacion)

func evaluar(puntos: int) -> String:
	if puntos >= 80:
		return "Excelente análisis forense."
	elif puntos >= 50:
		return "Buen trabajo, aunque hubo errores."
	else:
		return "Análisis deficiente. La evidencia pudo verse comprometida."
