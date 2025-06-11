extends Node

var allTiles : Array

var tilesWithBuildings :Array

var tileSize : float = 64.0

var mapWidth : int = 3
var mapHeight: int = 3

var tile = preload("res://tile.tscn")

var nwDistance := Vector2  (-tileSize*0.5,-tileSize*0.5*sqrt(3))
var swDistance := Vector2  (-tileSize*0.5,tileSize*0.5*sqrt(3))
var neDistance := Vector2  (tileSize*0.5,-tileSize*0.5*sqrt(3))
var seDistance := Vector2  (tileSize*0.5,tileSize*0.5*sqrt(3))

func get_tile_at_position(position: Vector2):
	for tile in allTiles:
		# Get the CollisionShape2D node of the tile
		var collision_shape = tile.get_node("CollisionShape2D")
		var local_pos = collision_shape.to_local(position)

		if collision_shape is CollisionShape2D:
			
			var shape = collision_shape.shape
		# Convert the global position to the tile's local space
			
			if shape is RectangleShape2D:
				if shape.point_inside(local_pos):
					return tile
			elif shape is CircleShape2D:
				if shape.point_inside(local_pos):
					return tile
		



		if collision_shape.get_class() == "CollisionPolygon2D" and collision_shape.polygon.size() == 6:
			
			if Geometry2D.is_point_in_polygon(local_pos,collision_shape.polygon):


				return tile
		
	return null
	
func disable_tile_highlights ():
	for x in range(allTiles.size()):
		allTiles[x].toggle_highlight(false)

func highlight_available_tiles():
	for x in range(tilesWithBuildings.size()):


		var northEastTile = get_tile_at_position(tilesWithBuildings[x].position + neDistance)
		var southEastTile = get_tile_at_position(tilesWithBuildings[x].position + seDistance)

		var northWestTile = get_tile_at_position(tilesWithBuildings[x].position + nwDistance)
		var southwestTile = get_tile_at_position(tilesWithBuildings[x].position + swDistance)

		var westTile = get_tile_at_position(tilesWithBuildings[x].position + Vector2(-tileSize, 0))

		var eastTile = get_tile_at_position(tilesWithBuildings[x].position + Vector2(tileSize, 0))
		if northEastTile != null:
			northEastTile.toggle_highlight(true)
			
		if southEastTile != null:
			southEastTile.toggle_highlight(true)
			
		if northWestTile != null:
			northWestTile.toggle_highlight(true)
			
		if southwestTile != null:
			southwestTile.toggle_highlight(true)
			
		if westTile != null:
			westTile.toggle_highlight(true)	
			
		if eastTile != null:
			eastTile.toggle_highlight(true)
			
		
func place_building(tile, texture):
	tilesWithBuildings.append(tile)
	tile.place_building(texture)
	disable_tile_highlights()

func _ready():
	var xStart : int = round(randf_range(2,mapWidth -2))
	var yStart : int = round(randf_range(2,mapHeight-2))
	'for x in range(0,mapWidth):
		for y in range(0,mapHeight):
			var newTile = tile.instantiate()
			var xPos : int = 0
			var yPos : int = 0
			
			if y % 2 == 0:
				xPos = x*tileSize
			elif y % 2 == 1:
				xPos = (x+0.5)*tileSize
			
			yPos = y*tileSize*0.75
			
			newTile.position = Vector2(xPos,yPos)
			add_child(newTile)
			
			if x == xStart and y == yStart:
				place_building(newTile,BuildingData.base.iconTexture)'
	
	
	allTiles = get_tree().get_nodes_in_group("Tiles")
	
