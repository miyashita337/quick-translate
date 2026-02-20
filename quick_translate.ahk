; =============================================================================
; Quick Translate - AutoHotkey v2 Integration
; =============================================================================
; Usage:
;   Ctrl+Shift+T  → 翻訳ポップアップを開く
;   Ctrl+Shift+Y  → 選択テキストを翻訳ポップアップに送る
;
; Prerequisites:
;   - Python 3.10+ がパスに通っていること
;   - pip install deep-translator pyautogui keyboard pystray Pillow
;   - quick_translate.py が同じフォルダにあること
;
; Note: AutoHotkey v2 syntax です。v1 の場合は書き換えが必要です。
; =============================================================================

#Requires AutoHotkey v2.0
#SingleInstance Force

; --- Configuration ---
SCRIPT_DIR := A_ScriptDir
PYTHON_EXE := "python"  ; or full path like "C:\Python312\python.exe"
TRANSLATE_SCRIPT := SCRIPT_DIR "\quick_translate.py"

; --- Ctrl+Shift+T: Open translation popup ---
^+t:: {
    Run(PYTHON_EXE ' "' TRANSLATE_SCRIPT '" --popup', , "Hide")
}

; --- Ctrl+Shift+Y: Translate selected text ---
^+y:: {
    ; Python側で選択テキストのコピー＆ポップアップ表示を一括処理
    Run(PYTHON_EXE ' "' TRANSLATE_SCRIPT '" --selected', , "Hide")
}

; --- Alternative: Ctrl+Shift+Y with direct translate (no popup) ---
; Uncomment below if you prefer instant translation without popup
;
; ^+y:: {
;     ClipSaved := ClipboardAll()
;     A_Clipboard := ""
;     Send("^c")
;     if !ClipWait(1) {
;         A_Clipboard := ClipSaved
;         return
;     }
;     SelectedText := A_Clipboard
;     SafeText := StrReplace(SelectedText, '"', '\"')
;     RunWait(PYTHON_EXE ' "' TRANSLATE_SCRIPT '" --translate "' SafeText '"', , "Hide")
;     ; Result is now in clipboard, paste it
;     Sleep(100)
;     Send("^v")
; }
