extends Node2D

onready var enemy: Node2D = $Combatants/Ghost

func _on_Attack_button_up() -> void:
	var new_health: int = enemy.health - 1
	enemy.set_health(new_health)


