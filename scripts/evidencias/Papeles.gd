# Papel.gd
extends "res://scripts/evidencias/EvidenciaBase.gd"

func procesar_interaccion():
	GameManager.registrar_evento("Recolectó papel")
	GameManager.puntuacion += 2
	queue_free()
