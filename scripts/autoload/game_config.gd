extends Node
## Autoload "GameConfig". Sahip: A3 (feat/ui-audio).
## Ana menüden oyun sahnesine oyun ayarlarını taşır. Kalıcı DEĞİLDİR
## (kalıcı tercihler Settings autoload'ındadır).

@warning_ignore_start("unused_parameter")

enum Mode { VS_AI = 0, TWO_PLAYER = 1 }
enum ColorChoice { WHITE = 0, BLACK = 1, RANDOM = 2 }

const GAME_SCENE := "res://scenes/game.tscn"
const MAIN_MENU_SCENE := "res://scenes/ui/main_menu.tscn"

## Oyun modu.
var mode: Mode = Mode.VS_AI
## Menüde seçilen renk (Rastgele dahil). Menü bir sonraki açılışta bunu gösterir.
var color_choice: ColorChoice = ColorChoice.WHITE
## ÇÖZÜLMÜŞ oyuncu rengi: "w" veya "b". Rastgele seçimde resolve_color() belirler.
## TWO_PLAYER modunda anlamı yok ("w" kalır; kamera sıraya göre döner).
var player_color: String = "w"
## YZ seviyesi: ChessAI.Level (0 Kolay, 1 Orta, 2 Zor). Yalnızca VS_AI'de kullanılır.
var ai_level: int = 1


## color_choice'a göre player_color'ı belirler (RANDOM ise her çağrıda yeniden zar atar).
func resolve_color() -> void:
	push_error("TODO GameConfig.resolve_color")


## resolve_color() çağırır ve oyun sahnesine geçer. Ana menü "Başla" ve
## duraklatma menüsü "Yeni oyun" bunu kullanır.
func start_game() -> void:
	push_error("TODO GameConfig.start_game")


## Ana menüye döner (duraklatmayı kaldırır).
func go_to_main_menu() -> void:
	push_error("TODO GameConfig.go_to_main_menu")
