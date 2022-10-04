extends Node2D
class_name Combatant

onready var hp_label: Label = $HP
onready var animated_sprite: AnimatedSprite = $AnimatedSprite

export var health = 100
export var is_ally: bool = false

signal health_changed(health)
signal health_depleted


func _ready() -> void:
	if not is_ally:
		animated_sprite.flip_h = true
	hp_label.text = str(health) + "HP"
	animated_sprite.play("idle")


func set_health(new_health: int) -> void:
	health = new_health
	if health <= 0:
		emit_signal("health_depleted")
		queue_free()
		return
	hp_label.text = str(health) + "HP"
	emit_signal("health_changed", health)
