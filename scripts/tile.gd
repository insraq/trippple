
extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"

const TILE_TYPES = ['php', 'nodejs', 'java', 'javascript', 'erlang', 'golang', 'csharp', 'html', 'ruby', 'python']
const TILE_SIZE = 80

var tile_type = null
var tile_enabled = true

func _ready():
	pass

func build_tile(x, y):
	self.set_name('tile_' + str(x) + '_' + str(y))
	self.set_pos((Vector2(x * TILE_SIZE, y * TILE_SIZE)))
	
func clicked(tile_type):
	if (self.tile_type != null || !self.tile_enabled):
		return false
	self.set_texture(load("res://assets/tile_clicked.png"))
	self.tile_type = tile_type
	self.get_node("AnimationPlayer").play("Clicked")
	return true

func enable():
	self.tile_enabled = true
	if (self.tile_type != null):
		return
	self.set_texture(load("res://assets/tile.png"))
	
func disable():
	self.tile_enabled = false
	if (self.tile_type != null):
		return
	self.set_texture(load("res://assets/tile_disabled.png"))

func reset():
	self.tile_type = null
	self.get_node("AnimationPlayer").play("Clicked")
	
func click_finished():
	self.set_texture(load_texture(self.tile_type, self.tile_enabled))
	
static func load_texture(tile_type, tile_enabled):
	if (tile_type == null):
		if (tile_enabled):
			return load("res://assets/tile.png")
		else:
			return load("res://assets/tile_disabled.png")
	return load('res://assets/tile_' + tile_type + '.png')