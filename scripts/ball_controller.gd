class_name BallController
extends KinematicBody2D
# Controls the movement and state of the pong ball.


# Public variables
export var speed: float = 100
export var vertical_clamp: float = 0.75
var direction: Vector2

# Private variables
var _has_bounced_once: bool


# Called when the node enters the scene tree for the first time.
func _ready():
	speed /= 2  # Halve the speed until the first bounce
	_has_bounced_once = false
	randomize()
	direction = Vector2(rand_range(-1,1), 0).normalized()
	GameController.emit_signal("ball_velocity_changed", direction*speed)


# Called when the node is able to process physics actions
func _physics_process(delta):
	if GameController.is_active:
		var collision = move_and_collide(direction * speed * delta)
		if collision:
			if !_has_bounced_once:
				_has_bounced_once = true
				speed *= 2  # Reset the speed after the first bounce

			if collision.collider.get_collision_layer_bit(0): # World bit layer
				direction = direction.bounce(collision.normal)
				GameController.emit_signal("ball_velocity_changed", direction*speed)
			elif collision.collider.get_collision_layer_bit(1): # Paddle bit layer
				var diff = position - collision.collider.position
				direction = diff.normalized()
				direction.y = clamp(direction.y, -vertical_clamp, vertical_clamp)  # Prevents vertical bouncing
				GameController.emit_signal("ball_velocity_changed", direction*speed)

			if collision.collider.has_method("_on_ball_bounced"):
				collision.collider._on_ball_bounced()
