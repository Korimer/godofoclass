extends Sprite2D
enum STATE {
	FOLLOW_CURSOR,
	TRAP_PLAYER
}
var laser = preload("res://laser.tscn")
@onready var mousepos = get_parent().get_node("TrueMouse")

@onready var state = STATE.FOLLOW_CURSOR
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match state:
		STATE.FOLLOW_CURSOR:
			self.position = mousepos.position
			#fire_laser()
		STATE.TRAP_PLAYER:
			print("HELLO!")
		_:
			print('its over')

func fire_laser():
	add_child(laser.instantiate())
