class_name ChessPosition
extends RefCounted
## Bir satranç konumu. Sahip: A1 (feat/chess-engine).
##
## Python'daki `Position` sınıfının birebir karşılığıdır.
## Tahta: 64 elemanlı PackedStringArray, indeks = satır * 8 + sütun.
## Satır 0 = 8. yatay (siyahın arka sırası), satır 7 = 1. yatay.
## Büyük harf = beyaz ("PNBRQK"), küçük harf = siyah, "." = boş.
##
## Konumlar DEĞİŞMEZ kabul edilir: ChessRules.make_move() her zaman yeni bir
## ChessPosition döndürür, var olanı değiştirmez. Bu sayede YZ thread'ine
## verilen konum ile ana thread'deki konum güvenle paylaşılabilir.

const START_BOARD := "rnbqkbnrpppppppp................................PPPPPPPPRNBQKBNR"

## 64 kare, her biri tek karakter.
var board: PackedStringArray
## Sıradaki taraf: "w" (beyaz) veya "b" (siyah).
var turn: String
## Rok hakları: "KQkq" alt kümesi; hiç yoksa "".
var castle: String
## En passant hedef karesi; yoksa -1.
var ep: int
## 50 hamle kuralı için yarım hamle sayacı.
var half: int
## Tam hamle numarası (1'den başlar, siyah oynayınca artar).
var full: int


func _init(p_board: PackedStringArray = PackedStringArray(), p_turn: String = "w",
		p_castle: String = "KQkq", p_ep: int = -1, p_half: int = 0, p_full: int = 1) -> void:
	board = p_board if p_board.size() == 64 else PackedStringArray(START_BOARD.split("", false))
	turn = p_turn
	castle = p_castle
	ep = p_ep
	half = p_half
	full = p_full


## Başlangıç konumu.
static func initial() -> ChessPosition:
	return ChessPosition.new()


## Derin kopya (board dahil).
func copy() -> ChessPosition:
	return ChessPosition.new(board.duplicate(), turn, castle, ep, half, full)


## Tekrar tespiti için anahtar (Python: board + turn + castle + str(ep)).
func key() -> String:
	return "".join(board) + turn + castle + str(ep)
