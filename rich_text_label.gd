extends RichTextLabel

@export var full_text: String = "Like and suscripbe"
@export var typing_duration:float = 2.0
# Called when the node enters the scene tree for the first time.
@onready var _sfx: AudioStreamPlayer = get_node_or_null("AudioStreamPlayer")
var _full_text: String = ""

func _ready():
	#text = full_text
	visible_ratio = 0.0
	if not _full_text.is_empty():
		start_typing(_full_text)
	
func start_typing(new_text: String):
	# Llamar a esta función desde fuera para cambiar el texto
	_full_text = new_text
	text = _full_text
	visible_ratio = 0.0
		
	# Inicia el sonido
	if _sfx.stream:
		_sfx.play()
		
	var tween = create_tween()
	tween.tween_property(self, "visible_ratio", 1.0, typing_duration).from(0)
	
	# Cuando termine, detenemos el sonido
	tween.tween_callback(Callable(self, "_stop_sound")).set_delay(typing_duration)

func _stop_sound():
	if _sfx.playing:
		_sfx.stop()
