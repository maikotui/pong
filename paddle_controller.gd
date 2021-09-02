class_name PaddleController
extends KinematicBody2D

# Exports
enum Player { PLAYER1, PLAYER2, AI }
export(Player) var player
export var speed:float = 200
export var sprint_modifier:float = 1.5

# Member variables
var direction:Vector2 = Vector2.ZERO
var is_sprinting:bool = false


# Called at the begining of the game
func _ready():
	GameController.connect("ball_velocity_changed", self, "_on_ball_velocity_changed")


# Called when an input event occurs
func _input(event):
	if player != Player.AI:
		if event.is_action_pressed((Player.keys()[player]).to_lower() + "_sprint"):
			is_sprinting = true
		if event.is_action_released((Player.keys()[player]).to_lower() + "_sprint"):
			is_sprinting = false
		
		if event.is_action_pressed((Player.keys()[player]).to_lower() + "_up"):
			direction = Vector2(0,-1)
		if event.is_action_released((Player.keys()[player]).to_lower() + "_up"):
			direction = Vector2.ZERO
			
		if event.is_action_pressed((Player.keys()[player]).to_lower() + "_down"):
			direction = Vector2(0,1)
		if event.is_action_released((Player.keys()[player]).to_lower() + "_down"):
			direction = Vector2.ZERO


func _physics_process(delta):
	if GameController.is_active:
		var velocity = direction * speed
		if is_sprinting:
			velocity *= sprint_modifier
		move_and_collide(velocity * delta)


func _on_ball_velocity_changed(new_dir: Vector2):
	if player == Player.AI:
		direction = Vector2(0, new_dir.y)/speed


func on_ball_bounced():
	if player != Player.AI:
		GameController.increment_score()
