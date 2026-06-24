extends Node2D
class_name Soul

enum SoulType {
	NORMAL,
	BLUE
}
@export var soulType: SoulType = SoulType.NORMAL

func _ready() -> void:
	if soulType == SoulType.NORMAL:
		soul_sprite = Sprite2D.new()
		soul_sprite.texture = load("res://Sprites/Soul.png")
		soul_sprite.position = spawner.position
		add_child(soul_sprite)
