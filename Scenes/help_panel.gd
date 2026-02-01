extends ColorRect

signal message_finished

@onready var label = $VBoxContainer/Label
@onready var timer = $VBoxContainer/Timer

var typing_speed := 0.02
var is_typing := false
var message_queue := []
var is_showing := false

func show_message(text: String, duration := 3.5):
	if is_showing:
		message_queue.append([text, duration])
	else:
		_display_message(text, duration)


func _display_message(text: String, duration: float):
	is_showing = true
	is_typing = true
	label.text = ""
	self.modulate.a = 0.0
	show()

	# Fade In
	var fade_in = create_tween()
	fade_in.tween_property(self, "modulate:a", 1.0, 0.25)
	await fade_in.finished

	# Efecto Typing
	for i in range(text.length()):
		label.text += text[i]
		await get_tree().create_timer(typing_speed).timeout

	is_typing = false
	timer.start(duration)


func _on_Timer_timeout():
	# Fade out
	var fade_out = create_tween()
	fade_out.tween_property(self, "modulate:a", 0.0, 0.3)
	await fade_out.finished
	hide()

	is_showing = false

	# Emitir señal para desbloquear interacción
	emit_signal("message_finished")

	# Si hay mensajes en cola → mostrarlos
	if message_queue.size() > 0:
		var next = message_queue.pop_front()
		_display_message(next[0], next[1])
