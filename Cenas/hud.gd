extends CanvasLayer

signal reinicia

func _on_button_pressed():
	emit_signal("reinicia")

func update_restart_clock(tempo_restante):
	# ceil() arredonda o número para cima, para mostrar 5, 4, 3...
	$TimerRestart.text = "Reiniciando em " + str(ceil(tempo_restante))
	$TimerRestart.show()
