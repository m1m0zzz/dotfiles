# dotfiles

chezmoi のソースディレクトリ。ホームの実ファイル（`~/.bashrc` など）ではなく、
**ここを編集して `chezmoi apply` で反映する**。

## ファイル名の規約

| 接頭辞 | 適用先 |
| --- | --- |
| `dot_foo` | `~/.foo` |
| `executable_foo` | `~/foo`（実行権限付き） |
| `private_foo` | `~/foo`（0600） |
| `foo.tmpl` | `~/foo`（Go テンプレートとして展開） |

ディレクトリ階層はそのまま対応（例: `dot_claude/settings.json` → `~/.claude/settings.json`）。

## 注意

- ここに置いたファイルは**すべて** `~/` 配下に配置される。配置したくないものは
  `.chezmoiignore` に**適用後のパス**で追記する（`README.md`, `CLAUDE.md` は追加済み）。
- `dot_claude/CLAUDE.md` は `~/.claude/CLAUDE.md`（全プロジェクト共通の個人設定）の実体。
  このファイルとは別物なので混同しない。
- 秘密鍵・認証情報は管理対象外（`.chezmoiignore` 参照）。
- マシン固有の値（Windows のユーザー名など）は直書きせず `.chezmoi.toml.tmpl` の
  `promptStringOnce` で受け取り、テンプレート側から `{{ .winuser }}` のように参照する。
  実値は `~/.config/chezmoi/chezmoi.toml` に入りリポジトリには残らない。
- `.tmpl` にしたファイルは全体が Go テンプレートとして評価される。`{{` を含む
  シェルスクリプトを追加するときは `{{ "{{" }}` でエスケープする。
