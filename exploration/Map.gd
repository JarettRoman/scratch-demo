extends Node2D


func _ready():
	pass


func _on_CombatStartButton_pressed() -> void:
	var err = get_tree().change_scene('res://combat/Combat.tscn')
	if err:
		print(err)
