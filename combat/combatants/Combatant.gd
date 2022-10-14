extends Node2D
class_name Combatant

export var health: int = 100
export var max_health: int = health
export var is_ally: bool = false
export var is_active: bool = false setget set_active

onready var hp_label: Label = $HP
onready var _animated_sprite: AnimatedSprite = $AnimatedSprite
onready var _animation_player: AnimationPlayer = $AnimationPlayer

signal health_updated(health)
signal max_health_updated(max_health)
signal health_depleted
signal turn_finished


func _ready() -> void:
	if not is_ally:
		_animated_sprite.flip_h = true
	hp_label.text = str(health) + "HP"
	emit_signal("health_updated", health)
	emit_signal("max_health_updated", max_health)
	_animated_sprite.play("idle")


func set_health(new_health: int) -> void:
	health = clamp(new_health, 0, max_health) as int
	hp_label.text = str(health) + "HP"
	emit_signal("health_updated", health)
	if health <= 0:
		emit_signal("health_depleted")


# sets if combatant is active (meaning its their turn in combat).
# we can probably setup a signal to check for ability timings.
# Ex: abilities/effects that go off at the beginning of a turn
# like poison damage, or turn counting?
func set_active(value: bool) -> void:
	is_active = value
	set_process(value)
	set_process_input(value)


func attack(target: Combatant) -> void:
	# we'd put a damage calculation here at some point
	target.take_damage(5)
	emit_signal("turn_finished")


# logic for dealing damage to combatant.
# EX: when attacking, you're gonna call the target's take_damage to take
# whatever calculated damage is to be inflicted on the target's health
func take_damage(damage: int) -> void:
	set_health(health - damage)


func die() -> void:
	_animation_player.play("die")
	yield(_animation_player, "animation_finished")
	queue_free()
