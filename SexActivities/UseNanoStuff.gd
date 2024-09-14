extends SexActivityBase

var tick = 0
func _init():
    id = "UseNanoStuff"
    startedByDom = true
    startedBySub = false

func getGoals(): return {}

func getVisibleName(): return "Use NanoStuff"

func getCategory(): return ["Use"]

func getDomTags(): return []

func getSubTags(): return []

func getSupportedSexTypes():
    return {
        SexType.DefaultSex: true,
        SexType.StocksSex: true,
        SexType.SlutwallSex: true,
    }

func getActivityBaseScore(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
    return 0.0

func canStartActivity(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
    return .canStartActivity(_sexEngine, _domInfo, _subInfo)

func getStartActions(_sexEngine: SexEngine, _domInfo: SexDomInfo, _subInfo: SexSubInfo):
    var actions = []
    var dom:BaseCharacter = _domInfo.getChar()
    # var sub:BaseCharacter = _subInfo.getChar()

    if (dom.getInventory().hasItemID("AutoBonder")):
        actions.append({
            name = "Auto Bond",
            desc = "Use your auto bonder to bond sub",
            args = ["sub"],
            score = 0.0,
            category = ["Use"]
        })
            # GlobalRegistry.getModule("Hypertus").logPrintOnDemand(str(actions))

    return actions
    
func startActivity(_args):
    state = ""

    if _args[0] == "sub":


        var text = RNG.pick([
            "You move back a little, and throw your auto bonder.",
        ])

        return { text = text }

func processTurn():
    var sub = getSub()
    var dom = getDom()
    var text = ""
    if state == "":
        
        tick += 1

        if(tick>1):
            dom.getInventory().removeXOfOrDestroy("AutoBonder",1)
            for item in sub.getInventory().forceRestraintsWithTag(ItemTag.CanBeForcedByGuards, RNG.randi_range(3,5)):
                var message = GM.ui.processString(item.getForcedOnMessage(false), {receiver=sub.getID()})
                GM.main.addMessage(message)
            endActivity()
            text = "The bonder activate!"
        else:
            text = "The bonder need one turn to activate."
    return {
        text = text,
    }


func saveData():
    var data = .saveData()

    return data

func loadData(data):
    .loadData(data)



func checkHasHyperable(bodyslot, _who:BaseCharacter): # this checks if _who have hyperable parts
    if _who != null:
        if _who.hasBodypart(bodyslot):
            if _who.bodypartHasTrait(bodyslot,"Hyperable"):
                return true
    return false