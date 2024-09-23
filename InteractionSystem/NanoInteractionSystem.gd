extends InteractionSystem
# So I was wandering if new system is needed, lets see

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# func spawnPawn(charID):
# 	if(charID == null):
# 		return
# 	var character:BaseCharacter = GlobalRegistry.getCharacter(charID)
# 	if(character == null):
# 		return
# 	var newPawn: CharacterPawn = CharacterPawn.new()
# 	newPawn.charID = charID
	
# 	if(pawns.has(charID)):
# 		deletePawn(charID)
# 	pawns[charID] = newPawn
	
# 	if(charID == "pc"):
# 		newPawn.setLocation(GM.pc.getLocation())
# 	else:
# 		var newLoc:String = "main_punishment_spot"
# 		var charType = character.getCharacterType()
		
# 		if(charType == CharacterType.Inmate):
# 			var inmateType = character.getInmateType()
			
# 			if(inmateType == InmateType.SexDeviant):
# 				newLoc = GM.world.getSafeFromPCRandomRoom(["main_stairs1", "main_stairs2", "cellblock_lilac_nearcell"], GM.pc.getLocation())
# 			elif(inmateType == InmateType.HighSec):
# 				newLoc = GM.world.getSafeFromPCRandomRoom(["main_stairs1", "main_stairs2", "cellblock_red_nearcell"], GM.pc.getLocation())
# 			else:
# 				newLoc = GM.world.getSafeFromPCRandomRoom(["main_stairs1", "main_stairs2", "cellblock_orange_nearcell"], GM.pc.getLocation())
# 		elif(charType == CharacterType.Guard):
# 			newLoc = GM.world.getSafeFromPCRandomRoom(["hall_elevator", "main_greenhouses"], GM.pc.getLocation())
# 		elif(charType == CharacterType.Nurse):
# 			newLoc = "med_elevator"
# 		elif(charType == CharacterType.Engineer):
# 			newLoc = "mining_elevator"
# 		elif(charType == "NanoGuard"):
# 			newLoc = GM.world.getSafeFromPCRandomRoom(["hall_elevator", "main_greenhouses"], GM.pc.getLocation())
		
# 		newPawn.setLocation(newLoc)
	
# 	var loc = newPawn.getLocation()
# 	if(!pawnsByLoc.has(loc)):
# 		pawnsByLoc[loc] = {}
# 	pawnsByLoc[loc][charID] = true
	
# 	usedCharIDsToday[charID] = true
	
# 	newPawn.onSpawn()
# 	return newPawn



