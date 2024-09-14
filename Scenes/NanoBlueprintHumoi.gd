extends SceneBase

var bratCounter = 0
var craftingItemsTags = []
var craftingItems = [
	"NanoBrick"
	]
var sortedItemsIds = []
var finalcraftingItemsObjects = []

var lockedInto = false
var justPurchased = false
func _init():
	sceneID = "NanoBlueprintHumoi"

func displayCoreCount(amount):
	if amount > 1:
		saynn("You have "+ str(amount) +" cores.")
	elif amount > 0:
		saynn("You have only one core.")
	else:
		saynn("You don't have any core.")

func sayCharater(ch,text):
	saynn("[say=" +ch+ "]" +text + "[/say]")

func _initScene(_args = []):
	if(_args.size() > 0):
		lockedInto = true
		setState(_args[0])
		if(_args.size() > 1):
			craftingItemsTags = _args[1]
	var craftableItem = GM.main.getModuleFlag("NanoRevolutionModule", "NanoCraftableItem", {})
	for itemID in craftableItem:
		if craftableItem[itemID] == true:
			craftingItems.append(itemID)
	var craftableTag = GM.main.getModuleFlag("NanoRevolutionModule", "NanoCraftableTag", {})
	for tag in craftableTag:
		if craftableTag[tag] == true:
			craftingItemsTags.append(tag)

func addTagItem(tag,name,description,nameshort,cost,amount):
	if tag in craftingItemsTags:
		sayn("(Purchased)- " + name + "\n-- Cost: " + str(cost) + " cores")
		addDisabledButton(nameshort,"You've learnt this blueprint")
	else:
		sayn("- " + name + "\n-- Cost: " + str(cost) + " cores")
		if(amount >= cost):
			addButton(nameshort,"Buy this (" + str(cost)+ " cores)","trade_tag",[tag,cost])
		else:
			addDisabledButton(nameshort,"You can't afford this :<")
	saynn(description)


func addItem(item,name,description,nameshort,cost,amount):
	if item in craftingItems:
		sayn("(Purchased)- " + name + "\n-- Cost: " + str(cost) + " cores")
		addDisabledButton(nameshort,"You've learnt this blueprint")
	else:
		sayn("- " + name + "\n-- Cost: " + str(cost) + " cores")
		if(amount >= cost):
			addButton(nameshort,"Buy this (" + str(cost)+ " cores)","trade_item",[item,cost])
		else:
			addDisabledButton(nameshort,"You can't afford this :<")
	saynn(description)
	
		
	

func _run():
	if(state == ""):
		
		addCharacter("humoi")
		playAnimation(StageScene.Duo, "stand", {npc="humoi"})
		if (!getModuleFlag("NanoRevolutionModule","NanoAfterFirstBlueprintHumoi",false)):
			sayCharater("humoi","Great, you’re interested in blueprints for using those nano cores! I’ve got you covered. I offer two types of blueprints:")

			sayCharater("humoi","First, these are general Blueprint Sets and can be used to craft a variety of common items.")

			sayCharater("humoi","Second, these are for crafting special, one-of-a-kind items. You can only obtain these items by using the blueprints, as they’re specifically designed by me.")
			setModuleFlag("NanoRevolutionModule","NanoAfterFirstBlueprintHumoi",true)
		saynn("[say=humoi]Did anything catch your eye?[/say]")

		addButton("General","You want to check more general blueprint sets","tag_select")
		addButton("Special","You want to check something special","item_select")

		
		addButton("Leave","I think that's it","endthescene")
	if(state == "tag_select"):
		if justPurchased:
			sayCharater("humoi","Thank you! I've upload the blueprint set to your device.")
			justPurchased = false
		else:
			saynn("[say=humoi]OK, here's some general blueprints[/say]")
		var coreAmount = GM.pc.getInventory().getAmountOf("NanoCore")
		displayCoreCount(coreAmount)

		if(GM.main != null && (GM.main.getFlag("PortalPantiesModule.Panties_PcDenied") || GM.main.getFlag("PortalPantiesModule.Panties_FleshlightsReturnedToAlex"))):
			addTagItem(ItemTag.SoldByAlexRynard,
			"Alex Rynard's Collection",
			"I got some prototypes from Alex and whipped up an alternative version using nano cores.",
			"Alex",
			4,coreAmount)

		addTagItem(ItemTag.SoldByTheAnnouncer,
		"Fight Club Collection",
		"A set of blueprints containing all stuff from fight club announcer",
		"Fight Club",
		2,coreAmount)

		addTagItem(ItemTag.CanBeForcedByGuards,
		"Guard Restrict Collection",
		"A collection containing all BDSM device that the guard may force on you.",
		"Guard BDSM",
		3,coreAmount)

		if(GM.pc.hasPerk("NanoCraftingT2")):
			addTagItem(ItemTag.SoldByMedicalVendomat,
			"Medical Collection",
			"A collection for crafting medical items. You’ll need some solid skills to make sure everything turns out right and avoids any health issues.",
			"Medical",
			4,coreAmount)



		addButtonAt(10,"Special","You want to check something special","item_select")
		addButtonAt(14,"Leave","I think that's it","endthescene")

	if(state == "item_select"):
		if justPurchased:
			sayCharater("humoi","Thank you! I've upload the blueprint to your device.")
			justPurchased = false
		else:
			saynn("[say=humoi]Awesome, these are my special blueprints.[/say]")
		var coreAmount = GM.pc.getInventory().getAmountOf("NanoCore")
		displayCoreCount(coreAmount)

		addItem("InstantCharger",
		"Instant Charger",
		"A small charger that charge your controller instantly.",
		"Charger",
		3,coreAmount)


		addButtonAt(10,"General","You want to check more general blueprint sets","tag_select")
		addButtonAt(14,"Leave","I think that's it","endthescene")



func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "trade"):
		GM.pc.getInventory().removeXOfOrDestroy("NanoCore",1)
		GM.pc.addCredits(3)
		setState("trade")
		return

	if(_action == "ask_key"):
		GM.main.setModuleFlag("NanoRevolutionModule", "NanoAskHumoiKey", true)

	if(_action == "aftercare"):
		processTime(30*60)

	if(_action == "trade_tag"):
		var tagToTrade = _args[0]
		var cost = _args[1]
		craftingItemsTags.append(tagToTrade)
		GM.pc.getInventory().removeXOfOrDestroy("NanoCore",cost)
		justPurchased = true
		var craftableTag = GM.main.getModuleFlag("NanoRevolutionModule", "NanoCraftableTag", {})
		craftableTag[tagToTrade] = true
		GM.main.setModuleFlag("NanoRevolutionModule", "NanoCraftableTag", craftableTag)
		setState("tag_select")
		return

	if(_action == "trade_item"):
		var itemToTrade = _args[0]
		var cost = _args[1]
		craftingItemsTags.append(itemToTrade)
		GM.pc.getInventory().removeXOfOrDestroy("NanoCore",cost)
		justPurchased = true
		var craftableItem = GM.main.getModuleFlag("NanoRevolutionModule", "NanoCraftableItem", {})
		craftableItem[itemToTrade] = true
		GM.main.setModuleFlag("NanoRevolutionModule", "NanoCraftableItem", craftableItem)
		setState("tag_select")
		return
	

	setState(_action)

func saveData():
	var data = .saveData()

	return data

func loadData(data):
	.loadData(data)

