extends Node

@onready var dialog_box_scene = preload("res://prefabs/dialog_box.tscn")
var message_lines : Array[String] = []
var current_line = 0

var dialog_box: MarginContainer = null
var dialog_box_position := Vector2.ZERO

var is_message_active := false
var can_advance_message := false

func start_message (position: Vector2, lines: Array[String]):
	if is_message_active:
		return
	
	message_lines = lines
	current_line = 0
	dialog_box_position = position
	is_message_active = true
	can_advance_message = false
	
	show_text()
	
func show_text():
	if dialog_box:
		dialog_box.queue_free()
	
	dialog_box = dialog_box_scene.instantiate()
	dialog_box.text_display_finished.connect(_on_all_text_displayed)
	get_tree().root.add_child(dialog_box)
	dialog_box.global_position = dialog_box_position
	
	dialog_box.display_text(message_lines[current_line])
	can_advance_message = false
	
func _on_all_text_displayed():
	can_advance_message = true
	
func _unhandled_input(event):
	if(event.is_action_pressed("advance_message") && is_message_active && can_advance_message):
		current_line +=1
		if current_line >= message_lines.size():
			dialog_box.queue_free()
			dialog_box = null
			is_message_active = false
			return
			
		show_text()
