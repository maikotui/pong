class_name BallController
extends KinematicBody2D
# Controls the movement and state of the pong ball.


# Public variables
export var speed: float = 100
export var vertical_clamp: float = 0.75
export var min_vertical_direction: float = 0.05
export var max_vertical_direction: float = 0.25
var direction: Vector2

# Private variables
var _has_bounced_once: bool
var _rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	_rng.randomize()
	
	speed /= 2  # Halve the speed until the first bounce
	_has_bounced_once = false
	
	# Calculate the initial direction
	var start_x = GameController.generate_random_negative_or_positive()
	var start_y = 0
	while(abs(start_y) < min_vertical_direction):
		start_y = _rng.randf_range(-max_vertical_direction, max_vertical_direction)
	direction = Vector2(start_x, start_y).normalized()
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
