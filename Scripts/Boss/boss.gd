extends CharacterBody2D

@export var stats : Stats

@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var player_detection_zone = $PlayerDetectedZone
@onready var hit_animaiton  = $HitAnimation
@onready var collision = $CollisionShape2D
@onready var timer = $Timer
@onready var state_machine = $StateMachine

func _ready():
	stats.health = stats.max_health

func _physics_process(delta):
	move_and_slide()
func _on_hurt_box_area_entered(area):
	if not area.is_in_group("enemies"):
		hit_animaiton.play("RESET")
		if stats.health <= 0:
			state_machine.on_child_transition(state_machine.current_state, "Death")
func _on_timer_timeout():
	queue_free()
