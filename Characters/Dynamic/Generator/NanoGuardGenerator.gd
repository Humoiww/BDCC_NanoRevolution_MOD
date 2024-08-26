extends CharacterGeneratorBase
class_name NanoGuardGenerator

func pickCharacterType(character:DynamicCharacter, _args = {}):
	character.npcCharacterType = "NanoGuard"

func pickGender(character:DynamicCharacter, _args = {}):
	character.npcGeneratedGender = NpcGender.Herm

func pickSpecies(character:DynamicCharacter, _args = {}):
	# if(_args.has(NpcGen.Species)):
	# 	character.npcSpecies = [_args[NpcGen.Species]]
	# 	return
	

	
	# character.npcSpecies = [randomSpecies]
	character.npcSpecies = ["nanoAndroid"]

func createBodyparts(character:DynamicCharacter, _args = {}):
	# When a new nano Android appear, it will randomly simulate one existed species
	
	var speciesType = pickedSpeciesType(_args)
	var allSpecies = GlobalRegistry.getAllSpecies()
	var possible = []
	for speciesID in allSpecies:
		var specie = allSpecies[speciesID]
		if(!specie.canBeUsedForNPCType(speciesType)):
			continue
		
		var weight = GM.main.getEncounterSettings().getSpeciesWeight(speciesID)
		if(weight != null && weight > 0.0):
			possible.append([speciesID, weight])
	
	var randomSpecies = RNG.pickWeightedPairs(possible)
	if(randomSpecies == null):
		randomSpecies = Species.Canine
	
	var theSpecies = [randomSpecies]
	for bodypartSlot in BodypartSlot.getAll():
		possible = []
		var fullWeight = 0.0
		#if(!BodypartSlot.isEssential(bodypartSlot)):
		#	possible.append([null, 1.0])
		
		var allbodypartsIDs = GlobalRegistry.getBodypartsIdsBySlot(bodypartSlot)
		for bodypartID in allbodypartsIDs:
			var bodypart = GlobalRegistry.getBodypartRef(bodypartID)
			var supportedSpecies = bodypart.getCompatibleSpecies()
			
			var hasInSupported = false
			var hasInAllowed = false
			
			for supported in supportedSpecies:
				if((supported in theSpecies) || supported == Species.AnyNPC): # || supported == Species.Any
					hasInSupported = true
					break
				
			for playerSpecie in theSpecies:
				var speciesObject = GlobalRegistry.getSpecies(playerSpecie)
				if(bodypartID in speciesObject.getAllowedBodyparts()):
					hasInAllowed = true
					break
			
			if(hasInSupported || hasInAllowed):
				var weight = bodypart.npcGenerationWeight(character)
				if(weight != null && weight > 0.0):
					possible.append([bodypartID, weight])
					fullWeight += weight

		# Adding the default bodypart of this species into the mix
		for specie in theSpecies:
			var speciesObject = GlobalRegistry.getSpecies(specie)
			var bodypartID = speciesObject.getDefaultForSlotForNpcGender(bodypartSlot, character.npcGeneratedGender)
			var alreadyHasInPossible = false
			for possibleEntry in possible:
				if(possibleEntry[0] == bodypartID):
					alreadyHasInPossible = true
					break
			if(alreadyHasInPossible):
				continue
			if(bodypartID == null):
				possible.append([null, 1.0])
				fullWeight += 1.0
				continue
			var bodypart = GlobalRegistry.getBodypartRef(bodypartID)
			var weight = bodypart.npcGenerationWeight(character)
			if(weight != null && weight > 0.0):
				possible.append([bodypartID, weight])
				fullWeight += weight

		#print(bodypartSlot, " ", possible) # Uncomment for debug
		if(possible.size() > 0):
			if(!RNG.chance(fullWeight * 100.0)):
				continue
			
			var bodypartID = RNG.pickWeightedPairs(possible)
			if(bodypartID != null):
				var bodypart = GlobalRegistry.createBodypart(bodypartID)
				character.giveBodypartUnlessSame(bodypart)
				bodypart.generateDataFor(character)


func getAttacks():
	return ["SentinelHeatGrenade", "SentinelLatexBarrage", "SentinelLatexStrike", "SentinelLatexSlam", "SentinelLatexRegeneration", "trygetupattack"]

func getPossibleAttacks():
	return ["DoubleCuffPC", "CuffPCHands", "ForceGagPC", "ForceMuzzlePC"]

func pickEquipment(character:DynamicCharacter, _args = {}):
	
	var theEquipment = []
	
	character.npcDefaultEquipment = theEquipment

func pickLustInterests(character:DynamicCharacter, _args = {}):
	var interestWeights = [
		[Interest.Hates, 0],
		[Interest.ReallyDislikes, 0],
		[Interest.Dislikes, 0],
		[Interest.SlightlyDislikes, 0],
		[Interest.KindaLikes, 0],
		[Interest.Likes, 1.0],
		[Interest.ReallyLikes, 1.0],
		[Interest.Loves, 1.0],
	]
	
	for topicA in GlobalRegistry.getLustTopicObjects():
		var topic: TopicBase = topicA
		var handlesIDs = topic.handles_ids
		for id in handlesIDs:
			var pickedInterest = RNG.pickWeightedPairs(interestWeights)
			
			if(pickedInterest != Interest.Neutral):
				character.getLustInterests().addInterest(id, pickedInterest)



func pickSmallDescription(character:DynamicCharacter, _args = {}):
	var text = "One of the guards. "+str(.pickSmallDescription(character, _args))

	var level = character.npcLevel
	
	var possibleRanks = []
	
	if(level <= 6):
		possibleRanks.append_array([
			NpcRank.Spacer,
			NpcRank.SpaceCadet,
		])
	
	if(level >= 5 && level <= 10):
		possibleRanks.append_array([
			NpcRank.Inspector,
			NpcRank.ChiefInspector,
			NpcRank.Sergeant,
		])
	
	if(level >= 8 && level <= 15):
		possibleRanks.append_array([
			NpcRank.PettyOfficer,
			NpcRank.ChiefPettyOfficer,
		])

	if(level >= 13):
		possibleRanks.append_array([
			NpcRank.Lieutenant,
			NpcRank.Executor,
		])
	
	var pickedRank = RNG.pick(possibleRanks)
	if(pickedRank == null):
		pickedRank = NpcRank.Spacer
	
	character.setFlag(CharacterFlag.Rank, pickedRank)
	
	text = NpcRank.getVisibleName(pickedRank)+". "+text
	return text
