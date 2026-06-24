extends Node2D

@onready var spawner: Marker2D = $Spawner

enum SoulType {
	NONE,
	RED,
	BLUE
}
@export var soulType: SoulType = SoulType.NONE

func _ready() -> void:
	if soulType == SoulType.RED:
		var sprite := Sprite2D.new()
		sprite.texture = load("res://Sprites/Soul.png")
		sprite.position = spawner.position
		add_child(sprite)
