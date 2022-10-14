extends Node
class_name TurnQueue

# queue for storing entities
var queue: Array = [] setget set_queue, get_queue
var active_combatant = null setget _set_active_combatant

signal active_combatant_changed(combatant)


# Initializes turn queue with an array of combatants.
func initialize(combatants: Array) -> void:
	set_queue(combatants)
	play_turn()


func play_turn() -> void:
	yield(active_combatant, "turn_finished")
	assert(get_next_in_queue() != null)
	play_turn()


func get_next_in_queue() -> Combatant:
	var current_combatant = queue.pop_front()
	current_combatant.is_active = false
	queue.append(current_combatant)
	self.active_combatant = queue[0]
	return active_combatant


func remove(combatant: Combatant) -> void:
	var new_queue := []
	new_queue.append_array(queue)
	new_queue.remove(new_queue.find(combatant))
	combatant.queue_free()
	self.queue = new_queue


func _set_active_combatant(new_combatant: Combatant) -> void:
	if new_combatant.health <= 0:
		return
	active_combatant = new_combatant
	active_combatant.is_active = true
	emit_signal("active_combatant_changed", active_combatant)


func set_queue(combatants: Array) -> void:
	queue.clear()
	for combatant in combatants:
		combatant.is_active = false
		queue.append(combatant)
	if queue.size() > 0:
		self._set_active_combatant(queue[0])
	# queue.append_array(combatants)


func get_queue() -> Array:
	return queue


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
