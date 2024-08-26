extends Species

func _init():
	id = "nanoAndroid"
	
func getVisibleName():
	return "Nano Andoird"

func getDefaultLegs(_gender):
	return "plantilegs"

func isPlayable():
	return false

func getVisibleDescription():
	return "Shouldn't see this...for now"

func getDefaultEars(_gender):
	return "humanears"

func getEggCellOvulationAmount():
	return [
		[1, 10.0],
		[2, 1.0],
		[3, 0.3],
	]

func getSkinType():
	return SkinType.Skin

func generateSkinColors():
	return ColorUtils.generateGenericHumanSkinColors()


func onDynamicNpcCreation(_npc, _args):

	# _npc.setGender(Gender.Androgynous)


		
	var _penis = _npc.getBodypart(BodypartSlot.Penis)
	_penis.lengthCM = 40
	var _breasts = _npc.getBodypart(BodypartSlot.Breasts)
	if(_breasts.size > BreastsSize.FOREVER_FLAT):
		if(_breasts.size < BreastsSize.O):
			
			_breasts.size = BreastsSize.O
	else:
		var NewBreasts = GlobalRegistry.createBodypart("humanbreasts")
		NewBreasts.size = BreastsSize.O
		_npc.giveBodypartUnlessSame(NewBreasts)
		

	var npcSkinData={
	"hair": {"r": Color("ff21253e"),"g": Color("ff4143a8"),"b": Color("ff000000"),},
	"penis": {"r": Color("ff242424"),"g": Color("ff070707"),"b": Color("ff01b2f9"),},
	}
	_npc.pickedSkin="HumanSkin"
	_npc.pickedSkinRColor=Color("ff080808")
	_npc.pickedSkinGColor=Color("ff363636")
	_npc.pickedSkinBColor=Color("ff678def")
	

	for bodypartSlot in npcSkinData:
		if(!_npc.hasBodypart(bodypartSlot)):
			#Log.error(getID()+" doesn't have "+str(bodypartSlot)+" slot but we're trying to paint it anyway inside paintBodyparts()")
			continue
		var bodypart = _npc.getBodypart(bodypartSlot)
		var bodypartSkinData = npcSkinData[bodypartSlot]
		if(bodypartSkinData.has("skin")):
			bodypart.pickedSkin = bodypartSkinData["skin"]
		if(bodypartSkinData.has("r")):
			bodypart.pickedRColor = bodypartSkinData["r"]
		if(bodypartSkinData.has("g")):
			bodypart.pickedGColor = bodypartSkinData["g"]
		if(bodypartSkinData.has("b")):
			bodypart.pickedBColor = bodypartSkinData["b"]
	_npc.updateAppearance()
	# Yeah, add some default
	_npc.skillsHolder.addPerk(Perk.StartNoHeat)
	_npc.skillsHolder.addPerk(Perk.StartInfertile)
	_npc.skillsHolder.addPerk(Perk.StartMaleInfertility)
