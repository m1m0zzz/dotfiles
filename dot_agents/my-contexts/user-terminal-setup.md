# ターミナル環境

Windows Terminal → WSL2 (Ubuntu) → [herdr](https://github.com/herdrdev/herdr) という構成。
herdr は AI エージェント向けのターミナルランタイム（tmux 相当）。prefix は `ctrl+b`。

- herdr の設定: `~/.config/herdr/config.toml` / リロードは `herdr server reload-config`
- Windows Terminal の設定:
  `/mnt/c/Users/{{ .winuser }}/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json`

## キー入力の扱い

Claude Code の `/terminal-setup` はこの構成からは実行できない（WSL 判定で弾かれる）。

Shift+Enter で改行できない問題は 2026-08-11 に解決済み。Windows Terminal の
`settings.json` に `sendInput` アクション（`[13;2u` = kitty keyboard protocol の
Shift+Enter）を追加し、`shift+enter` にバインドした。

従来のエンコーディングでは Enter と Shift+Enter が区別できず、herdr は外側のターミナルが
「修飾付き Enter」として報告した場合しか転送できないため、herdr の config.toml 側では
解決できない。同種のキー入力問題（特定のキーがエージェントに届かない）は herdr ではなく
Windows Terminal の `sendInput` 側で対処すること。設定を編集したら `cat -v` で実際に
届くバイト列を確認する。
