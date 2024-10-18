extends Node

var coins := 0
var score := 0
var player_life := 3
var whiskys := 0
var pringles := 0
var perfumes := 0
var iphones := 0

var initial_player_position: Vector2

var player = null

var current_checkpoint = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#pass # Replace with function body.
	score = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func respawn_player():
	if current_checkpoint != null:
		player.position = current_checkpoint.global_position
	else:
		player.position = initial_player_position
