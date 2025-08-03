extends Control

var current_evidencia: Node = null

func mostrar(evidencia: Node):
	current_evidencia = evidencia
	visible = true

func ocultar():
	visible = false
	current_evidencia = null

func _on_button_pressed(action: String):
	if current_evidencia:
		current_evidencia.ejecutar_accion(action)
	ocultar()

# Conecta cada botón con esta función usando el parámetro
func _ready():
	$Panel/VBoxContainer/Apagar.pressed.connect(func(): _on_button_pressed("apagar"))
	$Panel/VBoxContainer/Desconectar.pressed.connect(func(): _on_button_pressed("desconectar"))
