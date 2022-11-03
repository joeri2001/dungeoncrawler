extends Control

const SAVE_DIR = "user://saves/"

var save_path = SAVE_DIR + "save.dat"

func _on_Save_pressed():
	var save_data = {
		"coins" : Global.coins,
	}
	var dir = Directory.new()
	
	if !dir.dir_exists(SAVE_DIR):
		dir.make_dir_recursive(SAVE_DIR)
	
	var file = File.new()
	var error = file.open_encrypted_with_pass(save_path, File.WRITE, "tkgeAqI488#j")
	if error == OK:
		file.store_var(save_data)
		file.close()
