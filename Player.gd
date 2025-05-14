extends RigidBody2D

@export var speed = 14
@export var gravity = 75
var dashwindow: Timer
var candash = false
var dashdir
var canjump = true
# Called when the node enters the scene tree for the first time.
func _ready():
	dashwindow = get_node("dashwindow")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var direction = Vector2.ZERO
	if self.linear_velocity.y > 0: canjump = true
	if Input.is_action_just_pressed("ui_right"):
		if (candash && dashdir):
			apply_impulse(Vector2.RIGHT*500)
			print("dashed right")
			candash = false
		else:
			direction.x += 1
			dashdir = true
			candash = true
			dashwindow.start()
	if Input.is_action_just_pressed("ui_left"):
		if (candash && !dashdir):
			apply_impulse(Vector2.LEFT*500)
			print('dashed left')
			candash = false
		else:
			direction.x -= 1
			dashdir = false
			candash = true
			dashwindow.start()
	if Input.is_action_just_pressed("ui_up"):
		if canjump:	
			canjump = false
			apply_impulse(Vector2.UP*500,direction)
	
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	
	move_and_collide(direction)
