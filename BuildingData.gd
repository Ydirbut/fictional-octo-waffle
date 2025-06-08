extends Node

class Building:
   # building type
	var type : int
   # building texture
	var iconTexture : Texture
	var prodResource : int = 0
	var prodResourceAmount : int
	var upkeepResource : int = 0
	var upkeepResourceAmount : int

	func _init (type, iconTexture, prodResource, prodResourceAmount, upkeepResource, upkeepResourceAmount):
		self.type = type
		self.iconTexture = iconTexture
		self.prodResource = prodResource
		self.prodResourceAmount = prodResourceAmount
		self.upkeepResource = upkeepResource
		self.upkeepResourceAmount = upkeepResourceAmount

var base = Building.new(0, preload("res://GodotStrategy-Assets/Sprites/Base.png"), 0, 0, 0, 0)
var mine = Building.new(1, preload("res://GodotStrategy-Assets/Sprites/Mine.png"), 2, 1, 4, 1)
var greenhouse = Building.new(2, preload("res://GodotStrategy-Assets/Sprites/Greenhouse.png"), 1, 1, 0, 0)
var solarpanel = Building.new(3, preload("res://GodotStrategy-Assets/Sprites/SolarPanel.png"), 4, 1, 0, 0)
