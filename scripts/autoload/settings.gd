extends Node
## Autoload "Settings". Sahip: A3 (feat/ui-audio).
## Kullanıcı tercihleri; user://settings.cfg dosyasına kaydedilir (ConfigFile).
## Değer değiştiren her kod set_value() kullanır; o da uygular, kaydeder ve
## `changed(key)` yayar. Ses seviyeleri AudioServer bus'larına (Master, SFX, UI)
## Settings tarafından uygulanır; pencere/viewport ayarları (tam ekran, vsync, msaa)
## da Settings tarafından uygulanır. Sahneye özgü grafik ayarlarını (ör. gölgeler)
## ilgili sahne `changed` sinyalini dinleyerek kendisi uygular (Board3D -> A2).

@warning_ignore_start("unused_parameter")
@warning_ignore_start("unused_signal")

signal changed(key: StringName)

const PATH := "user://settings.cfg"

# --- Anahtarlar (StringName) ve varsayılanlar --------------------------------
## Ses: lineer 0.0..1.0
const MASTER_VOLUME := &"master_volume"
const SFX_VOLUME := &"sfx_volume"
const UI_VOLUME := &"ui_volume"
## Grafik
const FULLSCREEN := &"fullscreen"      # bool
const VSYNC := &"vsync"                # bool
const MSAA := &"msaa"                  # int: 0 kapalı, 2, 4, 8 (Viewport.MSAA_* ile eşlenir)
const SHADOWS := &"shadows"            # bool (Board3D uygular)

const DEFAULTS := {
	MASTER_VOLUME: 0.8,
	SFX_VOLUME: 1.0,
	UI_VOLUME: 1.0,
	FULLSCREEN: false,
	VSYNC: true,
	MSAA: 2,
	SHADOWS: true,
}


func get_value(key: StringName) -> Variant:
	push_error("TODO Settings.get_value")
	return DEFAULTS.get(key)


## Değeri ayarlar, uygular, kaydeder, `changed(key)` yayar.
func set_value(key: StringName, value: Variant) -> void:
	push_error("TODO Settings.set_value")


func load_settings() -> void:
	push_error("TODO Settings.load_settings")


func save_settings() -> void:
	push_error("TODO Settings.save_settings")


## Tüm değerleri motor/sunuculara uygular (açılışta load_settings sonrası).
func apply_all() -> void:
	push_error("TODO Settings.apply_all")
