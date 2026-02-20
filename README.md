# Quick Translate for Windows

Alfred の [Quick Translate](https://github.com/nkmr-jp/alfred-quick-translate) にインスパイアされた Windows 用翻訳ツール。

## 機能

| 機能 | 説明 |
|------|------|
| 🚀 ポップアップ翻訳 | ホットキーで起動 → テキスト入力 → リアルタイム翻訳 → Enter で貼り付け |
| 📋 選択テキスト翻訳 | テキスト選択 → ホットキー → 翻訳結果をポップアップ表示 |
| 🔄 エンジン切り替え | Google翻訳 / DeepL をTab キーで即座に切り替え |
| 🌐 自動言語判定 | 日本語 → 英語 / 英語 → 日本語 を自動判定 |
| 📝 翻訳ログ | `~/translate_log.yml` に自動保存 |
| 🖥️ システムトレイ | 常駐型アプリとして動作 |
| ⌨️ AHK連携 | AutoHotkey スクリプトから呼び出し可能 |

## セットアップ

### 1. Python パッケージのインストール

```bash
pip install -r requirements.txt
```

### 2. 起動方法を選択

#### 方法A: システムトレイ常駐（推奨）

```bash
python quick_translate.py
```

- タスクバーのシステムトレイに常駐
- グローバルホットキーが有効になる
  - `Ctrl+Shift+T` → ポップアップ起動
  - `Ctrl+Shift+Y` → 選択テキスト翻訳

#### 方法B: AutoHotkey から呼び出し

1. `quick_translate.ahk` を AutoHotkey v2 で起動
2. ホットキーで `quick_translate.py` が呼ばれる

> **Note:** 方法Aと方法Bは排他的に使ってください。両方同時に起動するとホットキーが重複します。

### 3. DeepL API の設定（任意）

```bash
# 設定ファイルを編集
notepad %USERPROFILE%\.quick-translate\config.json
```

`deepl_api_key` に DeepL API キーを設定し、`engine` を `"deepl"` に変更：

```json
{
  "engine": "deepl",
  "deepl_api_key": "your-api-key-here"
}
```

## 操作方法

### ポップアップウィンドウ

| キー | 動作 |
|------|------|
| 文字入力 | リアルタイム翻訳（400ms デバウンス） |
| `Enter` | 翻訳結果をクリップボードにコピー＆ペースト |
| `Ctrl+Enter` | 翻訳結果をクリップボードにコピーのみ |
| `Tab` | Google ↔ DeepL エンジン切り替え |
| `Esc` | 閉じる |

### CLI モード（スクリプト連携用）

```bash
# テキストを直接翻訳（結果はクリップボードにも入る）
python quick_translate.py --translate "Hello World"

# ポップアップを開く
python quick_translate.py --popup

# 選択テキストを翻訳
python quick_translate.py --selected

# エンジンを指定
python quick_translate.py --translate "こんにちは" --engine deepl
```

## 設定ファイル

`~/.quick-translate/config.json`

```json
{
  "engine": "google",
  "deepl_api_key": "",
  "source_lang": "auto",
  "target_lang_ja": "en",
  "target_lang_en": "ja",
  "popup_width": 600,
  "popup_height": 160,
  "font_size": 13,
  "opacity": 0.95,
  "log_enabled": true,
  "hotkey_popup": "ctrl+shift+t",
  "hotkey_selected": "ctrl+shift+y"
}
```

## 翻訳ログ

`~/translate_log.yml` に YAML 形式で保存されます：

```yaml
- timestamp: "2026-02-20T10:30:00"
  engine: "google"
  target: "en"
  original: "こんにちは世界"
  translated: "Hello World"
```

## Windows スタートアップへの登録

常駐起動したい場合：

1. `Win+R` → `shell:startup` でスタートアップフォルダを開く
2. 以下の内容でショートカットまたは `.bat` ファイルを作成：

```bat
@echo off
start /min pythonw quick_translate.py
```

## トラブルシューティング

- **ホットキーが効かない**: 管理者権限で実行してみてください（`keyboard` ライブラリの制限）
- **DeepL エラー**: API キーが正しいか、Free/Pro のエンドポイントが一致しているか確認
- **ペースト（Enter）が動かない**: `pyautogui` がインストールされているか確認。なければクリップボードにコピーのみ動作
