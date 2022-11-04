extends Control


onready var gameTitle = $GameTitle
onready var gameStatus = $GameStatus
onready var playerList = $PlayerList
onready var playerCountsTitle = $PlayersCountsTitle
onready var readyCount = $ReadyPlayersCount
onready var connectedCount = $ConnectedPlayersCount
onready var readyButton = $ReadyButton
onready var multiplayerHandler = get_node("/root/MultiplayerHandler")

func _ready():
	update_texts()

func update_texts():
	gameStatus.text = "Aguardando jogadores..."
	readyButton.text = "Pronto"
	gameTitle.text = "Titulo do jogo"
	playerCountsTitle.text = "Prontos  /  Conectados"

func add_player_to_list(player_info, player_id):
	var player_item = preload("res://menu/PlayerItem.tscn").instance()
	player_item.set_name(str(player_id))
	player_item.get_node("Control/PlayerName").text = player_info.name
	playerList.add_child(player_item)
	update_players_count()

func update_players_count():
	connectedCount.text = str(playerList.get_child_count())

func set_player_is_ready(who, is_ready):
	var player_item = playerList.get_node(who)
	player_item.get_node("Control/PlayerReady").pressed = is_ready
	update_ready_players_count()

func update_ready_players_count():
	var ready_players_count = 0
	for player in playerList.get_children():
		if player.get_node("Control/PlayerReady").pressed:
			ready_players_count += 1
	readyCount.text = str(ready_players_count)

func remove_player_from_list(who):
	playerList.get_node(who).queue_free()
