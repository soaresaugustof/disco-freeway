extends RigidBody2D

var move_left = false

func _ready():
	var tipos_carros = $Animacao.sprite_frames.get_animation_names()
	var carro = tipos_carros[randi_range(0, tipos_carros.size() - 1)]
	$Animacao.animation = carro
	if move_left:
		rotation_degrees = 180


func _on_notificador_screen_exited():
	queue_free()
