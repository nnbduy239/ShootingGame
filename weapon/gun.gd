extends Node2D

@export var shoot_speed = 5.0
@onready var shoot_speed_timer = $ShootSpeedTimer
var canShoot = true

func _ready():
	shoot_speed_timer.wait_time = 1.0 / shoot_speed
func _process(delta):
	look_at(get_global_mouse_position())
	
func shoot():
	if canShoot:
		canShoot = false
		shoot_speed_timer.start()
		const BULLET = preload("res://weapon/bullet.tscn")
		var new_bullet = BULLET.instantiate()
		new_bullet.global_position = %ShootingPoint.global_position
		new_bullet.global_rotation = %ShootingPoint.global_rotation
		%ShootingPoint.add_child(new_bullet)


func _on_shoot_speed_timer_timeout():
	canShoot = true
