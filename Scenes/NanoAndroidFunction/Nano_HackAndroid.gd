extends ComputerBase

var connectedTo = ""
var plugSpeed = 0
var lastCageCmd = "disconnect"
var keyAccepted = false
var key = ""

func int_to_hex(value: int) -> String:
	var hex_string = ""
	var hex_chars = "0123456789abcdef"
	while value > 0:
		hex_string = hex_chars[value % 16] + hex_string
		value = int(floor(value / 16.0))
	
	if hex_string == "":
		hex_string = "0"
	
	return hex_string
func _init():
	id = "HackAndroid"
	introText = "Nano Android Access Terminal."
	keyAccepted = false


func reactToCommand(_command:String, _args:Array, _commandStringRaw:String):
	var password = int_to_hex(1664525 * GM.main.getTime() + 1013904223 % (2^32))
	key = password.substr(2, password.length())
	if GM.main.getModuleFlag("NanoRevolutionModule", "NanoKnowAndroidKey", false):
		learnCommand("Key_Generate")
	if keyAccepted:
		return reactToCommandAndroid(_command, _args, _commandStringRaw)
	else:
		return keyAccessCommand(_command, _args, _commandStringRaw)

func keyAccessCommand(_command: String, _args:Array, _commandStringRaw:String):
	if(_command == ""):
		return "Please enter the key to access the terminal"
	if(_command == "Key_Generate"):
		learnCommand(key)
		return "Key: "+ key + " is generated."
		
	if(_command == "key"):

		if(_args.size() == 1):
			var received_key = _args[0]
			if(received_key == key):
				keyAccepted = true
				return "Key:" + key + " accepted."
			else:
				return "Invalid key, please try again."
		else:
			return "This command expects 1 argument"

		

	if(_command == "help"):
		if(_args.size() == 1):
			var tolearn = _args[0]
			if(tolearn == "help"):
				return "This command outputs all other commands and can also provide help for certain command by typing 'help <COMMAND>'."
			elif(tolearn == "exit"):
				return "This command exits the program."
			elif(tolearn == "key"):
				return "This command lets you input key to access.\nSyntax 'key <password_string>'"
			else:
				return "Couldn't find command '"+str(tolearn)+"'. To see all the available commands type 'help'."
			
		elif(_args.size() == 0):
			learnCommand("help")
			learnCommand("exit")
			learnCommand("key")
			return "Available commands are: \nexit\nhelp\nkey\nTo learn more about a command type 'help <COMMAND>'"
		else:
			learnCommand("help")
			return "'help' expects 0 or 1 arguments"

	if(_command == "exit"):
		markFinishedFail()
		return "Disconnect Success!"
	learnCommand("help")
	return "Invalid command, type 'help' to see known command"

	
func reactToCommandAndroid(_command: String, _args:Array, _commandStringRaw:String):
	if(_command == "switch"):
		if(_args.size() >= 1):
			var parse = _args[0]
			if(parse in ['-m',"--mode"]):
				if(_args.size() >= 2):
					var mode = _args[1]
					if(mode in ["guard", "1"]):
						markFinished(["guard"])
						return "Switch to guard mode"
					if(mode in ["sex", "2"]):
						markFinished(["sex"])
						return "Switch to sex mode"
					else:
						return "Swtich to "+mode+" mode...\nMode not found."
				else:
					return "mode variable need 1 argument"
			elif(parse in ['-l',"--list"]):
				learnCommand("guard")
				learnCommand("sex")
				return "Available mode: \n1.guard\n2.sex\n type 'switch --mode <mod>' to apply the mode"
		else:
			return "This command expects 1 argument"
	
	if(_command == "probe"):
		if(_args.size() == 0):
			return "Scanning...\nDone. Found 4 devices.\n1 - grd_radio_3511\n2 - grd_radio_1447\n3 - deloxekarat_default\n4 - viplug_m_default"
		else:
			return "This command expects 0 arguments"
			
	if(_command == "exit"):
		return "Disconnect Successs."
		
	if(_command == "help"):
		if(_args.size() == 1):
			var tolearn = _args[0]
			if(tolearn == "help"):
				return "This command outputs all other commands and can also provide help for certain command by typing 'help <COMMAND>'."
			elif(tolearn == "switch"):
				learnCommand("--mode")
				learnCommand("--list")
				return "This command switch your android to target mode. Syntax 'switch --mode <target_mode>', type 'switch --list' to show all available mode."

			elif(tolearn == "exit"):
				return "This command exits the program."
			else:
				return "Couldn't find command '"+str(tolearn)+"'. To see all the available commands type 'help'."
			
		elif(_args.size() == 0):
			learnCommand("help")
			learnCommand("switch")
			learnCommand("exit")
			return "Available commands are: \nhelp\nswitch\nxit\nTo learn more about a command type 'help <COMMAND>'"
		else:
			learnCommand("help")
			return "'help' expects 0 or 1 arguments"
			
	learnCommand("help")
	return "Error, unknown command. Use 'help' to list all available commands"
	
const memPosMap = {
			"unlock": "[color=#88FF88][6,8][/color] (5 bytes read)",
			"disconnect": "[color=#88FF88][4,16][/color] (10 bytes read)",
			"monitor": "[color=#88FF88][8,0][/color] (170 bytes read)",
			"help": "[color=#FF8888][17,4][/color] (78 bytes read)",
			"strscan": "[color=#FF8888][external memory][/color] (? bytes read)",
		}
		
const strMap = {
			"1": [" [color=#88FF88][0,8][/color] ", "DeLoxe S3-Karat v1.0.7"],
			"2": [" [color=#88FF88][1,8][/color] ", "SEGFAULT at: %s"],
			"3": [" [color=#88FF88][2,0][/color] ", "Vion"],
			"4": [" [color=#88FF88][2,24][/color]", "locked"],
			"5": [" [color=#88FF88][3,0][/color] ", "unlocked"],
			"6": [" [color=#88FF88][3,12][/color]", "Operating"],
			"7": [" [color=#88FF88][3,24][/color]", "Inactive"],
			"8": [" [color=#88FF88][4,16][/color]", "Disconnecting..."],
			"9": [" [color=#88FF88][5,4][/color] ", "Ready."],
			"10": ["[color=#88FF88][6,0][/color] ", "default"],
			"11": ["[color=#88FF88][6,8][/color] ", "block"],
			"12": ["[color=#88FF88][6,20][/color]", "override"],
			"13": ["[color=#88FF88][7,0][/color] ", "Code "],
			"14": ["[color=#88FF88][7,8][/color] ", "valid."],
			"15": ["[color=#88FF88][7,16][/color]", "invalid."]
		}


func saveData():
	var data = .saveData()
	
	data["connectedTo"] = connectedTo
	data["plugSpeed"] = plugSpeed
	data["lastCageCmd"] = lastCageCmd
	
	return data
	
func loadData(data):
	.loadData(data)
	
	connectedTo = SAVE.loadVar(data, "connectedTo", "")
	plugSpeed = SAVE.loadVar(data, "plugSpeed", 0)
	lastCageCmd = SAVE.loadVar(data, "lastCageCmd", "disconnect")

