extends StatusEffectBase

var stacks := 0.0

func _init():
	id = "Nano_Contamination"
	isBattleOnly = false
	isSexEngineOnly = false
	
func setCharacter(c):
	.setCharacter(c)
	# character.connect("pain_changed", self, "_on_pain_changed")
	
func initArgs(_args = []):
	if(_args.size() > 0):
		stacks = _args[0]
	else:
		stacks = 1
	# clampOrRemove()
	
# func processBattleTurn():
# 	clampOrRemove()
	
func processTime(_seconds: int):
	# if is already an android,  prevent natrol fall off
	if(!isNanoAndroid()):
		var hours = (_seconds / 3600.0)

		stacks = stacks - hours
	# clampOrRemove()

# func onSleeping():
# 	stacks = min(stacks, 25)
	

func isNanoAndroid():
	return (stacks >= 100) #android stack, consider higher buff in higher
		
func getEffectName():
	if(isNanoAndroid()):
		return "Nano Form"
	return "Contaminated"

func getEffectDesc():
	if isNanoAndroid():
		if OS.has_feature("editor"):
			return "Android." + "\n\n(" + str(ceil(stacks)) + "%)"
		return "Your nanite-infused android body grants you enhanced resistance to physical and thermal damage, but at the cost of permanent infertility."

	var text
	if stacks <= 20:
		text = "A black, sticky goo clings to your skin. It's impossible to pull off; perhaps it's better to wait for it to come off on its own."
	elif stacks <= 50:
		text = "The black goo begins to seep into your flesh. No amount of scrubbing can wash it away. Your skin darkens to an unnatural shade, its texture shifting to something smooth and yielding, like latex. You can't quite put your finger on it, but the world around you feels... different, somehow."
	elif stacks <= 90:
		text = "Your thoughts are hazy, slipping away like sand through your fingers... It's hard to focus..."
	else:
		text = "...Lost."

	return text + "\n\n(" + str(ceil(stacks)) + "%)"


func getEffectImage():
	# place holder, change here
	# if(isNanoAndroid()):
	# 	return "res://Images/StatusEffects/hypnosis.png"
#	if(!isHypnotized()):
#		return "res://Modules/HypnokinkModule/Icons/StatusEffects/hypno1.png"
#	elif(!isInTrance()):
#		return "res://Images/StatusEffects/hypnosissmall.png"
#	else:
	#	return "res://Images/StatusEffects/hypnosis.png"
	if(stacks < 20):
		return "res://Modules/NanoRevolution/Images/StatusEffects/goo_stage_1.png" 
	if(stacks < 50):
		return "res://Modules/NanoRevolution/Images/StatusEffects/goo_stage_2.png"
	return "res://Modules/NanoRevolution/Images/StatusEffects/goo_stage_3.png"

func getIconColor():
	# if(isInTrance()):
	# 	return IconColorBrightPurple
	# elif(isHypnotized()):
	# 	return IconColorDarkPurple
	# else:
	# 	return IconColorRed

	return IconColorGray

func getBuffs():
	var mult = 1.0
	var buffs = []
	if(stacks > 20):
		buffs.append(buff(Buff.PhysicalArmorBuff, [round(mult * (min(stacks - 20, 80)))]))
	if(stacks > 50):
		buffs.append(buff(Buff.ReceivedLustDamageBuff, [round(mult * -(min((stacks - 50) * 2, 99)))]))
	return buffs
	

func combine(_args = []):
	stacks += _args[0]
	# clampOrRemove()
	
func saveData():
	return {
		"stacks": stacks,
	}
	
func loadData(_data):
	stacks = SAVE.loadVar(_data, "stacks", 0)
	
# func clampOrRemove():
# 	var maximum = 100.0
# 	if(character.hasPerk(Perk.HypnosisDeepTranceDrawback)):
# 		maximum += 25.0
# 	if(stacks > maximum): 
# 		stacks = maximum
# 	elif(stacks <= 0):
# 		stop()
