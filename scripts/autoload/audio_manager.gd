extends Node
## Autoload "AudioManager". Sahip: A3 (feat/ui-audio).
## Olay adına göre ses çalar. Çağıranlar dosya yolu bilmez, yalnızca olay adı kullanır.
## Aynı anda birden fazla ses çakışabilmeli (havuz / polyphony).
##
## Olay -> dosya eşlemesi (res://assets/audio/sfx/):
##   &"move"       -> move.ogg        taş yerine kondu (alma yok)        [SFX bus]
##   &"capture"    -> capture.ogg     taş alındı                          [SFX bus]
##   &"castle"     -> castle.ogg      rok                                 [SFX bus]
##   &"check"      -> check.ogg       şah çekildi                         [SFX bus]
##   &"promote"    -> promote.ogg     terfi                               [SFX bus]
##   &"game_over"  -> game_over.ogg   oyun bitti                          [SFX bus]
##   &"piece_lift" -> piece_lift.ogg  (opsiyonel) taş seçildi/kaldırıldı  [SFX bus]
##   &"illegal"    -> illegal.ogg     (opsiyonel) geçersiz tıklama        [UI bus]
##   &"ui_click"   -> ui_click.ogg    buton tıklaması                     [UI bus]

@warning_ignore_start("unused_parameter")

const EVENTS := {
	&"move": "res://assets/audio/sfx/move.ogg",
	&"capture": "res://assets/audio/sfx/capture.ogg",
	&"castle": "res://assets/audio/sfx/castle.ogg",
	&"check": "res://assets/audio/sfx/check.ogg",
	&"promote": "res://assets/audio/sfx/promote.ogg",
	&"game_over": "res://assets/audio/sfx/game_over.ogg",
	&"piece_lift": "res://assets/audio/sfx/piece_lift.ogg",
	&"illegal": "res://assets/audio/sfx/illegal.ogg",
	&"ui_click": "res://assets/audio/sfx/ui_click.ogg",
}


## Olayın sesini çalar. Bilinmeyen olay -> push_warning, çökme yok.
func play(event_name: StringName) -> void:
	push_error("TODO AudioManager.play")
