extends KinematicBody2D

export var speed:float = 100
export var random_amount:float = 0.25

var direction:Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	direction = Vector2(rand_range(-1,1), rand_range(-0.5,0.5)).normalized()
	GameController.emit_signal("ball_velocity_changed", direction*speed)


func _physics_process(delta):
	if GameController.is_active:
		var collision = move_and_collide(direction * speed * delta)
		if collision:
			if collision.collider.get_collision_layer_bit(0):
				direction = direction.bounce(collision.normal)
				GameController.emit_signal("ball_velocity_changed", direction*speed)
			elif collision.collider.get_collision_layer_bit(1):
				var diff = position - collision.collider.position
				direction = diff.normalized()
				GameController.emit_signal("ball_velocity_changed", direction*speed)
			if collision.collider.has_method("on_ball_bounced"):
				collision.collider.on_ball_bounced()
