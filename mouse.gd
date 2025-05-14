extends Node

@onready var game_tilemap: TileMap = get_node("%TileMap")
@onready var hero = get_node("%Player")

#Mostly redundant, but have to be included. Framework for placing different types of files, remains unimplemented. Change seleceted_tile to change what you place.
#Due to how godot handles TileMaps, it'd be best by FAR to have a seperate tile for placed tiles, since that allows for them to be on a seperate collision layer.

func _ready():
	capture_mouse()

func _input(event):
	# places tile
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("mb_left"):
			handle_mouse_click()
	elif event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED: shift_in_bounds(self.position+event.relative)
	elif event is InputEventKey:
		if Input.is_action_just_pressed("escape"):
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
var empty_tile_atlas = Vector2i(8,6)


func handle_mouse_click():
	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		capture_mouse()
	else:
		var mouse_pos = self.position
		var tile_coords = Vector2i(floor(mouse_pos / 32.0))
		var current_tile_atlas = game_tilemap.get_cell_atlas_coords(0, tile_coords)
		if current_tile_atlas == empty_tile_atlas:
			place_tile(tile_coords)
		else:
			remove_tile(tile_coords)

func shift_in_bounds(shifto: Vector2):
	var bounds = get_viewport().get_visible_rect()
	var x = clamp(shifto.x,0,bounds.end.x)
	var y = clamp(shifto.y,0,bounds.end.y)
	self.position = Vector2(x,y)
	return self.position

func capture_mouse():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	self.position = get_viewport().get_mouse_position()

func place_tile(tile_coords: Vector2i):
	game_tilemap.set_cells_terrain_connect(0,[tile_coords], 0, 0, 0)

func remove_tile(tile_coords: Vector2i):
	game_tilemap.set_cell(0, tile_coords, 0, empty_tile_atlas, 0)
