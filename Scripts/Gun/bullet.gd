extends Area2D

@export var speed = 800
@export var damge = 20
var travelled_distance = 0

@onready var sprite: Sprite2D = $Sprite2D
@onready var hitbox = $HitBox
@onready var collision = $CollisionShape2D
@onready var collision_timer = $CollisionTimer

func _physics_process(delta):
	const RANGE = 1100
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta
	travelled_distance += speed * delta
	if travelled_distance > RANGE:
		queue_free()

func die():
	sprite.visible = true
	hitbox.set_deferred("monitorable", true)
	collision.set_deferred("disabled", true)
	collision_timer.start()
	

func _on_collision_timer_timeout():
	queue_free()

func _on_body_entered(body):
	die()

