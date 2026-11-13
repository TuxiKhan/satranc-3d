class_name GameController
extends Node
## Oyun akışı. Sahip: A4 (feat/integration). Sahne: res://scenes/game.tscn
##
## Sorumluluklar (Python ChessApp'in karşılığı):
##   - pos / history / moves / sans / legal durumunu tutar.
##   - Board3D.square_clicked ile seçim + hamle mantığı (Python on_press/try_move).
##   - Terfi: HUD.ask_promotion -> promotion_chosen / promotion_cancelled.
##   - Hamleyi uygular, Board3D.animate_move çağırır, move_animation_finished'te
##     ses çalar (AudioManager), vurguları/HUD'u günceller, oyun sonunu kontrol eder.
##   - YZ: Thread içinde ChessAI.choose_move; token + ChessAI.StopToken ile iptal
##     (Geri Al / Yeni oyun / Ana menü / sahne kapanışı). Thread her zaman
##     wait_to_finish ile toplanır.
##   - 2 kişilik modda her hamleden sonra Board3D.face_side(pos.turn, true).
##   - Geri Al (Python undo ile aynı kural, YZ modunda).

@onready var board: Board3D = $Board3D
@onready var hud: HUD = $HUD
@onready var pause_menu: PauseMenu = $PauseMenu


func _ready() -> void:
	pass # TODO(A4)
