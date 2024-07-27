extends CharacterBody2D

@export var speed = 400
@export var stats : Stats

@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var death_animation = $DeathAnimation
@onready var gun = $Gun
@onready var collision = $CollisionShape2D
@onready var timer = $Timer
@onready var health_bar = $HealthBar
@onready var hurt_box =$HurtBox

var is_alive = true

func _ready():
	health_bar.init_health(stats.max_health)	
	stats.health = stats.max_health

func _process(delta):
	update_animation()
	
func _physics_process(delta):
	if is_alive:
		if Input.is_action_pressed("attack"):
			gun.shoot()
		var direction = Input.get_vector("move_left","move_right","move_up","move_down")
		velocity = direction * speed
		move_and_slide()

func update_animation():
	if velocity.length() > 0.0:
		animation_player.play("walk")
	else:
		animation_player.play("idle")
	update_player_facing_direction()

func update_player_facing_direction():
	var mouse_position = get_global_mouse_position()
	if mouse_position.x > global_position.x: 
		sprite.flip_h = false
	elif mouse_position. x < global_position.x:
		sprite.flip_h = true

func _on_hurt_box_area_entered(area):
	if not area.is_in_group("player"):
		if stats.health >= 0:
			health_bar.health = stats.health
		else:
			is_alive = false
			health_bar.visible = false
			death_animation.play("death")
			timer.start()			

func _on_timer_timeout():
	get_tree().paused = true
	print("death")
