extends Area2D

var diamonds := 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	$anim.play("collect")
	await $collision.call_deferred("queue_free")
	Globals.diamonds += diamonds

func _on_anim_animation_finished() -> void:
	queue_free()