extends Node2D

signal level_finished(next_level)

onready var animation = get_node("%Animation")

var game_parent:Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play("GhostTransform")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
