extends Area2D

var pringles := 1
@export var cost := 2
@export var score_worth := 50
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	#$anim.play("collect")
	if (Globals.coins >= cost):
		Globals.coins -= cost
		Globals.score += score_worth
		Globals.pringles += pringles
		queue_free()
	
	#await $collision.call_deferred("queue_free")
#
#func _on_anim_animation_finished() -> void:
	#queue_free()
