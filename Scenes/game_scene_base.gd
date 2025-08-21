extends Control

@export var cpu_encendida := false  # editable desde código

func _ready():
	if cpu_encendida:
		print("💡 CPU encendida")
		# Cambia imagen o muestra elementos que representan CPU ON
	else:
		print("💤 CPU apagada")
		# Cambia imagen o desactiva elementos
