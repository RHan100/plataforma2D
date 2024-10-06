extends Control

@onready var score_label: Label = $VBoxContainer/score_label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score_label.text = "Pontuação: %d" % Globals.score


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_restart_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/world.tscn")
	Globals.score = 0
	Globals.coins = 0
	Globals.diamonds = 0


func _on_quit_btn_pressed() -> void:
	get_tree().quit()
