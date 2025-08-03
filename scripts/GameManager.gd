extends Node
class_name GameManager

var puntuacion := 0

func sumar_puntos(valor: int):
	puntuacion += valor
	print("Puntuación actual:", puntuacion)
