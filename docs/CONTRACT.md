# Arayüz Sözleşmesi (CONTRACT)

Bu belge A1/A2/A3 agent'larının **ayrı worktree'lerde paralel** çalışıp birbirini
beklemeden, merge çakışması yaşamadan birleşebilmesi için ortak kuralları tanımlar.
A0 (feat/setup) tarafından yazıldı. Değişiklik gerekiyorsa: kendi PR açıklamanda
"SÖZLEŞME DEĞİŞİKLİĞİ İSTEĞİ" başlığıyla yaz; dosyayı kendin değiştirme (A4 uygular).

Referans oyun: `C:\A\test claude\satranc.py` (Python/tkinter). Kural ve YZ davranışı
onunla **birebir** aynı olmalıdır.

---

## 1. Dosya sahipliği

Bir dosyayı yalnızca sahibi değiştirir. Sahibi olmadığın bir dosyada hata/eksik
görürsen PR açıklamana not düş. Stub dosyalarındaki **imzalar, sinyaller, sabitler
sözleşmedir**: gövdeleri doldur, yeni (özel/yardımcı) fonksiyon ekleyebilirsin,
ama mevcut imzaları değiştirme/silme.

| Yol | Sahip | Not |
|---|---|---|
| `project.godot` | **A0, A4** | Başka kimse değiştirmez. Ayar/autoload/input gerekiyorsa PR'da iste. |
| `docs/CONTRACT.md`, `README.md` | A0, A4 | |
| `assets/models/pieces/*.glb` (+ `.import`) | A0 | Salt okunur. A2 import ayarlarını değiştirmesin; ölçek/malzemeyi kodda versin. |
| `assets/audio/sfx/*` | A0 | Salt okunur (A3 yalnızca **yeni** dosya ekleyebilir, kredisini PR'a yazar). |
| `scripts/engine/**`, `tests/engine/**` | **A1** | `chess_position.gd`, `chess_rules.gd`, `chess_ai.gd` + istediği yardımcılar. |
| `scripts/board/**`, `scenes/board/**`, `assets/materials/**`, `assets/shaders/**` | **A2** | Board3D, kamera, ışık, ortam, vurgu, animasyon. |
| `scripts/autoload/**` | **A3** | GameConfig, Settings, AudioManager. |
| `scripts/ui/**`, `scenes/ui/**`, `assets/ui/**` (tema, font), `default_bus_layout.tres` | **A3** | Menüler, HUD, ayarlar, ses bus'ları. |
| `scripts/game/**`, `scenes/game.tscn` | **A4** | GameController, oyun akışı, entegrasyon. |

Bağımlılık yönü: `engine` hiçbir şeye bağlı değildir. `board` yalnızca `ChessPosition`
tipini ve (isterse) `ChessRules` yardımcılarını kullanır. `ui` motoru bilmez.
`game` hepsini birleştirir. A1 stub'ları doldurulmadan önce A2/A3 kendi sahnelerini
**test sahnesiyle** (kendi klasörlerinde, ör. `scenes/board/board_test.tscn`) deneyebilir.

## 2. Klasör yapısı

```
assets/
  models/pieces/   pawn.glb knight.glb bishop.glb rook.glb queen.glb king.glb   (A0)
  audio/sfx/       move capture castle check promote game_over ui_click piece_lift illegal (.ogg)  (A0)
docs/CONTRACT.md
scenes/
  game.tscn                (A4)  Game(Node) > Board3D, HUD, PauseMenu
  board/board_3d.tscn      (A2)
  ui/main_menu.tscn        (A3)  ← projenin ana sahnesi
  ui/settings_menu.tscn    (A3)
  ui/pause_menu.tscn       (A3)
  ui/hud.tscn              (A3)
scripts/
  engine/  chess_position.gd chess_rules.gd chess_ai.gd   (A1)
  autoload/ game_config.gd settings.gd audio_manager.gd   (A3)
  board/   board_3d.gd                                     (A2)
  ui/      main_menu.gd settings_menu.gd pause_menu.gd hud.gd (A3)
  game/    game_controller.gd                              (A4)
```

`scenes/game.tscn` içindeki düğüm adları sabittir: `Board3D`, `HUD`, `PauseMenu`.
Bu sahneler kök düğümleriyle örneklenir; A2/A3 kendi sahnelerinin içini serbestçe
düzenler ama kök düğüm tipini/adını değiştirmez (Board3D: Node3D, HUD: CanvasLayer,
PauseMenu: CanvasLayer, SettingsMenu: Control, MainMenu: Control).

## 3. Veri temsili

### 3.1 Tahta ve konum — `ChessPosition` (A1)
- `board: PackedStringArray` (64 eleman, her biri tek karakter). İndeks `sq = satır*8 + sütun`.
  Satır 0 = 8. yatay (siyahın arka sırası), satır 7 = 1. yatay; sütun 0 = a.
  Büyük harf beyaz (`PNBRQK`), küçük harf siyah, `"."` boş. `a8 = 0`, `h1 = 63`, `e1 = 60`.
- `turn: String` `"w"`/`"b"`, `castle: String` (`"KQkq"` alt kümesi), `ep: int` (yoksa **-1**),
  `half: int`, `full: int`, `key() -> String`, `copy()`, `static initial()`.
- Konumlar **değişmez** kabul edilir; `make_move` yeni nesne döndürür.

### 3.2 Hamle — `Vector3i(from, to, promo)` (tüm ekip)
- `x = from` (0..63), `y = to` (0..63), `z = promo`:
  `ChessRules.PROMO_NONE=0, PROMO_Q=1, PROMO_R=2, PROMO_B=3, PROMO_N=4`.
  Harf dönüşümü: `ChessRules.PROMO_CHARS[z]` ("q"/"r"/"b"/"n"), `ChessRules.promo_from_char("q")`.
- Hamle yok: `ChessRules.NO_MOVE = Vector3i(-1, -1, 0)`.
- **Gerekçe:** Vector3i bir değer tipidir — `==` ile karşılaştırılır, `Array.has()`
  ve Dictionary anahtarı olarak çalışır, thread'ler arasında kopyalanarak güvenle
  geçer ve YZ aramasında (saniyede on binlerce hamle) nesne/obje tahsisi ve
  referans sayımı maliyeti yoktur. `ChessMove` (RefCounted) sınıfı `==` ile içerik
  karşılaştırması yapmaz ve GDScript'te belirgin şekilde yavaştır; Dictionary ise
  hem yavaş hem tip güvencesizdir. Python'daki `(from, to, promo)` demetine en yakın yapıdır.
- Hamle listeleri: `Array[Vector3i]`.

### 3.3 Renk
Her yerde `"w"` / `"b"` string'i. (GameConfig'in menü seçimi ayrı bir enum'dur.)

## 4. Modül API'leri

Ayrıntılı imzalar ve açıklamalar ilgili stub dosyalarındaki doc yorumlarındadır;
burada özet ve etkileşim kuralları var.

### 4.1 Motor (A1) — `scripts/engine/`
- `ChessRules` (yalnızca `static`): `sqname`, `promo_from_char`, `attacked`, `in_check`,
  `pseudo_moves`, `legal_moves`, `make_move`, `san`, `insufficient_material`,
  `game_result(history, legal) -> {over, reason, winner}`, yardımcılar
  `is_capture`, `is_castle`, `is_en_passant`, `captured_square`, `castle_rook_move`.
- `game_result` `reason` değerleri: `RESULT_CHECKMATE`, `RESULT_STALEMATE`,
  `RESULT_FIFTY_MOVE`, `RESULT_THREEFOLD`, `RESULT_INSUFFICIENT` (kontrol sırası Python
  `check_end` ile aynı). Türkçe metne çevirmek A4'ün işidir (bkz. §6).
- `ChessAI.new().choose_move(pos, level, stop: ChessAI.StopToken) -> Vector3i`.
  `level`: `ChessAI.Level.EASY/MEDIUM/HARD` (0/1/2), adlar `ChessAI.LEVEL_NAMES`.
  Bir `Thread` içinde çalışır; sahne ağacına/autoload'lara dokunmaz.
  Python'daki seviye parametreleri birebir (Kolay: %25 rastgele + 1 ply 100cp pencere;
  Orta: derinlik 1–2, 10 sn; Zor: derinlik 1–5, 8 sn).
