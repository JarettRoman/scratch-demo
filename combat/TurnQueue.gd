extends Node
class_name TurnQueue

# queue for storing entities
var queue: Array = []

# probably overkill but this enum is for tracking if a combatant is active or not.
enum TURN_STATE { ACTIVE, INACTIVE }

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func initialize(combatants: Array) -> void:
	for combatant in combatants:
		if queue.empty():
			queue.append({combatant: TURN_STATE.ACTIVE})
		else:
			queue.append({combatant: TURN_STATE.INACTIVE})


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
