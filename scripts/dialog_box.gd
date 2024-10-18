extends MarginContainer

@onready var letter_time_display: Timer = $letter_time_display
@onready var text_label: Label = $label_margin/text_label
@onready var dismiss_dialog: Timer = $dismiss_dialog

@export var dismiss_time := 1.5

var dialog_dismissed = false

const MAX_WIDTH = 256

var text = ""
var letter_index = 0

var letter_display_timer := 0.07
var space_display_timer := 0.05
var punctuation_display_timer := 0.2

signal text_display_finished()
signal dismiss_dialog_box()

func _ready() -> void:
	dismiss_dialog.timeout.connect(_on_dismiss_dialog_timeout)

func display_text(text_to_display: String):
	text = text_to_display
	letter_index = 0
	text_label.text = text_to_display
	
	await resized
	
	custom_minimum_size.x = min(size.x, MAX_WIDTH)
	
	if size.x >MAX_WIDTH:
		text_label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized
		await resized
		custom_minimum_size.y = size.y
		global_position.x -= size.x/2
		global_position.y -= size.y + 24
	
	text_label.text = ""
	
	display_letter()
		
func display_letter():
	
	if letter_index >= text.length():
		if not dialog_dismissed:
			dialog_dismissed = true
			dismiss_dialog.start(dismiss_time)  # Inicia o timer
			emit_signal("text_display_finished")
		return
	
	text_label.text += text[letter_index]
	
	match text[letter_index]:
		"!", "?", ",", ".":
			letter_time_display.start(punctuation_display_timer)
		" ":
			letter_time_display.start(space_display_timer)
		_:
			letter_time_display.start(letter_display_timer)
	letter_index +=1
		
func _on_letter_time_display_timeout() -> void:
	display_letter()

func _on_dismiss_dialog_timeout() -> void:
	emit_signal("dismiss_dialog_box")