- SAN taş harfleri İngilizce kalır (K, Q, R, B, N) — Python ile aynı.

### 4.2 Board3D (A2) — `scenes/board/board_3d.tscn`, `class_name Board3D`
- Sinyaller: `square_clicked(sq: int)` (tahta dışı = -1), `move_animation_finished`.
- Metodlar: `set_board(board)`, `animate_move(move, pos_before)`, `is_animating()`,
  `set_selected(sq)`, `show_targets(squares, captures)`, `set_last_move(from, to)`,
  `set_check(sq)`, `face_side(color, animated)`, `set_input_enabled(enabled)`.
- Board3D kural bilmez, **ses çalmaz**, seçim mantığı yapmaz; kamera/ışık/ortam onun içindedir.
- Giriş: `select` action'ı ile kare seçimi (raycast). `camera_orbit` basılıyken fare
  hareketi ile tahta merkezi etrafında orbit; `zoom_in`/`zoom_out` ile zoom.
  Girişi `_unhandled_input` içinde işler (GUI üstündeki tıklamalar tahtaya geçmez).
- Duraklatıldığında (`get_tree().paused`) Board3D tamamen durur (process_mode varsayılan).
- Animasyon: kaldır → yay çizerek taşı → yerine koy; alınan taş animasyonla kaldırılır;
  rokta kale de taşınır; terfide piyon taş değiştirir. Süreler A2'nin seçimi
  (öneri: toplam ≤ 0.6 sn).

