class_name SettingsMenu
extends Control
## Ayarlar paneli (ses + grafik). Sahip: A3 (feat/ui-audio).
## Sahne: res://scenes/ui/settings_menu.tscn — ana menü ve duraklatma menüsü içinde
## örneklenir. Değerleri Settings autoload'ından okur, Settings.set_value ile yazar.
## process_mode = ALWAYS (duraklatılmış oyunda da çalışır).

@warning_ignore_start("unused_signal")

## "Geri" butonu / Esc -> panel kapandı.
signal closed


func open() -> void:
	push_error("TODO SettingsMenu.open")
