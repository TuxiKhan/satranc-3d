class_name Board3D
extends Node3D
## 3D tahta, taşlar, kamera, tıklama (raycast), animasyonlar ve vurgular.
## Sahip: A2 (feat/board-3d). Sahne: res://scenes/board/board_3d.tscn
##
## Board3D OYUN KURALI BİLMEZ ve ses ÇALMAZ: yalnızca kendisine söyleneni gösterir,
## tıklanan kareyi bildirir. Seçim/hamle mantığı GameController'dadır (A4).
## Kamera, ışıklar ve WorldEnvironment bu sahnenin içindedir.
##
## KOORDİNAT SÖZLEŞMESİ (bkz. docs/CONTRACT.md):
##   sq = satır*8 + sütun; sütun 0 = a, satır 0 = 8. yatay.
##   Dünya konumu: x = (sütun - 3.5) * SQUARE_SIZE, z = (satır - 3.5) * SQUARE_SIZE, y = 0 tahta yüzeyi.
##   => Beyaz taraf +Z, siyah taraf -Z; beyazdan bakınca a sütunu solda (-X).

@warning_ignore_start("unused_parameter")
@warning_ignore_start("unused_signal")

## Bir kareye sol tıklandı (select action). Tahta dışına tıklanırsa sq = -1.
## set_input_enabled(false) iken veya animasyon sürerken YAYILMAZ.
signal square_clicked(sq: int)
## animate_move() ile başlatılan animasyon (rok kalesi, alınan taş, terfi dahil) bitti.
signal move_animation_finished

## Bir karenin dünya birimindeki kenar uzunluğu.
const SQUARE_SIZE := 1.0
## Taş modelleri metre ölçeğinde (taban çapı 0.045). SQUARE_SIZE=1.0 için önerilen ölçek.
const PIECE_SCALE := 16.0


## Tahtayı anında (animasyonsuz) verilen diziye eşitler. Yeni oyun ve Geri Al'da kullanılır.
## board: ChessPosition.board ile aynı biçim (64 karakter).
func set_board(board: PackedStringArray) -> void:
	push_error("TODO Board3D.set_board")


## Hamleyi canlandırır: taş havaya kalkar, yay çizerek gider, yerine konur.
## Alınan taş (en passant'ta hedef kareden farklı karedeki piyon) animasyonla kaldırılır.
## Rokta kale de taşınır. Terfide piyon, inişten sonra seçilen taşa dönüşür.
## pos_before: hamleden ÖNCEKİ konum. Bitince move_animation_finished yayılır ve
## Board3D'nin iç durumu hamle SONRASI tahtayla aynıdır (ayrıca set_board gerekmez).
## Animasyon sırasında gelen ikinci animate_move çağrısı: önce mevcut animasyon
## anında tamamlanır (bitiş sinyali yayılır), sonra yenisi başlar.
func animate_move(move: Vector3i, pos_before: ChessPosition) -> void:
	push_error("TODO Board3D.animate_move")
	move_animation_finished.emit.call_deferred()


## Animasyon sürüyor mu?
func is_animating() -> bool:
	return false


## Seçili kareyi vurgular (ve taşı hafifçe kaldırabilir). -1 = seçimi kaldır.
func set_selected(sq: int) -> void:
	push_error("TODO Board3D.set_selected")


## Gidilebilecek kareleri gösterir. captures: bunların içinden alma olanlar
## (farklı işaretlenir). İkisi de boş -> hedefleri temizle.
func show_targets(squares: PackedInt32Array, captures: PackedInt32Array) -> void:
	push_error("TODO Board3D.show_targets")


## Son hamlenin iki karesini vurgular. from = -1 -> temizle.
func set_last_move(from: int, to: int) -> void:
	push_error("TODO Board3D.set_last_move")


## Şah çekilen şahın karesini kırmızı vurgular. -1 = temizle.
func set_check(sq: int) -> void:
	push_error("TODO Board3D.set_check")


## Kamerayı bir oyuncunun tarafına çevirir. color: "w" veya "b".
## animated = true ise yumuşak döner. Kullanıcının zoom seviyesi korunur.
func face_side(color: String, animated: bool) -> void:
	push_error("TODO Board3D.face_side")


## Tıklama girişini açar/kapatır (YZ düşünürken, menü açıkken kapalı).
## Kamera orbit/zoom bundan ETKİLENMEZ, her zaman çalışır (duraklatma hariç).
func set_input_enabled(enabled: bool) -> void:
	push_error("TODO Board3D.set_input_enabled")