### 4.3 Arayüz (A3)
- **HUD** (`class_name HUD`, CanvasLayer): sinyaller `undo_pressed`,
  `promotion_chosen(piece: String)`, `promotion_cancelled`, `new_game_pressed`,
  `main_menu_pressed`; metodlar `set_status(text)`, `set_moves(sans)`,
  `set_undo_enabled(enabled)`, `ask_promotion(color)`, `show_game_over(text)`, `hide_dialogs()`.
- **PauseMenu** (`class_name PauseMenu`, CanvasLayer, process_mode ALWAYS): `pause`
  action'ını kendisi dinler, `get_tree().paused`'ı kendisi yönetir. Sinyaller `opened`,
  `closed`, `new_game_pressed`, `main_menu_pressed`. Metodlar `open()`, `close()`, `is_open()`.
  "Ayarlar" kendi içindeki SettingsMenu örneğini açar.
- **SettingsMenu** (`class_name SettingsMenu`, Control, process_mode ALWAYS): `closed` sinyali, `open()`.
- **MainMenu** (Control): GameConfig'i doldurur, `GameConfig.start_game()` çağırır; Çıkış → `get_tree().quit()`.
- Buton tık sesi (`ui_click`) A3'ün kendi sahnelerinde çalınır.

### 4.4 Autoload'lar (A3) — `project.godot`'a A0 tarafından kayıtlı
| Ad | Script | Görev |
|---|---|---|
| `Settings` | `scripts/autoload/settings.gd` | Kalıcı tercihler (`user://settings.cfg`), `changed(key)` sinyali, `get_value/set_value`. Anahtarlar: `master_volume`, `sfx_volume`, `ui_volume` (0..1), `fullscreen`, `vsync`, `msaa` (0/2/4/8), `shadows`. |
| `AudioManager` | `scripts/autoload/audio_manager.gd` | `play(event_name: StringName)`. Olaylar: `move, capture, castle, check, promote, game_over, ui_click, piece_lift, illegal`. |
| `GameConfig` | `scripts/autoload/game_config.gd` | `mode` (VS_AI/TWO_PLAYER), `color_choice`, çözülmüş `player_color` ("w"/"b"), `ai_level` (0..2), `resolve_color()`, `start_game()`, `go_to_main_menu()`. |

