class_name PaddleController
extends KinematicBody2D

enum Player { PLAYER1, PLAYER2, AI }
export(Player) var player

export var speed:float = 200
export var sprint_modifier:float = 1.5

var direction:Vector2 = Vector2.ZERO
var is_sprinting:bool = false


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
	var velocity = direction * speed
	if is_sprinting:
		velocity *= sprint_modifier
	move_and_slide(velocity)
