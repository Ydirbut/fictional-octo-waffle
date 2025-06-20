extends Area2D

@export var startTile = false

var hasBuilding : bool = false

var canPlaceBuilding : bool = false

@onready var highlight : Polygon2D = get_node ("Highlight")

@onready var buildingIcon : Sprite2D = get_node ("BuildingIcon")

func _ready ():
	
	add_to_group("Tiles")

func toggle_highlight(toggle):
	highlight.visible = toggle
	canPlaceBuilding = toggle
	
	
func place_building(buildingTexture):
	hasBuilding = true
	buildingIcon.texture = buildingTexture


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	
	if event is InputEventMouseButton and event.pressed:
		var gameManager = get_node("/root/MainScene")
	   # if we can place a building down on this tile, then do so
		if event.button_index == MOUSE_BUTTON_LEFT:
			if gameManager.curPlacingBuilding and canPlaceBuilding:
				gameManager.place_building(self)
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			print(get_viewport().get_mouse_position())
			print(self.name)
			if gameManager.curPlacingBuilding:
				gameManager.cancel_placing_building()
