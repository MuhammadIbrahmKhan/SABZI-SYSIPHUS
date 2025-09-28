extends Node2D

@onready var player = $"player"
@onready var sky = $"Sky"

var BoulderScene= preload("res://Scenes/boulder.tscn")
#how long ago did we spawn a boulder
var LastSpawned = Time.get_ticks_msec()
# ms to wait before spawning another
var SpawnIn = 1000

func _physics_process(delta: float) -> void:
	var current_time = Time.get_ticks_msec()
	sky.position = player.position
	if player.position.x > 1750:
		get_tree().change_scene_to_file("res://Scenes/win.tscn")
		print("REACHED")
	if current_time -LastSpawned > SpawnIn:
		SpawnIn = 5*1000
		LastSpawned = current_time
		var boulder = BoulderScene.instantiate()
		boulder.position = Vector2(player.position.x+200,player.position.y-210)
		add_child(boulder)
