extends Combatant


func _ready() -> void:
	print("enemy script loaded")


func set_active(value: bool) -> void:
	.set_active(value)
	if not is_active:
		return
	$Timer.start()
	yield($Timer, "timeout")
	var target: Combatant
	for actor in get_parent().get_children():
		if not actor == self:
			target = actor
			break
	attack(target)
