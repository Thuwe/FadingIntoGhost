extends Node2D

onready var credits:Panel = get_node("%Credits")
onready var screen_animation:Node2D = get_node("%ScreenAnimation")
onready var spawn_timer:Timer = get_node("%SpawnTimer")

var fading_ghost = preload("res://Scenes/FadingGhost.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	_on_SpawnTimer_timeout()
	
func _process(_delta):
	pass

func _on_StartGame_button_up():
	var _return = get_tree().change_scene("res://Scenes/Game.tscn")


func _on_Credits_button_up():
	credits.visible = true


func _on_BackCredits_button_up():
	credits.visible = false

func _on_SpawnTimer_timeout():
	var node_ghost = fading_ghost.instance()
	var rand_x = rand_range(0, 800)
	var rand_y = rand_range(0, 600)
	node_ghost.position = Vector2(rand_x, rand_y)
	screen_animation.add_child(node_ghost)
