extends Node3D

# Sensibilidad rotación y límites de zoom
var h_sensibilidad := 0.005
var min_dist := 2.0
var max_dist := 10.0
var rotation_y := 0.0
var rotation_speed := 0.005
# Distancia actual cámara al nodo padre
var distancia := 5.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	actualizar_posicion()

func _input(event):
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		rotation_y -= event.relative.x * rotation_speed
		# Limitar la rotación entre -90 y 90 grados (en radianes)
		rotation_y = clamp(rotation_y, deg_to_rad(-90), deg_to_rad(90))
		rotation.y = rotation_y

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			distancia = max(min_dist, distancia - 0.5)
			actualizar_posicion()
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			distancia = min(max_dist, distancia + 0.5)
			actualizar_posicion()


func actualizar_posicion():
	# Mueve la cámara adelante/atrás en Z
	var cam = $Camera3D
	cam.position = Vector3(0, 7, distancia)
