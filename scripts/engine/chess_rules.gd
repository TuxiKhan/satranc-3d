class_name ChessRules
extends RefCounted
## Satranç kuralları (yalnızca statik fonksiyonlar). Sahip: A1 (feat/chess-engine).
##
## Python'daki modül düzeyi fonksiyonların (attacked, pseudo_moves, make, legal_moves,
## san, insufficient_material, sqname) birebir GDScript karşılığı.
##
## HAMLE TEMSİLİ (tüm ekip için ortak): Vector3i(from, to, promo)
##   from, to : 0..63 kare indeksleri
##   promo    : PROMO_NONE (0) veya PROMO_Q/R/B/N (1..4)
## Vector3i bir değer tipidir: == ile karşılaştırılır, Dictionary anahtarı olur,
## Array.has() ile aranır, thread'ler arasında kopyalanarak güvenle taşınır ve
## YZ aramasında nesne (RefCounted) üretme maliyeti yoktur.
## Hamle yoksa NO_MOVE döner.
##
## Bu dosyadaki gövdeler STUB'dır; A1 dolduracak. İmzalar sözleşmedir, değiştirilmez.

@warning_ignore_start("unused_parameter")

const FILES := "abcdefgh"

const PROMO_NONE := 0
const PROMO_Q := 1
const PROMO_R := 2
const PROMO_B := 3
const PROMO_N := 4
## promo kodu -> küçük harf taş harfi. PROMO_CHARS[PROMO_Q] == "q".
const PROMO_CHARS: PackedStringArray = ["", "q", "r", "b", "n"]

const NO_MOVE := Vector3i(-1, -1, 0)

## game_result() içindeki "reason" değerleri.
const RESULT_NONE := &""
const RESULT_CHECKMATE := &"checkmate"
const RESULT_STALEMATE := &"stalemate"
const RESULT_FIFTY_MOVE := &"fifty_move"
const RESULT_THREEFOLD := &"threefold"
const RESULT_INSUFFICIENT := &"insufficient"


## Kare adı: 0 -> "a8", 63 -> "h1".
static func sqname(sq: int) -> String:
	@warning_ignore("integer_division")
	return FILES[sq % 8] + str(8 - sq / 8)


## "q"/"r"/"b"/"n" -> PROMO_* kodu (bilinmeyen -> PROMO_NONE).
static func promo_from_char(c: String) -> int:
	var i := PROMO_CHARS.find(c.to_lower())
	return i if i > 0 else PROMO_NONE


## `sq` karesi `by_white` rengi tarafından tehdit ediliyor mu?
static func attacked(board: PackedStringArray, sq: int, by_white: bool) -> bool:
	push_error("TODO ChessRules.attacked")
	return false


## Sıradaki taraf şahta mı?
static func in_check(pos: ChessPosition) -> bool:
	push_error("TODO ChessRules.in_check")
	return false


## Sözde-yasal hamleler (şahı açıkta bırakanlar dahil). Sıra Python ile aynı olmalı.
static func pseudo_moves(pos: ChessPosition) -> Array[Vector3i]:
	push_error("TODO ChessRules.pseudo_moves")
	return []


## Yasal hamleler. Terfi hamleleri her biri için 4 ayrı hamle (q, r, b, n) olarak döner.
static func legal_moves(pos: ChessPosition) -> Array[Vector3i]:
	push_error("TODO ChessRules.legal_moves")
	return []


## Hamleyi uygular, YENİ konum döndürür (pos değişmez). Rok, en passant, terfi,
## rok hakları, ep karesi, half/full sayaçları Python `make` ile birebir.
static func make_move(pos: ChessPosition, m: Vector3i) -> ChessPosition:
	push_error("TODO ChessRules.make_move")
	return pos.copy()


## Standart cebirsel notasyon (e4, Nf3, O-O, exd5, e8=Q, Qh5+, Qh7#).
## Taş harfleri İngilizce (K Q R B N) kalır — Python ile aynı.
## `legal` = pos için legal_moves(pos) sonucu (belirsizlik giderme için).
static func san(pos: ChessPosition, m: Vector3i, legal: Array[Vector3i]) -> String:
	push_error("TODO ChessRules.san")
	return sqname(m.x) + sqname(m.y)


## Yalnızca şahlar, ya da şahlar + tek bir at/fil kaldıysa true.
static func insufficient_material(board: PackedStringArray) -> bool:
	push_error("TODO ChessRules.insufficient_material")
	return false


## Oyun sonu kontrolü (Python ChessApp.check_end ile aynı sıra):
## mat/pat -> 50 hamle (half >= 100) -> 3 tekrar (history içinde key() >= 3) -> yetersiz malzeme.
## `history` = başlangıçtan son konuma kadar tüm konumlar (son eleman = mevcut konum).
## `legal` = son konumun yasal hamleleri.
## Dönüş: { "over": bool, "reason": StringName (RESULT_*), "winner": "w" | "b" | "" }
static func game_result(history: Array[ChessPosition], legal: Array[Vector3i]) -> Dictionary:
	push_error("TODO ChessRules.game_result")
	return {"over": false, "reason": RESULT_NONE, "winner": ""}


# --- Yardımcılar (Board3D animasyonu ve ses seçimi için) -------------------------

## Hamle bir taş alıyor mu? (en passant dahil)
static func is_capture(pos: ChessPosition, m: Vector3i) -> bool:
	push_error("TODO ChessRules.is_capture")
	return false


## Rok hamlesi mi? (şah iki kare yatay gidiyor)
static func is_castle(pos: ChessPosition, m: Vector3i) -> bool:
	push_error("TODO ChessRules.is_castle")
	return false


## En passant hamlesi mi?
static func is_en_passant(pos: ChessPosition, m: Vector3i) -> bool:
	push_error("TODO ChessRules.is_en_passant")
	return false


## Alınan taşın bulunduğu kare (en passant'ta hedef kareden farklıdır); alma yoksa -1.
static func captured_square(pos: ChessPosition, m: Vector3i) -> int:
	push_error("TODO ChessRules.captured_square")
	return -1


## Rok ise kalenin (from, to) kareleri, değilse Vector2i(-1, -1).
static func castle_rook_move(pos: ChessPosition, m: Vector3i) -> Vector2i:
	push_error("TODO ChessRules.castle_rook_move")
	return Vector2i(-1, -1)
