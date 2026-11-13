class_name PauseMenu
extends CanvasLayer
## Duraklatma menüsü. Sahip: A3 (feat/ui-audio). Sahne: res://scenes/ui/pause_menu.tscn
## process_mode = ALWAYS. `pause` action'ını (Esc) KENDİSİ dinler: açar/kapatır ve
## get_tree().paused değerini yönetir. Butonlar: Devam, Yeni oyun, Ayarlar, Ana menü.
## "Ayarlar" kendi içindeki settings_menu örneğini açar (dışarıya sinyal yok).
## Oyun sonu penceresi açıkken de Esc ile açılabilir.

@warning_ignore_start("unused_signal")

signal opened
signal closed
## "Yeni oyun" -> GameController aynı ayarlarla yeniden başlatır.
signal new_game_pressed
## "Ana menü" -> GameController AI thread'ini durdurur, GameConfig.go_to_main_menu().
signal main_menu_pressed


func open() -> void:
	push_error("TODO PauseMenu.open")


## Devam: menüyü kapatır, get_tree().paused = false.
func close() -> void:
	push_error("TODO PauseMenu.close")


func is_open() -> bool:
	return false
