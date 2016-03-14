
extends Node

# member variables here, example:
# var a=2
# var b="textvar"

const TILE_SIZE = 80
const Tile = preload('res://scripts/tile.gd')
var tiles = []

func _ready():
	self.set_process_input(true)	
	build_map()
	pass
	
func _input(event):
	if (event.type == InputEvent.MOUSE_BUTTON && event.pressed):
		print(event)
		var x = event.x / 80
		var y = event.y / 80
		tiles[x][y].clicked()
		self.get_tree().set_input_as_handled()
	
# The map is 10 x 6
func build_map():
	for i in range(10):
		var row = []
		for j in range(6):
			var tile = Tile.new().build_tile(i, j)
			row.append(tile)
			self.add_child(tile)
		tiles.append(row)