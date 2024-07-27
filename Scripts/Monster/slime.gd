extends CharacterBody2D

@export var stats : Stats

@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var player_detection_zone = $PlayerDetectedZone
@onready var state_machine = $StateMachine
@onready var health_bar = $HealthBar
@onready var hurt_box =$HurtBox
@onready var collision = $CollisionShape2D
@onready var timer = $Timer


func _ready():
	health_bar.init_health(stats.max_health)	
	stats.health = stats.max_health


func _physics_process(delta):
	move_and_slide()
func _on_hurt_box_area_entered(area):
	if not area.is_in_group("enemies"):
		if stats.health >= 0 :
			health_bar.health = stats.health
		else:
			health_bar.visible = false
			state_machine.on_child_transition(state_machine.current_state, "Death")

func _on_timer_timeout():
	queue_free()


