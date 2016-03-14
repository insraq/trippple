
extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"

const TILE_SIZE = 80

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func build_tile(x, y):
	self.set_texture(load("res://assets/tile.png"))
	self.set_pos((Vector2(x * TILE_SIZE, y * TILE_SIZE)))
	self.set_centered(false)
	return self
	
func clicked():
	self.set_texture(load("res://assets/tile_clicked.png"))
	var timer = Timer.new()
	self.add_child(timer)
	timer.connect('timeout', self, 'reset_texture')
	timer.set_wait_time(1.0)
	timer.set_one_shot(true)
	timer.start()

func reset_texture():
	print("Timeout")
	self.set_texture(load("res://assets/tile.png"))