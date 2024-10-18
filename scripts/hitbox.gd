extends Area2D
@onready var died: AudioStreamPlayer2D = $"../died"
@onready var collect: AudioStreamPlayer2D = $"../collect"


func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		died.play()
		collect.play()
		body.velocity.y = -body.jump_velocity
		owner.anim.play("hurt")
