extends Node2D
class_name Combatant

export var health: int = 100
export var max_health: int = health
export var is_ally: bool = false

onready var hp_label: Label = $HP
onready var _animated_sprite: AnimatedSprite = $AnimatedSprite
onready var _animation_player: AnimationPlayer = $AnimationPlayer

signal health_changed(health)
signal health_depleted


func _ready() -> void:
	if not is_ally:
		_animated_sprite.flip_h = true
	hp_label.text = str(health) + "HP"
	_animated_sprite.play("idle")


func set_health(new_health: int) -> void:
	health = clamp(new_health, 0, max_health) as int
	hp_label.text = str(health) + "HP"
	if health == 0:
		emit_signal("health_depleted")
		die()
		return
	emit_signal("health_changed", health)


func die() -> void:
	_animation_player.play("die")
	yield(_animation_player, "animation_finished")
	queue_free()
