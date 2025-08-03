# GameManager.gd
extends Node

var puntuacion_total : int = 0
var inventario : Array[String] = []
var bitacora : Array[String] = []

signal inventario_actualizado()
signal puntuacion_actualizada()
signal bitacora_actualizada()

func registrar_evento(evento: String):
	bitacora.append(evento)
	print(evento)

func agregar_a_inventario(nombre: String):
	if nombre in inventario:
		return
	inventario.append(nombre)
	bitacora.append("Recolectado: %s" % nombre)
	emit_signal("inventario_actualizado")
	emit_signal("bitacora_actualizada")

func modificar_puntuacion(valor: int, motivo: String = ""):
	puntuacion_total += valor
	if motivo != "":
		bitacora.append("Puntos %d: %s" % [valor, motivo])
	emit_signal("puntuacion_actualizada")
	emit_signal("bitacora_actualizada")
