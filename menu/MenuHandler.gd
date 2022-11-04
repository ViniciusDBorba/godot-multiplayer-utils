extends Node

onready var initialMenu = $InitialMenu
onready var playerMenu = $PlayerMenu
onready var multiplayer_lobby = $MultiplayerLobby
onready var playerNameInput = $PlayerMenu/NameInput
onready var serverIpInput = $PlayerMenu/IpInput
onready var facButton = $PlayerMenu/SelectFacButton
onready var multiplayerHandler = get_node("/root/MultiplayerHandler")

	
func update_ui_texts():
	facButton.clear()
	playerMenu.get_node("PlayButton").text = "Jogar"
	playerMenu.get_node("Game Title").text = "Titulo do jogo"
	initialMenu.get_node("HostButton").text = "Iniciar servidor/Sala"
	initialMenu.get_node("ConnectButton").text = "Conectar a servidor"

func toggle_lobby_visibility():
	multiplayer_lobby.visible = !multiplayer_lobby.visible

func _on_PlayButton_pressed():
	multiplayerHandler.save_player_name(playerNameInput.text)
	multiplayerHandler.save_player_faction(facButton.get_item_metadata(facButton.get_selected_id()))
	playerMenu.visible = false
	var serverIp = serverIpInput.text
	if serverIp == null or serverIp == "":
		serverIp = "localhost"
	multiplayerHandler.connect_game(serverIp)

func _on_ReadyButton_pressed():
	multiplayerHandler.press_ready_button()

func _on_HostButton_pressed():
	multiplayerHandler.host_game()

func _on_ConnectButton_pressed():
	initialMenu.hide()
	playerMenu.show()
