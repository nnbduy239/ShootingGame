extends CharacterBody2D
@export var speed = 400

func _process(delta):
	update_animation()
	
func _physics_process(delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * speed
	move_and_slide()
func update_animation():
	if velocity.length() > 0.0:
		$AnimationPlayer.play("run")
		$Sprite2D.flip_h = velocity.x < 0
		$Gun/WeaponPivot/Pistol.flip_h = velocity.x < 0
	else:
		$AnimationPlayer.play("idle")

