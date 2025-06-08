extends Node

var allTiles : Array

var tilesWithBuildings : Array

var tileSize : float = 64.0

var grid: Resource

# Size of the grid
const Q_CELLS = 8
const R_CELLS = 8

# Resource for HexGrid
var hex_grid
# Dictionary to hold tiles with their axial coords as keys
var tiles = {}


func get_tile_at_position(position: Vector2):
	for tile in allTiles:
		# Get the CollisionShape2D node of the tile
		var collision_shape = tile.get_node("CollisionShape2D")
		var shape = collision_shape.shape
		var local_point = tile.to_local(position)
		# Convert the global position to the tile's local space
		var local_pos = tile.to_local(position)
		if shape is RectangleShape2D:
			var extents = shape.extents
			if abs(local_point.x) <= extents.x and abs(local_point.y) <= extents.y:
				return tile
		elif shape is CircleShape2D:
			if local_point.length() <= shape.radius:
				return tile
		# Add more shape types if needed (e.g., CapsuleShape2D, etc.)
	return null
	
func disable_tile_highlights ():
	for x in range(allTiles.size()):
		allTiles[x].toggle_highlight(false)

func highlight_available_tiles():
	for x in range(tilesWithBuildings.size()):
		var northTile = get_tile_at_position(tilesWithBuildings[x].position + Vector2(0, tileSize))
		var southTile = get_tile_at_position(tilesWithBuildings[x].position + Vector2(0, -tileSize))
		var eastTile = get_tile_at_position(tilesWithBuildings[x].position + Vector2(tileSize, 0))
		var westTile = get_tile_at_position(tilesWithBuildings[x].position + Vector2(-tileSize, 0))
		if northTile != null:
			northTile.toggle_highlight(true)
		if southTile != null:
			southTile.toggle_highlight(true)
		if eastTile != null:
			eastTile.toggle_highlight(true)
		if westTile != null:
			westTile.toggle_highlight(true)
			
		print("Checking neighbors for tile at ", tilesWithBuildings[x].position)

func place_building(tile, texture):
	tilesWithBuildings.append(tile)
	tile.place_building(texture)
	disable_tile_highlights()


func _ready():
	hex_grid = load("res://HexGrid/HexGrid.gd").new()
	hex_grid.setup(Q_CELLS, R_CELLS) # set up axial grid

	var tile_scene = preload("res://Tile.tscn")
	for q in range(Q_CELLS):
		for r in range(R_CELLS):
			if not hex_grid.in_bounds(Vector2(q, r)):
				continue # skip out-of-bounds cells
			# Instance your tile scene
			var tile = tile_scene.instantiate()
			# Get world position for this hex
			var pos = hex_grid.hex_to_pixel(Vector2(q, r))
			tile.position = pos
			# Optionally: store hex coordinates on the tile for reference
			tile.set("hex_coords", Vector2(q, r))
			# Add to scene
			add_child(tile)
			# Store in dictionary for easy access
			tiles[Vector2(q, r)] = tile

	# Example: highlight neighbors for a specific tile
	# highlight_neighbors(Vector2(3, 3))

func highlight_neighbors(hex_coords: Vector2):
	# Remove highlights from all tiles
	for t in tiles.values():
		t.toggle_highlight(false)
	# Highlight the selected tile
	if tiles.has(hex_coords):
		tiles[hex_coords].toggle_highlight(true)
	# Get neighbors using hex_grid
	var neighbors = hex_grid.get_neighbors(hex_coords)
	for n in neighbors:
		if tiles.has(n):
			tiles[n].toggle_highlight(true)
