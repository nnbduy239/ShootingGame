extends CharacterBody2D

@export var speed = 600
@export var stats : Stats

@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var death_animation = $DeathAnimation
@onready var gun = $Gun
@onready var collision = $CollisionShape2D
@onready var timer = $Timer
@onready var health_bar = $HealthBar
@onready var hurt_box =$HurtBox
@onready var raycast = $RayCast2D
@onready var sprite_2d = $Sprite2D
@onready var nav_agent = $NavigationAgent2D
@onready var gun_shoot = $GunShoot

var is_alive = true
var target_position = Vector2()

func _ready():
	health_bar.init_health(stats.max_health)	
	stats.health = stats.max_health
	target_position = global_position
	raycast.enabled = true
	nav_agent.max_speed = speed
func _process(delta):
	update_animation(delta)
	update_raycast()

func _physics_process(delta):
	if is_alive:
		if Input.is_action_pressed("shoot"):
			#if raycast.is_colliding():
				#var collider = raycast.get_collider()
				#if collider and collider.is_in_group("enemies"):
			gun.shoot()
			gun_shoot.play()
		if Input.is_action_pressed("left_click"):
			target_position = get_global_mouse_position()
			#nav_agent.set_target_position(target_position)
			nav_agent.target_position = target_position
		if  not nav_agent.is_navigation_finished():
			var direction = nav_agent.get_next_path_position() - global_position
			velocity = direction.normalized() * speed
		else:
			velocity = Vector2() 
		
		move_and_slide()


func update_animation(delta):
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
func update_raycast():
	raycast.global_position = global_position
	raycast.target_position = get_global_mouse_position() - global_position

func _on_hurt_box_area_entered(area):
	if not area.is_in_group("player"):
		if stats.health >= 0:
			health_bar.health = stats.health
		else:
			is_alive = false
			health_bar.visible = false
			death_animation.play("death")
			hurt_box.visible = false
			timer.start()			

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Scenes/UI/GameOver.tscn")


