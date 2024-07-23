extends CharacterBody2D
@export var speed = 400
@onready var animation_player = $AnimationPlayer
@onready var gun = $Gun


func _process(delta):
	update_animation()
	
func _physics_process(delta):
	if Input.is_action_pressed("attack"):
		gun.shoot()

	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * speed
	move_and_slide()

func update_animation():
	if velocity.length() > 0.0:
		animation_player.play("run")
	else:
		animation_player.play("idle")
	update_player_facing_direction()

func update_player_facing_direction():
	var mouse_position = get_global_mouse_position()
	if mouse_position.x > global_position.x: 
		$Sprite2D.flip_h = false
	elif mouse_position. x < global_position.x:
		$Sprite2D.flip_h = true
