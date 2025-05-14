extends Node2D

@onready var enemy = preload("res://EnemyMouse.tscn")
@onready var newmouse = $SpawnNewMouse
@onready var endgame = $GameEnd


# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_enemy()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn_enemy():
	add_child(enemy.instantiate())
