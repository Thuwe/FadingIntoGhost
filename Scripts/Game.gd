extends Node2D

onready var level_spawner:Node2D = get_node("%LevelSpawner")
onready var fading_level_bar:TextureProgress = get_node("%FadingLevelBar")
onready var animations:AnimationPlayer = get_node("%Animations")

export var actual_level:String = "res://Scenes/Levels/Level1.tscn"

var level:Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	load_next_level(actual_level)

func _physics_process(delta):
	fading_level_bar.value = GameData.fading_level

func load_next_level(var next_level:String) -> void:
	var level_scene = load(next_level)
	level = level_scene.instance()
	level.connect("level_finished", self, "_on_level_finished")
#	level_spawner.add_child(level)
	level_spawner.call_deferred("add_child", level)
	animations.play("LevelRising")
	yield(animations, "animation_finished")


func _on_level_finished(var next_level:String) -> void:
	animations.play("LevelFading")
	yield(animations, "animation_finished")
	level.queue_free()
	load_next_level(next_level)
	
