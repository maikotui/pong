class_name BallController
extends KinematicBody2D
# Controls the movement and state of the pong ball.


# Public variables
export var speed:float = 100
var direction:Vector2


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	direction = Vector2(rand_range(-1,1), rand_range(-0.5,0.5)).normalized()
	GameController.emit_signal("ball_velocity_changed", direction*speed)


# Called when the node is able to process physics actions
func _physics_process(delta):
	if GameController.is_active:
		var collision = move_and_collide(direction * speed * delta)

		if collision:
			if collision.collider.get_collision_layer_bit(0): # World bit layer
				direction = direction.bounce(collision.normal)
				GameController.emit_signal("ball_velocity_changed", direction*speed)
			elif collision.collider.get_collision_layer_bit(1): # Paddle bit layer
				var diff = position - collision.collider.position
				direction = diff.normalized()
				GameController.emit_signal("ball_velocity_changed", direction*speed)

			if collision.collider.has_method("_on_ball_bounced"):
				collision.collider._on_ball_bounced()