Sıra: `Settings`, `AudioManager`, `GameConfig` (MCPRuntimeServer'dan sonra). Settings
`_ready`'de yüklenip uygulanır; AudioManager Settings'e bağımlı olabilir, tersi değil.
Ses bus'ları: `Master`, `SFX`, `UI` (A3, `default_bus_layout.tres`).

### 4.5 GameController (A4) — `scenes/game.tscn`
Python `ChessApp`'in karşılığı. Bkz. `scripts/game/game_controller.gd` başlığı.

## 5. Input action'ları (project.godot, A0 tanımladı)

| Action | Bağlama | Kullanan |
|---|---|---|
| `select` | Sol fare tuşu | Board3D (kare seçimi) |
| `camera_orbit` | Sağ fare tuşu (basılı tut + sürükle) | Board3D |
| `zoom_in` | Fare tekerleği yukarı | Board3D |
| `zoom_out` | Fare tekerleği aşağı | Board3D |
| `pause` | Esc | PauseMenu (ve açık iletişim kutularını kapatma) |

Not: Godot 4.7'de bu olaylar `device = DEVICE_ID_MOUSE (32)` / `DEVICE_ID_KEYBOARD (16)`
ile kaydedilir; gerçek fare/klavye olaylarıyla eşleştiği doğrulandı.

## 6. Ses ve metin kuralları (A4 uygular)

- Bir hamle bittiğinde (`move_animation_finished`) **tek** ses çalınır, öncelik:
  `game_over` > `check` > `promote` > `castle` > `capture` > `move`.
  *(Geçici varsayılan — ürün sahibinin onayı bekleniyor, bkz. PR "Açık sorular".)*
  `piece_lift` (taş seçilince) ve `illegal` (geçersiz tıklama) isteğe bağlıdır; kullanılıp
  kullanılmayacağı da onay bekliyor.
- Durum metinleri (Python ile aynı):
  - YZ modu: `"Sıra sende (Beyaz)"`, şahta ise `"Şah! Sıra sende (Beyaz)"`,
    YZ düşünürken `"Yapay zeka düşünüyor... (Orta)"`.
  - Oyun sonu: `"Şah mat! Beyaz kazandı."`, `"Pat! Oyun berabere."`,
    `"50 hamle kuralı: berabere."`, `"Üç kez tekrar: berabere."`, `"Yetersiz malzeme: berabere."`.
- Arayüz dili yalnızca Türkçe.

## 7. 3D taş modelleri (A2 için)

Kaynak: tunakron, "3d chess pieces", CC0 — https://opengameart.org/node/157258
Her taş tipi **ayrı .glb** dosyasıdır (6 dosya, renk başına ayrı model YOK).
Her dosyada tek düğüm + tek mesh + tek yüzey; doku (texture) yok, gömülü malzeme
düz beyaz `StandardMaterial3D`. **Beyaz/siyah renkler kodla verilmelidir**
(`material_override` veya `surface_override_material`). **Tahta modeli yok** — A2 tahtayı kodla/primitive ile üretir.

Ölçüm (Godot'ta import edilmiş hâliyle, ölçek 1.0, metre):

| Dosya | Genişlik X × Z | Yükseklik Y | Not |
|---|---|---|---|
| `pawn.glb` | 0.045 × 0.045 | 0.050 | |
| `rook.glb` | 0.045 × 0.045 | 0.055 | |
| `knight.glb` | 0.045 × 0.045 | 0.060 | Yön önemli, aşağıya bak |
| `bishop.glb` | 0.058 × 0.058 (AABB, 21° Y dönük) | 0.070 | Gerçek taban çapı 0.045 |
| `queen.glb` | 0.045 × 0.045 | 0.085 | |
| `king.glb` | 0.045 × 0.045 | 0.095 | X'te ~2 mm kaymış (ihmal edilebilir) |

- **Orijin:** tabanın merkezi, taban y ≈ 0 (≈0.0005). Doğrudan kare merkezine `y=0` ile konabilir.
- **Ölçek:** taban çapı 0.045. `SQUARE_SIZE = 1.0` ile taban çapı kare boyunun ~%72'si
  olsun diye **ölçek faktörü 16** önerilir (taban 0.72, şah 1.52 birim). Farklı kare boyu
  için: `ölçek = 16 * SQUARE_SIZE`. (Gerçek tahta oranı: kare ≈ 1.25–1.3 × taban çapı.)
- **İleri yön:** At'ın başı (burnu) **+Z** yönüne bakar. Board3D koordinatlarında beyaz
  taraf +Z, siyah taraf -Z olduğundan: **beyaz atlar Y ekseninde 180° döndürülür**
  (-Z'ye, rakibe baksın), siyah atlar 0° kalır. Diğer taşlar dönel simetrik (fil
  yarığı ve şah haçı görseldir; şah haçı XY düzleminde, +Z'den bakınca düz görünür).

## 8. Koordinat sistemi (Board3D)

- Kare merkezi: `x = (sütun - 3.5) * SQUARE_SIZE`, `z = (satır - 3.5) * SQUARE_SIZE`, `y = 0` tahta üst yüzeyi.
- Beyaz taraf (+Z), siyah taraf (-Z). Beyazın kamerası +Z'de, -Z'ye bakar; a sütunu solda.
- Tahta merkezi dünya orijinindedir; kamera orbit merkezi `(0, 0, 0)`.

## 9. Doğrulama kuralı (herkes)

PR açmadan önce: MCP `lsp_project_diagnostics` hatasız; ana sahne ve `scenes/game.tscn`
çalıştırıldığında `debugger_get_log`'da hata yok. Kendi test sahnelerini kendi klasöründe tut.
`addons/godot_mcp_toolkit/`, `.mcp.json`, `.claude/`, `.godot/` asla commitlenmez.
