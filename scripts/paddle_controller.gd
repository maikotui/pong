class_name PaddleController
extends KinematicBody2D
# Controls the movement of the paddle both if the paddle is player controlled
# or if the paddle is controlled by the AI. This handles input as well as
# physics for the paddle.


# Public variables
enum PlayerType { PLAYER1, PLAYER2, AI }
export(PlayerType) var player
export var speed:float = 200
export var sprint_modifier:float = 1.5

# Private variables
var _direction:Vector2 = Vector2.ZERO
var _is_sprinting:bool = false


# Called at the begining of the game
func _ready():
	GameController.connect("ball_velocity_changed", self, "_on_ball_velocity_changed")


# Called when an input event occurs
func _input(event):
	if player != PlayerType.AI:
		# Handle sprint input
		if event.is_action_pressed((PlayerType.keys()[player]).to_lower() + "_sprint"):
			_is_sprinting = true
		if event.is_action_released((PlayerType.keys()[player]).to_lower() + "_sprint"):
			_is_sprinting = false

		# Handle up and down input
		if event.is_action_pressed((PlayerType.keys()[player]).to_lower() + "_up"):
			_direction = Vector2(0,-1)
		if event.is_action_released((PlayerType.keys()[player]).to_lower() + "_up"):
			_direction = Vector2.ZERO
		if event.is_action_pressed((PlayerType.keys()[player]).to_lower() + "_down"):
			_direction = Vector2(0,1)
		if event.is_action_released((PlayerType.keys()[player]).to_lower() + "_down"):
			_direction = Vector2.ZERO


# Called during physics updates
func _physics_process(delta):
	if GameController.is_active:
		var velocity = _direction * speed
		if _is_sprinting:
			velocity *= sprint_modifier
		move_and_collide(velocity * delta)


# Used by the AI
func _on_ball_velocity_changed(new_dir: Vector2):
	if player == PlayerType.AI:
		_direction = Vector2(0, new_dir.y)/speed


# To be called by the ball when it bounces off this object
func _on_ball_bounced():
	if player != PlayerType.AI:
		GameController.increment_score()
