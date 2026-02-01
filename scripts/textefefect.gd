extends Label

var full_text = "Este es el texto que aparecerá como si se escribiera..."
var char_index = 0
var typing_speed = 0.05 # segundos entre letras

func _ready():
	text = ""
	$Timer.wait_time = typing_speed
	$Timer.start()

func _on_Timer_timeout():
	if char_index < full_text.length() - 1 :
		text += full_text[char_index]
		char_index += 1
	else:
		$Timer.stop()
