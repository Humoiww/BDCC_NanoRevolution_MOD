extends "res://Game/InteractionSystem/PawnTypeBase.gd"
var SexDollGenerator = preload("res://Modules/NanoRevolution/Characters/Dynamic/Generator/SexDollGenerator.gd")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _init():
	id = "SexDoll"



func getDistributionWeight() -> float:
	return 2.0

func getSpawnLocations(_character) -> Array:
	return ["main_stairs1", "main_stairs2"]
	# if(_character == null):
		
		
	# var inmateType = _character.getInmateType()
	
	# if(inmateType == InmateType.SexDeviant):
	# 	return ["main_stairs1", "main_stairs2", "cellblock_lilac_nearcell"]
	# elif(inmateType == InmateType.HighSec):
	# 	return ["main_stairs1", "main_stairs2", "cellblock_red_nearcell"]
	
	# return ["main_stairs1", "main_stairs2", "cellblock_orange_nearcell"]
func onPawnSpawned(_pawn):
	# var interaction = GlobalRegistry.createInteraction("Talking")
	# _pawn.setInteraction(interaction)
	pass


	
func getCharacterPool() -> String:
	return "SexDoll"

func getCharacterGenerator():
	return SexDollGenerator.new()


func getCustomPawnColor(_pawn):
	return Color.gray

func customCheckAlonePawnInteraction(_pawn) -> bool:
	if(_pawn.currentInteraction == null):
		# GM.main.IS.startInteraction("AloneInteraction", {main = _pawn.charID}, {})
		GM.main.IS.startInteraction("NanoBaseInteraction", {main = _pawn.charID}, {})
	return true

func shouldPawnInterruptOtherPawns(_pawn) -> bool:
	return false
