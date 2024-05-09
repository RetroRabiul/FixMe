extends Control



func _ready():
	GlobalSignals.connect("show_sign", self, "_show_sign")
	GlobalSignals.connect("hide_sign", self, "_hide_sign")
	GlobalSignals.connect("crystal_collected", self, "_crystal_collected")
	GlobalSignals.connect("change_life", self, "_change_life")
	$CrystalLabel.text = "Crystals : "+str(GlobalVariables.crystal_count)


func _change_life(lives):
	$LifeLabel.text = "Life : " +str(lives)


func _show_sign(text):
	$SignText.text = text
	$SignText.visible = true

func _hide_sign():
	$SignText.visible = false
	
func _crystal_collected():
	GlobalVariables.crystal_count += 1
	$CrystalLabel.text = "Crystals : "+str(GlobalVariables.crystal_count)
#	GlobalSignals.emit_signal("crystal_sum",crystal_count)

