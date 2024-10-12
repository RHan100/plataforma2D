extends CharacterBody2D


const SPEED = 200.0
const JUMP_FORCE = -400.0

@onready var damage: AudioStreamPlayer2D = $damage
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping := false
var is_hurted := false
var knockback_vector := Vector2.ZERO
var direction
@onready var marker_2d: Marker2D = $Marker2D

@onready var animation:= $animated as AnimatedSprite2D
#@onready var remote_transform := $remote as RemoteTransform2D

signal player_has_died()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_FORCE
		is_jumping = true
	elif is_on_floor():
		is_jumping = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED
		animation.scale.x = direction
		if !is_jumping:
			animation.play("run")
	elif is_jumping:
		animation.play("jump")	
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animation.play("idle")

	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector
	
	move_and_slide()


func _on_hurtbox_body_entered(body: Node2D) -> void:
	#if body.is_in_group("piranhitas"):
		#queue_free()
	if $ray_right.is_colliding():
		take_damage(Vector2(-200,-200))
	elif $ray_left.is_colliding():
		take_damage(Vector2(200,-200))
		
		#func follow_camera(camera):
			#var camera_path = camera.get_path()
			#remote_transform.remote_path = camera_path
func take_damage(knockback_force := Vector2.ZERO, duration := 0.25):
	
	if Globals.player_life > 0:
		Globals.player_life -=1
	if Globals.player_life == 0:
		queue_free()
		emit_signal("player_has_died")  

	if knockback_force != Vector2.ZERO:
		knockback_vector = knockback_force
		
		var knockback_tween := get_tree().create_tween()
		knockback_tween.parallel().tween_property(self,"knockback_vector",Vector2.ZERO,duration)
		animation.modulate = Color(1,0,0,1)
		damage.play()
		knockback_tween.parallel().tween_property(animation, "modulate", Color(1,1,1,1), duration)

		is_hurted = true
		await get_tree().create_timer(.3).timeout
		is_hurted = false


		
