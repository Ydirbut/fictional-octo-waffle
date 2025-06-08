extends Area2D

@export var startTile = false

var hasBuilding : bool = false

var canPlaceBuilding : bool = false

@onready var highlight : Sprite2D = get_node ("Highlight")

@onready var buildingIcon : Sprite2D = get_node ("BuildingIcon")

func _ready ():
	
	add_to_group("Tiles")

func toggle_highlight(toggle):
	highlight.visible = toggle
	canPlaceBuilding = toggle
	
	
func place_building(buildingTexture):
	hasBuilding = true
	buildingIcon.texture = buildingTexture


func _on_Tile_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		var gameManager = get_node("/root/MainScene")
	   # if we can place a building down on this tile, then do so
		if gameManager.currentlyPlacingBuilding and canPlaceBuilding:
			gameManager.place_building(self)
