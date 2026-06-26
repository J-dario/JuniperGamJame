extends Node2D

@onready var spawner: Marker2D = $Spawner
@onready var soul_sprite: Sprite2D = $SoulSprite
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

var isGood = true
var spinSpeed = 0.0
var bob_amplitude := 0.0
var bob_speed := 0.0
var bob_time := 0.0
var soulSpritePos := 0.0

enum SoulType {
	NONE,
	RED,
	BLUE
}
@export var soulType: SoulType = SoulType.NONE

func _ready() -> void:
	if soulType == SoulType.NONE:
		return
	
	isGood = false
	soul_sprite.position = spawner.position
	soul_sprite.material = soul_sprite.material.duplicate()
	soul_sprite.texture = load("res://Sprites/Smoke.png")
	
	if soulType == SoulType.RED:
		soul_sprite.modulate = Color("#4d65b4")
		spinSpeed = 0.5
		bob_amplitude = 4.0
		bob_speed = 2.0
	
	soul_sprite.modulate.a = 0.0
	var tween := get_tree().create_tween()
	tween.tween_property(soul_sprite, "modulate:a", 1.0, 0.8).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)

func _process(delta):
	if soul_sprite:
		soul_sprite.global_rotation += spinSpeed * delta
		
		bob_time += delta
		soul_sprite.position.y = spawner.position.y + sin(bob_time * bob_speed) * bob_amplitude

func _on_area_2d_area_entered(_area: Area2D) -> void:
	if soul_sprite:
		soul_sprite.material.set_shader_parameter("thickness", 2)

func _on_area_2d_area_exited(_area: Area2D) -> void:
	if soul_sprite:
		soul_sprite.material.set_shader_parameter("thickness", 0)

func absolution() -> void:
	if soul_sprite:
		gpu_particles_2d.emitting = true
		isGood = true
		soul_sprite.queue_free()
