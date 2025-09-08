extends Node

const cena_carros = preload("res://Cenas/carros.tscn")
var pistas_rapidas_y = [104, 272, 488]
var pistas_lentas_y = [160, 216, 324, 384, 438, 544, 600]
var score = 0

func _ready():
	$HUD/Placar.text = str(score)
	$HUD/Mensagem.text = " "
	$HUD/Button.hide()
	$AudioTema.play()
	randomize()


func _process(delta):
	if not $TimerRestart.is_stopped():
		$HUD.update_restart_clock($TimerRestart.time_left)


func _on_timer_carros_rapidos_timeout():
	var carro = cena_carros.instantiate()
	add_child(carro)
	var pista_y = pistas_rapidas_y[randi_range(0, pistas_rapidas_y.size() - 1)]
	carro.position = Vector2(-10, pista_y)
	carro.set_linear_velocity(Vector2(randf_range(700, 710), 0))
	carro.set_linear_damp(0.0)

func _on_timer_carros_lentos_timeout():
	var carro = cena_carros.instantiate()
	carro.move_left = true 
	add_child(carro)
	var pista_y = pistas_lentas_y[randi_range(0, pistas_lentas_y.size() - 1)]
	carro.position = Vector2(1290, pista_y)
	carro.set_linear_velocity(Vector2(randf_range(-300, -310), 0))
	carro.set_linear_damp(0.0)


func _on_player_pontua():
	if score <= 1:
		score += 1
		$HUD/Placar.text = str(score)
		$AudioPonto.play()
		$Player.position = $Player.posicao_inicial
	
	if score == 1:
		$HUD/Mensagem.text = "Parabéns, você venceu!"
		$HUD/Button.show()
		$TimerCarrosRapidos.stop()
		$TimerCarrosLentos.stop()
		$AudioTema.stop()
		$AudioVitoria.play()
		$Player.speed = 0
		
		$TimerRestart.start()

func _on_hud_reinicia():
	$TimerRestart.stop()
	score = 0
	$HUD/Mensagem.hide()
	$HUD/Placar.text = str(score)
	$HUD/Button.hide()
	$TimerCarrosRapidos.start()
	$TimerCarrosLentos.start()
	$AudioTema.play()


func _on_timer_restart_timeout():
	get_tree().paused = false
	get_tree().reload_current_scene()
