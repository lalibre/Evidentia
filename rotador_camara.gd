extends Node3D

var h_sensibilidad := 0.005
var v_sensibilidad := 0.005
var rotando := false

@onready var camara = $Camera3D  # Ajusta si tu cámara tiene otro nombre

func _input(event):
	print("Has presionado el botón izquierdo")
	# Detectar si presionas botón izquierdo
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			rotando = event.pressed
	
	# Si mueves el mouse y estamos rotando
	if event is InputEventMouseMotion and rotando:
		# Rotar en eje Y (horizontal)
		rotate_y(-event.relative.x * h_sensibilidad)
		
		# Rotar cámara en eje X (vertical)
		camara.rotate_x(-event.relative.y * v_sensibilidad)
		
		# Limitar inclinación vertical (opcional)
		var rot_x = clamp(camara.rotation.x, deg_to_rad(-60), deg_to_rad(60))
		camara.rotation.x = rot_x
