# codex: ワークツリーでも動くようにするラッパー
#
# ワークツリーでは .git が「<main>/.git/worktrees/<name>」を指すファイルで、実体は
# workspace の外にある。codex のサンドボックスからは見えず git 操作が失敗するので、
# git の共通ディレクトリを --add-dir で明示的に渡す。
#
# なぜ alias ではなく関数か:
#   alias は関数より先に展開されるため、alias codex と関数 codex を両方定義すると
#   関数は絶対に呼ばれない。そのため alias codex は廃止した（aliases.sh 参照）。
#   利用制限の自動リトライは、この関数から agent-auto-continue を呼んで維持する。
#   agent-auto-continue は type -P で実体を探すので、この関数には戻ってこない。
#
# agent-auto-continue は Herdr のペイン内でないと起動できない（HERDR_PANE_ID 必須）
# ため、ペイン外では codex を直接叩く。--add-dir はどちらの経路でも付く。
#
# ラッパーを迂回したいときは `command codex ...`。
codex() {
  local gitdir
  local extra=()

  if gitdir=$(git rev-parse --path-format=absolute --git-common-dir 2>/dev/null); then
    extra=(--add-dir "$gitdir")
  fi

  if [[ -n ${HERDR_PANE_ID:-} ]]; then
    agent-auto-continue --agent codex "${extra[@]}" "$@"
  else
    command codex "${extra[@]}" "$@"
  fi
}
