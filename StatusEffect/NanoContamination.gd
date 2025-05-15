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
	clampOrRemove()
	
func processBattleTurn():
	clampOrRemove()
	
func processTime(_seconds: int):
	# if is already an android,  prevent natrol fall off
	if(!isNanoAndroid()):
		var hours = (_seconds / 3600.0)

		stacks = stacks - hours
	clampOrRemove()

func onSleeping():
	stacks = min(stacks, 25)
	

func isNanoAndroid():
	return (stacks >= 100) #in trance threshold
		
func getEffectName():
	if(isNanoAndroid()):
		return "Nano Form"
	return "Contaminated"

func getEffectDesc():
	if(isNanoAndroid()):
		return "As an android, your nano body help you resist physical and heat damage, but permantly infertile."
	var text
	if(stacks <= 20):
		text = "Some black goo stick on your body. Sticky~ you can't pull it off."
	elif(stacks <= 70):
		text = "Some black goo starts to sink into your body; no matter how you wash it, you just can't get rid of it. Your skin takes on a strange dark color and begins to feel like latex. You can't tell... but you can feel the world starting to change in a strange way."
	elif(stacks <= 90):
		text = "Can't think clearly... "
	else:
		text = "..."
	return text + "\n\n("+str(ceil(stacks))+"%)"

func getEffectImage():
	if(isNanoAndroid()):
		return "res://Images/StatusEffects/hypnosis.png"
	if(!isHypnotized()):
		return "res://Modules/HypnokinkModule/Icons/StatusEffects/hypno1.png"
	elif(!isInTrance()):
		return "res://Images/StatusEffects/hypnosissmall.png"
	else:
		return "res://Images/StatusEffects/hypnosis.png"

func getIconColor():
	if(isInTrance()):
		return IconColorBrightPurple
	elif(isHypnotized()):
		return IconColorDarkPurple
	else:
		return IconColorRed

func getBuffs():
	var mult = 1.0
	var buffs = []
	if(stacks > 20):
		buffs.append(buff(Buff.PhysicalDamageBuff, [round(mult * -(min(stacks - 20, 80)))]))
	if(stacks > 25):
		buffs.append(buff(Buff.ForcedObedienceBuff, [round(mult * (min((stacks - 25) * (1 / 0.75), 100)))]))
	if(stacks > 40):
		buffs.append(buff(Buff.ReceivedLustDamageBuff, [round(mult * +(min((stacks - 40) * 0.5, 30)))]))
	return buffs
	

func combine(_args = []):
	stacks += _args[0]
	clampOrRemove()
	
func saveData():
	return {
		"stacks": stacks,
	}
	
func loadData(_data):
	stacks = SAVE.loadVar(_data, "stacks", 0)
	
func clampOrRemove():
	var maximum = 100.0
	if(character.hasPerk(Perk.HypnosisDeepTranceDrawback)):
		maximum += 25.0
	if(stacks > maximum): 
		stacks = maximum
	elif(stacks <= 0):
		stop()
