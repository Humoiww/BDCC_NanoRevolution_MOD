extends Character

func _init():
	id = "humoi"
	
	npcLevel = 7
	npcBasePain = 80
	npcBaseLust = 80
	npcCharacterType = CharacterType.Inmate
	
	pickedSkin="MonsterGirl"
	pickedSkinRColor=Color("ffffffff")
	pickedSkinGColor=Color("ff227f81")
	pickedSkinBColor=Color("ff43e0ec")
	npcSkinData={
		"head": {"skin": "EmptySkin","g": Color("ff0d0909"),"b": Color("ff8a6161"),},
		"tail": {"skin": "CyberneticSkin","b": Color("ffb24695"),},
	}
	
	npcPersonality = {
		PersonalityStat.Brat: -1.0,
		PersonalityStat.Mean: -0.8,
		PersonalityStat.Subby: 1.0,
		PersonalityStat.Impatient: -0.6,
		PersonalityStat.Naive: -0.8,
		PersonalityStat.Coward: -0.8,
	}
	
	npcFetishes = {
		Fetish.AnalSexReceiving : FetishInterest.SlightlyLikes,
		Fetish.AnalSexGiving : FetishInterest.Neutral,
		Fetish.VaginalSexGiving : FetishInterest.Likes,
		Fetish.OralSexReceiving : FetishInterest.Likes,
		Fetish.OralSexGiving : FetishInterest.Likes,
		Fetish.Sadism : FetishInterest.SlightlyLikes,
		Fetish.Masochism : FetishInterest.Likes,
		Fetish.UnconsciousSex : FetishInterest.Hates,
		Fetish.BeingBred : FetishInterest.Likes,
		Fetish.Bondage : FetishInterest.Neutral,
		Fetish.Condoms : FetishInterest.Neutral,
		Fetish.DrugUse : FetishInterest.Loves,
		Fetish.Exhibitionism : FetishInterest.SlightlyLikes,
		Fetish.HypnosisHypnotist : FetishInterest.SlightlyLikes,
		Fetish.HypnosisSubject : FetishInterest.SlightlyLikes
	}
	
	npcLustInterests = {
		InterestTopic.TallyMarks: Interest.ReallyLikes,
		InterestTopic.Bodywritings: Interest.Loves,
		InterestTopic.FeminineBody: Interest.Likes,
		InterestTopic.AndroBody: Interest.Likes,
		InterestTopic.MasculineBody: Interest.Neutral,
		InterestTopic.ThickBody: Interest.Likes,
		InterestTopic.SlimBody: Interest.KindaLikes,
		InterestTopic.MediumBreasts: Interest.Likes,
		InterestTopic.BigBreasts: Interest.ReallyLikes,
		InterestTopic.LactatingBreasts: Interest.KindaLikes,
		InterestTopic.StuffedPussy: Interest.Neutral,
		InterestTopic.Pregnant: Interest.Neutral,
		InterestTopic.StuffedThroat: Interest.KindaLikes,
		InterestTopic.CoveredInCum: Interest.Likes,
		InterestTopic.CoveredInLotsOfCum: Interest.KindaLikes,
		InterestTopic.FullyNaked: Interest.ReallyLikes,
		InterestTopic.ExposedPussy: Interest.Likes,
		InterestTopic.ExposedAnus: Interest.KindaLikes,
		InterestTopic.ExposedBreasts: Interest.Likes,
		InterestTopic.ExposedCock: Interest.Likes,
		InterestTopic.ExposedPanties: Interest.SlightlyDislikes,
		InterestTopic.ExposedBra: Interest.SlightlyDislikes,
		InterestTopic.LooseAnus: Interest.SlightlyDislikes,
		InterestTopic.LoosePussy: Interest.SlightlyDislikes,
		InterestTopic.TightAnus: Interest.KindaLikes,
		InterestTopic.TightPussy: Interest.KindaLikes,
		InterestTopic.NoVagina: Interest.Dislikes,
		InterestTopic.HasVaginaOnly: Interest.Neutral,
		InterestTopic.HasVaginaAndCock: Interest.ReallyLikes,
		InterestTopic.BigCock: Interest.Likes,
		InterestTopic.AverageCock: Interest.ReallyLikes,
		InterestTopic.SmallCock: Interest.Likes,
		InterestTopic.NoCock: Interest.Neutral,
		InterestTopic.HasCockOnly: Interest.Dislikes,
	}
	

func getDefaultArtwork(_variant = []):
	return "res://Modules/NanoRevolution/Images/Humoi_avator/Humoi_avator.png"


func _getName():
	return "Humoi"

func getGender():
	return Gender.Androgynous
	
func getChatColor():
	return "#43e0ec"
	
func getSmallDescription() -> String:
	return "A lilac fluffy dragon inmate. Holding a datapad for some reason."

func getSpecies():
	return ["dragon","canine"]
	
func _getAttacks():
	return ["biteattack", "simplekickattack", "stretchingAttack", "lickWounds", "shoveattack", "trygetupattack"]

func getThickness() -> int:
	return 60

func getFemininity() -> int:
	return 85

func createBodyparts():
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("dragonhead"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("messyhair2"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anthrobody"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anthroarms"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("dragonhorns"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("wolfears"))
	var breasts = GlobalRegistry.createBodypart("humanbreasts")
	breasts.size = 10
	giveBodypartUnlessSame(breasts)
	var penis = GlobalRegistry.createBodypart("dragonpenis")
	penis.lengthCM = 28
	penis.ballsScale = 1
	giveBodypartUnlessSame(penis)
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("vagina"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anus"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("digilegs"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("dragontail"))
	
	
func getLootTable(_battleName):
	return InmateLoot.new()

func getDefaultEquipment():
	return ["inmatecollar", "inmateuniformSexDeviant"]
