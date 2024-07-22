extends CharacterBody2D

func _process(delta):
	if velocity.x > 0.0:
		$AnimationPlayer.play("run_right")
	elif velocity.x < 0.0:
		$AnimationPlayer.play("run_left")
	elif velocity.y > 0.0:
		$AnimationPlayer.play("run_down")
	elif velocity.y < 0.0:
		$AnimationPlayer.play("run_up")
	else:
		$AnimationPlayer.play("idle")
func _physics_process(delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * 400
	move_and_slide()
