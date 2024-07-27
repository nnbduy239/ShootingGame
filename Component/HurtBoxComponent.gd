class_name HurtBox
extends Area2D


func _init():
	collision_layer = 0
	collision_mask = 4

func _ready():
	connect("area_entered", self._on_area_entered)

func _on_area_entered(area):
	if owner.is_in_group("enemies"):
		if not area.is_in_group("enemies"):
			owner.stats.health -= area.damage
	else:
		owner.stats.health -= area.damage
	#if owner.is_in_group("player"):
		#owner.stats.health -= area.damage
