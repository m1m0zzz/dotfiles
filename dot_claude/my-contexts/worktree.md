# ワークツリー

ワークツリーを作るときは `~/script/gwt`（PATH 上の `gwt`）を使う。
EnterWorktree で直接作らない（`.claude/worktrees/` 配下・`worktree-` 接頭辞のブランチになり、
gwt の規約から外れて `gwt ls` / `gwt rm` の管理下に入らないため）。

手順:

1. `gwt add --no-open <branch-name>`
   - `--no-open` を必ず付ける。既定の `GWT_OPEN_CMD=cd` はユーザーのシェルを
     ワークツリーへ移動させるためのもので、エージェントからは警告が出るだけ
   - 作成先は `<メインワークツリーの親>/<リポジトリ名>_<ブランチ名>`
   - `origin/<default>` から生やすので、メインワークツリーが何を checkout していても、
     dirty でも通る。メインワークツリーには一切触らない
   - **ワークツリーには `node_modules` などが引き継がれない。**
     セットアップが要るなら `GWT_POST_ADD='npm ci' gwt add --no-open <branch>`
2. `gwt path <branch-name>` で得たパスを `path` に渡して EnterWorktree で入る
   （`name` は使わない）
3. 片付けは `gwt rm <branch-name>`。`origin/<default>` にマージ済みのときだけ通る。
   squash merge されたものや捨てる実験ブランチは `gwt rm -f <branch-name>`
