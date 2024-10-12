extends ItemBase

var charges:int = 1

func useCharge(amount = 1):
	charges -= amount
	if(charges <= 0):
		removeXOrDestroy(1)

func getCharges():
	return charges

func getDamageRange():
	return [30, 40]

func _init():
	id = "NanoBrick"

func getVisibleName():
	return "Nano Brick"

func getDescription():
	var text = "From the first stirrings of life beneath water... to the great beasts of the Stone Age... to man taking his first upright steps, you have come far. Now, harnessing the combined power of all intelligence, you’ve created this — the Nano Brick! Use it to deliver a powerful shock to your enemy’s mind, physically, of course. \n\n Usage: throw this to enemy."

	return text

func saveData():
	var data = .saveData()
	
	data["charges"] = charges
	
	return data
	
func loadData(data):
	.loadData(data)
	
	charges = SAVE.loadVar(data, "charges", 1)

func getAttacks():
	return ["NanoBrickPCAttack"]

func getTags():
	return [ItemTag.Illegal]

func getItemCategory():
	return "Nano"

func getInventoryImage():
	return "res://Images/Perks/mansory.png"
