extends Control

@onready var buildingButtons : Node = get_node("BuildingButtons")

@onready var foodMetalText : Label = get_node("FoodMetalText")

@onready var oxygenEnergyText : Label = get_node("OxygenEnergyText")

@onready var curTurnText : Label = get_node("TurnText")

@onready var gameManager : Node = get_node("/root/MainScene")

@onready var hexMap : Node = get_node("/root/MainScene/HexMap")

func on_end_turn():
	curTurnText.text = "Turn: " + str(gameManager.curTurn)
	buildingButtons.visible = true

func update_resource_text():
	var foodMetal = ""
	var oxygenEnergy = ""
	
	foodMetal += str(gameManager.curFood) + " (" + ("+" if gameManager.foodPerTurn >= 0 else "") + str(gameManager.foodPerTurn) + ")" + "\n"
	
	foodMetal += str(gameManager.curMetal) + " (" + ("+" if gameManager.metalPerTurn >= 0 else "") + str(gameManager.metalPerTurn) + ")" 
	
	foodMetalText.text = foodMetal
	
	oxygenEnergy += str(gameManager.curOxygen) + " (" + ("+" if gameManager.oxygenPerTurn >= 0 else "") + str(gameManager.oxygenPerTurn) + ")" + "\n"
	oxygenEnergy += str(gameManager.curEnergy) + " (" + ("+" if gameManager.energyPerTurn >= 0 else "") + str(gameManager.energyPerTurn) + ")"
	oxygenEnergyText.text = oxygenEnergy


func _on_mine_button_pressed() -> void:
	buildingButtons.visible = false
	gameManager.on_select_building(1)


func _on_greenhouse_button_pressed() -> void:
	buildingButtons.visible = false
	gameManager.on_select_building(2)


func _on_solar_panel_button_pressed() -> void:
	buildingButtons.visible = false
	gameManager.on_select_building(3)


func _on_end_turn_button_pressed() -> void:
	gameManager.end_turn()
	on_end_turn()
	
func cancel_placing_building() ->void:
	buildingButtons.visible = true

'func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var local_pos = hexMap.to_local(event.position)
		var cell = hexMap.local_to_map(local_pos)
		var tile_id = hexMap.get_cell(0, cell)
		if tile_id != hexMap.INVALID_CELL:
			print("Clicked on hex tile at map coords:", cell)'
