# USB.gd
extends "res://scripts/evidencias/EvidenciaBase.gd"

func procesar_interaccion():
	if estado == "conectada":
		GameManager.registrar_evento("Desconectó USB sin desmontar")
		GameManager.puntuacion -= 3
		estado = "desconectada"
	elif estado == "desconectada":
		GameManager.registrar_evento("Intentó usar USB desconectada")
	emit_signal("estado_cambiado", estado)
