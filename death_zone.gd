extends Area2D

var checkpoint_manager
var player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	checkpoint_manager = get_parent().get_node("CheckPointManager")
	player = get_parent().get_node("Player")

	




func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"): # Replace with function body.
		killPlayer()
		
func killPlayer():
			player.position = checkpoint_manager.last_location
