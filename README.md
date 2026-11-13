# Satranç 3D

Godot 4.7 ile yapılmış 3D satranç oyunu. Yapay zekaya karşı (Kolay / Orta / Zor)
veya aynı bilgisayarda iki kişi oynanabilir. Kurallar ve yapay zeka, Python/tkinter
ile yazılmış özgün `satranc.py` oyunundan birebir aktarılmıştır.

> Durum: iskelet aşaması. Motor, 3D tahta ve arayüz ayrı dallarda geliştiriliyor.
> Ekip içi arayüz sözleşmesi: [`docs/CONTRACT.md`](docs/CONTRACT.md).

## Çalıştırma

1. [Godot 4.7](https://godotengine.org/) (standart sürüm, .NET gerekmez) indirin.
2. Godot'u açın, **İçe Aktar** ile bu klasördeki `project.godot` dosyasını seçin.
3. **F5** (Projeyi Çalıştır). Açılış sahnesi: `scenes/ui/main_menu.tscn`.

Renderer: GL Compatibility. Fizik: Jolt.

## Kontroller

| Eylem | Tuş |
|---|---|
| Taş seç / hamle yap | Sol tık |
| Kamerayı tahta etrafında döndür | Sağ tık basılı tut + sürükle |
| Yakınlaştır / uzaklaştır | Fare tekerleği |
| Duraklatma menüsü | Esc |

## Klasör yapısı

```
assets/models/pieces/  3D taş modelleri (.glb)
assets/audio/sfx/      ses efektleri (.ogg)
scenes/                oyun, tahta ve arayüz sahneleri
scripts/engine/        satranç kuralları ve yapay zeka
scripts/board/         3D tahta, kamera, animasyonlar
scripts/ui/            menüler ve HUD
scripts/autoload/      GameConfig, Settings, AudioManager
scripts/game/          oyun akışı (GameController)
docs/CONTRACT.md       ekip arayüz sözleşmesi
```

## Krediler ve lisanslar

Kullanılan tüm harici varlıklar **CC0 1.0 (Kamu Malı)** lisanslıdır
(https://creativecommons.org/publicdomain/zero/1.0/). Atıf zorunlu değildir;
yine de kaynaklarını teşekkürle belirtiyoruz.

### 3D modeller
- **"3d chess pieces"** — tunakron, CC0 — https://opengameart.org/node/157258
  `assets/models/pieces/{pawn,knight,bishop,rook,queen,king}.glb` (paketteki glTF
  dışa aktarımları, değiştirilmeden).

### Ses efektleri — Kenney (www.kenney.nl), CC0
| Dosya | Kaynak paket | Özgün dosya |
|---|---|---|
| `assets/audio/sfx/move.ogg` | Casino Audio | `chip-lay-1.ogg` |
| `assets/audio/sfx/capture.ogg` | Casino Audio | `chips-collide-1.ogg` |
| `assets/audio/sfx/castle.ogg` | Casino Audio | `chips-stack-3.ogg` |
| `assets/audio/sfx/check.ogg` | Interface Sounds | `glass_001.ogg` |
| `assets/audio/sfx/promote.ogg` | Interface Sounds | `confirmation_002.ogg` |
| `assets/audio/sfx/ui_click.ogg` | Interface Sounds | `click_001.ogg` |
| `assets/audio/sfx/piece_lift.ogg` | Interface Sounds | `select_001.ogg` |
| `assets/audio/sfx/illegal.ogg` | Interface Sounds | `error_004.ogg` |
| `assets/audio/sfx/game_over.ogg` | Music Jingles (Short jingles) | `jingles_STEEL00.ogg` |

Paket sayfaları:
- Casino Audio — https://kenney.nl/assets/casino-audio
  (indirilen kopya: https://opengameart.org/content/54-casino-sound-effects-cards-dice-chips)
- Interface Sounds — https://kenney.nl/assets/interface-sounds
  (indirilen kopya: https://opengameart.org/content/interface-sounds)
- Music Jingles — https://kenney.nl/assets/music-jingles
  (indirilen kopya: https://opengameart.org/node/22000)

### Motor
- [Godot Engine](https://godotengine.org/) — MIT lisansı.
