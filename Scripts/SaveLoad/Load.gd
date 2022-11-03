extends Control

const SAVE_DIR = "user://saves/"

var save_path = SAVE_DIR + "save.dat"

func _on_Load_pressed():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open_encrypted_with_pass(save_path, File.READ, "tkgeAqI488#j")
		if error == OK:
			var player_data = file.get_var()
			# add all variables to load seperately
			Global.coins = player_data["coins"]
			file.close()
	
	var _UNUSEDchange_scene = get_tree().change_scene("res://Scenes/Lobby.tscn")
