extends Node2D

@onready var spawner: Marker2D = $Spawner
@onready var soul_sprite: Sprite2D = $SoulSprite

enum SoulType {
	NONE,
	RED,
	BLUE
}
@export var soulType: SoulType = SoulType.NONE

func _ready() -> void:
	if soulType == SoulType.RED:
		soul_sprite.texture = load("res://Sprites/Soul.png")
		soul_sprite.position = spawner.position
		soul_sprite.material = soul_sprite.material.duplicate()
		add_child(soul_sprite)

func _process(_delta):
	
	
	if soul_sprite:
		soul_sprite.global_rotation = 0

func _on_area_2d_area_entered(area: Area2D) -> void:
	if soul_sprite:
		soul_sprite.material.set_shader_parameter("thickness", 3)

func _on_area_2d_area_exited(area: Area2D) -> void:
	if soul_sprite:
		soul_sprite.material.set_shader_parameter("thickness", 0)

func absolution() -> void:
	if soul_sprite:
		soul_sprite.queue_free()
