extends SpeechModifierBase

func _init():
	id = "NanoSpeech"
	priority = 500

func appliesTo(_speaker: BaseCharacter) -> bool:
	var contamination_effect = _speaker.getEffect("Nano_Contamination")
	if contamination_effect != null and contamination_effect.stacks > 60:
		return true
	return false

func modify(_text: String, _speaker: BaseCharacter) -> String:
	return "[font=res://Modules/NanoRevolution/Fonts/largeconsolefont.tres]" + _text + "[/font]"
