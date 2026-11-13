class_name HUD
extends CanvasLayer
## Oyun içi arayüz. Sahip: A3 (feat/ui-audio). Sahne: res://scenes/ui/hud.tscn
## İçerik: durum metni, hamle listesi (SAN), Geri Al butonu, terfi seçim penceresi,
## oyun sonu penceresi. HUD oyun kuralı bilmez; metinleri GameController (A4) verir.
## Butonlar tıklanınca AudioManager.play(&"ui_click") HUD içinde çalınır.

@warning_ignore_start("unused_parameter")
@warning_ignore_start("unused_signal")

## "Geri Al" butonu.
signal undo_pressed
## Terfi penceresinde taş seçildi. piece: "q", "r", "b" veya "n" (küçük harf).
signal promotion_chosen(piece: String)
## Terfi penceresi seçim yapılmadan kapatıldı (hamle iptal).
signal promotion_cancelled
## Oyun sonu penceresindeki "Yeni oyun".
signal new_game_pressed
## Oyun sonu penceresindeki "Ana menü".
signal main_menu_pressed


## Durum satırı (ör. "Sıra sende (Beyaz)", "Şah! Sıra sende (Beyaz)",
## "Yapay zeka düşünüyor... (Orta)"). Boş string -> gizle.
func set_status(text: String) -> void:
	push_error("TODO HUD.set_status")


## Hamle listesini baştan yazar. sans[0] beyazın 1. hamlesi; HUD "1. e4 e5" biçiminde
## numaralandırır ve son hamleye kaydırır.
func set_moves(sans: PackedStringArray) -> void:
	push_error("TODO HUD.set_moves")


func set_undo_enabled(enabled: bool) -> void:
	push_error("TODO HUD.set_undo_enabled")


## Terfi penceresini açar. color: "w"/"b" (simgeler o renkte gösterilir).
## Sonuç promotion_chosen veya promotion_cancelled ile gelir.
func ask_promotion(color: String) -> void:
	push_error("TODO HUD.ask_promotion")


## Oyun sonu penceresini gösterir (ör. "Şah mat! Beyaz kazandı.").
func show_game_over(text: String) -> void:
	push_error("TODO HUD.show_game_over")


## Oyun sonu ve terfi pencerelerini kapatır (yeni oyun / geri al sonrası).
func hide_dialogs() -> void:
	push_error("TODO HUD.hide_dialogs")
