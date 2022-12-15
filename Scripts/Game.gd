extends Node2D

onready var level_spawner:Node2D = get_node("%LevelSpawner")
onready var fading_level_bar:TextureProgress = get_node("%FadingLevelBar")
onready var animations:AnimationPlayer = get_node("%Animations")
onready var levels:Label = get_node("%Levels")

export var actual_level:String = "res://Scenes/Levels/Level1.tscn"

var level:Node2D
var level_numbers:int = 10

const levels_path:String = "res://Scenes/Levels/"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_numbers = count_level(levels_path) - 1 #Not counting last level	
	load_next_level(actual_level)

func _physics_process(_delta) -> void:
	fading_level_bar.value = GameData.fading_level

func load_next_level(var next_level:String) -> void:
	var level_scene = load(next_level)
	var current_level:int = 0
	
	level = level_scene.instance()
	level.game_parent = self
	var _con_err = level.connect("level_finished", self, "_on_level_finished")
#	level_spawner.add_child(level)
	level_spawner.call_deferred("add_child", level)
	current_level = int(level.name.trim_prefix("Level"))
	levels.text = "Level: " + str(current_level) + " / " + str(level_numbers)
	animations.play("LevelRising")
	if level.name == "VictoryLevel":
		fading_level_bar.hide()
		levels.hide()
	else:
		fading_level_bar.show()
		levels.show()
	yield(animations, "animation_finished")


func _on_level_finished(var next_level:String) -> void:
	animations.play("LevelFading")
	yield(animations, "animation_finished")
	level.queue_free()
	load_next_level(next_level)
	
func faded_screen() -> void:
	yield(get_tree(), "idle_frame")
	animations.play("FadedScreen")
	yield(animations, "animation_finished")
	
func count_level(path:String) -> int:
	var nb_levels:int = 0
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				pass
			else:
				nb_levels += 1
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")	
	
	return nb_levels
	
