extends Control

@onready var clave_input = $Panel/TextureRect/CenterContainer/VBoxContainer/ClaveInput
signal clave_correcta

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_iniciar_sesion_pressed() -> void:
	if clave_input.text == "X49B":
		emit_signal("clave_correcta")
		queue_free()
	else:
		$Panel/TextureRect/CenterContainer/VBoxContainer/MensajeLabel.text = "❌ Clave incorrecta"

func _on_cancelar_pressed() -> void:
	emit_signal("clave_cancelada")
	queue_free()
