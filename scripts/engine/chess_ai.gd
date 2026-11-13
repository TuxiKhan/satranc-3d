class_name ChessAI
extends RefCounted
## Yapay zeka. Sahip: A1 (feat/chess-engine).
##
## Python'daki evaluate / Searcher (negamax + alfa-beta + quiesce) / choose_move
## algoritmasının BİREBİR aynısı (aynı PST'ler, aynı seviye parametreleri:
## Kolay = 1 ply + %25 rastgele + 100cp pencere; Orta = derinlik (1,2), 10 sn;
## Zor = derinlik (1..5), 8 sn, d>=3 iken süre*0.12 aşılırsa dur).
##
## THREAD GÜVENLİĞİ: choose_move() bir Thread içinde çağrılır (A4 başlatır).
## Bu yüzden: sahne ağacına, autoload'lara, Engine/Input'a ERİŞMEZ; paylaşılan
## değiştirilebilir statik durum kullanmaz; rastgelelik için örneğe ait
## RandomNumberGenerator kullanır. Her arama için yeni bir ChessAI örneği oluşturulabilir.

@warning_ignore_start("unused_parameter")

enum Level { EASY = 0, MEDIUM = 1, HARD = 2 }

## Arayüzde gösterilecek seviye adları (indeks = Level).
const LEVEL_NAMES: PackedStringArray = ["Kolay", "Orta", "Zor"]


## Ana thread'den aramayı durdurmak için paylaşılan bayrak.
## Ana thread `stopped = true` yapar; arama ~512 düğümde bir kontrol eder ve en iyi
## sonucu (veya rastgele yasal hamleyi) döndürür.
class StopToken:
	extends RefCounted
	var stopped: bool = false


var rng := RandomNumberGenerator.new()


func _init() -> void:
	rng.randomize()


## Sıradaki taraf için hamle seçer. Yasal hamle yoksa ChessRules.NO_MOVE döner.
## `level`: Level enum değeri. `stop`: null olabilir.
func choose_move(pos: ChessPosition, level: int, stop: StopToken) -> Vector3i:
	push_error("TODO ChessAI.choose_move")
	return ChessRules.NO_MOVE


## Statik değerlendirme, sıradaki taraf açısından santipiyon (Python evaluate).
static func evaluate(pos: ChessPosition) -> int:
	push_error("TODO ChessAI.evaluate")
	return 0
