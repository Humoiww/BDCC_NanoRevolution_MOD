extends "res://Game/InteractionSystem/PawnTypeBase.gd"
var NanoGuardGenerator = preload("res://Modules/NanoRevolution/Characters/Dynamic/Generator/NanoGuardGenerator.gd")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _init():
	id = "NanoGuard"



func getDistributionWeight() -> float:
	return 2.0

func getSpawnLocations(_character) -> Array:
	return ["hall_elevator"]
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
	return "NanoGuard"

func getCharacterGenerator():
	return NanoGuardGenerator.new()


func getCustomPawnColor(_pawn):
	return Color( 0.5, 0.5, 1, 1 )

func customCheckAlonePawnInteraction(_pawn) -> bool:
	if(_pawn.currentInteraction == null): #This condition is important, allowing goal transition.
		GM.main.IS.startInteraction("NanoGuardBaseInteraction", {main = _pawn.charID}, {})
	return true

func shouldPawnInterruptOtherPawns(_pawn) -> bool:
	return false
