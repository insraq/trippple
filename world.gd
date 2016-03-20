
extends Node

# member variables here, example:
# var a=2
# var b="textvar"

const TILE_SIZE = 80
const TILE_TYPES = ['php', 'nodejs', 'java', 'javascript', 'erlang', 'golang', 'csharp', 'html', 'ruby', 'python']
const TileScene = preload('res://tile.scn')
const Tile = preload('res://scripts/tile.gd')
var tiles = []
var next_tile = null
onready var next_tile_indicator = self.get_node("CanvasLayer/NextTile")
var score = 0

func _ready():
	self.set_process_input(true)
	build_map()
	draw_next_tile()
	pass
	
func _input(event):
	if (event.type == InputEvent.MOUSE_BUTTON && event.pressed):
		var x = event.x / TILE_SIZE
		var y = event.y / TILE_SIZE - 1
		if (y < 0): 
			return
		if (self.tiles[x][y].clicked(self.next_tile)):
			draw_next_tile()
			check_tiles(x, y)
		self.get_tree().set_input_as_handled()
	
func draw_next_tile():
	self.next_tile = TILE_TYPES[randi() % TILE_TYPES.size()]
	self.next_tile_indicator.set_texture(Tile.load_texture(self.next_tile))
	
func check_tiles(x, y):
	# Check horizontal
	if (self.tile_matches(x, y, x + 1, y) && self.tile_matches(x, y, x - 1, y)):
		self.score += 2
		self.tiles[x + 1][y].reset()
		self.tiles[x - 1][y].reset()
		if (self.tile_matches(x, y, x - 2, y)):
			self.score += 1
			self.tiles[x - 2][y].reset()
		if (self.tile_matches(x, y, x + 2, y)):
			self.score += 1
			self.tiles[x + 2][y].reset()
		
	if (self.tile_matches(x, y, x - 1, y) && self.tile_matches(x, y, x - 2, y)):
		self.tiles[x - 1][y].reset()
		self.tiles[x - 2][y].reset()
		self.score += 2
	if (self.tile_matches(x, y, x + 1, y) && self.tile_matches(x, y, x + 2, y)):
		self.tiles[x + 1][y].reset()
		self.tiles[x + 2][y].reset()
		self.score += 2
	
	# Check vertical
	if (self.tile_matches(x, y, x, y + 1) && self.tile_matches(x, y, x, y - 1)):
		self.score += 2
		self.tiles[x][y + 1].reset()
		self.tiles[x][y - 1].reset()
		if (self.tile_matches(x, y, x, y - 2)):
			self.score += 1
			self.tiles[x][y - 2].reset()
		if (self.tile_matches(x, y, x, y + 2)):
			self.score += 1
			self.tiles[x][y + 2].reset()
		
	if (self.tile_matches(x, y, x, y - 1) && self.tile_matches(x, y, x, y - 2)):
		self.tiles[x][y - 1].reset()
		self.tiles[x][y - 2].reset()
		self.score += 2
	if (self.tile_matches(x, y, x, y + 1) && self.tile_matches(x, y, x, y + 2)):
		self.tiles[x][y + 1].reset()
		self.tiles[x][y + 2].reset()
		self.score += 2
	
	self.get_node("CanvasLayer/ScoreCount").set_text(str(self.score))

		
func tile_matches(x, y, targetX, targetY):
	if (targetX >= 0 && targetX < 6 && targetY >= 0 && targetY < 9):
		return self.tiles[x][y].tile_type == self.tiles[targetX][targetY].tile_type
	else:
		return false
	
# The map is 6 x 9
func build_map():
	for i in range(6):
		var row = []
		for j in range(9):
			var tile = TileScene.instance() 
			tile.build_tile(i, j + 1)
			row.append(tile)
			self.add_child(tile)
		tiles.append(row)