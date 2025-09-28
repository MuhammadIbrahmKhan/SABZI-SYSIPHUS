extends CharacterBody2D

const SPEED = 260.0
const JUMP_VELOCITY = -400.0
const SLIDING_SPEED = 100
const STEP_COOLDOWN_MS = 100 # ms delay between steps
const SLIDE_DELAY_MS = 16*4# Delay before sliding begins
var Lives = 2
@onready var FruitFull : Sprite2D= $"Fruit1"
@onready var FruitEmpty: Sprite2D = $"Fruit2"

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var last_step_time: int = Time.get_ticks_msec()
var last_input_release_time: int = Time.get_ticks_msec()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	if Lives == 2:
		FruitFull.visible = true
		FruitEmpty.visible=false
	if Lives == 1:
		FruitFull.visible = false
		FruitEmpty.visible=true
	if Lives == 0:
		get_tree().change_scene_to_file("res://Scenes/dead.tscn")
	var current_time = Time.get_ticks_msec()
	var direction := 0.0
	# Handle movement with 1s cooldown
	if Input.is_action_just_pressed("ui_accept"):
		if current_time - last_step_time >= STEP_COOLDOWN_MS:
			direction = 1.0
			last_step_time = current_time
	else:
		# Only update release time when key is released
		if Input.is_action_just_released("ui_accept"):
			last_input_release_time = current_time

	if direction != 0:
		velocity.x = direction * SPEED
	else:
		if current_time - last_step_time >= SLIDE_DELAY_MS:
			velocity.x = move_toward(velocity.x, -SLIDING_SPEED, SPEED)
		# Otherwise, hold current velocity (brief pause before sliding)
		else:
			velocity.x = velocity.x

	move_and_slide()
