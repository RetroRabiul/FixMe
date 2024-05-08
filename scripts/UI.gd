extends Control

var crystal_count = 0

var life = 3

func _ready():
	GlobalSignals.connect("show_sign", self, "_show_sign")
	GlobalSignals.connect("hide_sign", self, "_hide_sign")
	GlobalSignals.connect("crystal_collected", self, "_crystal_collected")
	GlobalSignals.connect("change_life", self, "_change_life")
	GlobalSignals.connect("life_collected", self, "_life_collected")
	$LifeLabel.text = "Life : " +str(life)


func _life_collected():
	life += 1
	$LifeLabel.text = "Life : " +str(life)

func _change_life():
	life -= 1
	$LifeLabel.text = "Life : " +str(life)


func _show_sign(text):
	$SignText.text = text
	$SignText.visible = true

func _hide_sign():
	$SignText.visible = false
	
func _crystal_collected():
	crystal_count += 1
	$CrystalLabel.text = "Crystals : "+str(crystal_count)
#	GlobalSignals.emit_signal("crystal_sum",crystal_count)

