# コンテキスト参照

必要になったときだけ以下を読むこと（常時読み込まない）。

- ターミナル環境の設定を変更する時:
  `~/.agents/my-contexts/user-terminal-setup.md`
- git commit する時:
  `~/.agents/my-contexts/git-commit-identity.md`
- ワークツリーを作る/消す時（**EnterWorktree で直接作らず `gwt` を使う**）:
  `~/.agents/my-contexts/worktree.md`
- GitHub Stacked PR を操作する時（**`gh pr create --base` だけではスタックにならない**）:
  `~/.agents/my-contexts/stacked-pr.md`

# ローカルリポジトリ

他のローカルリポジトリは ghq 管理下（`~/ghq/<host>/<user>/<repo>`）。
探すときは `ghq list -p <name>` でパスを引く（`find` で漁らない）。

# usagicollective org

`~/ghq/github.com/usagicollective/` 配下で作業するときは、先に
`~/ghq/github.com/usagicollective/orchestration/AGENTS.md` を読む。
org 共通の AI 権限・PR merge 方針・renovate の禁止事項がそこにある。

# PR を作ったとき

PR を作成したら、**回答に URL を必ず出す**。PR 番号だけでは開けないため。
既に作成済みの PR に言及するときも同様に URL を添える。
