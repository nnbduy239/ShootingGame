extends CharacterBody2D

@export var stats : Stats

@onready var animation_player = $AnimationPlayer
@onready var timer = $Timer
func _ready():
    stats.health = stats.max_health

func _physics_process(delta):
    move_and_slide()


func _on_hurt_box_area_entered(area):
    if not area.is_in_group("enemies"):
        animation_player.play("hit")
        if stats.health <= 0:
            animation_player.play("death")
            timer.start()


func _on_timer_timeout():
    queue_free()
