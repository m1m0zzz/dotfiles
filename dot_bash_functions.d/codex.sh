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
#   Herdr のペイン外では agent-auto-continue 側が codex を素通しする。
#
# ラッパーを迂回したいときは `command codex ...`。

# alias はパース時に展開されるため、codex という alias が生きているシェルでは
# 下の codex() { ... } が構文エラーになる。旧設定の alias が残ったまま
# .bashrc を再読み込みした場合に備えて、先に外しておく。
# （alias 展開はコマンド単位なので、別行の unalias は次の定義より先に効く）
unalias codex 2>/dev/null

codex() {
  local gitdir
  local extra=()

  if gitdir=$(git rev-parse --path-format=absolute --git-common-dir 2>/dev/null); then
    extra=(--add-dir "$gitdir")
  fi

  agent-auto-continue --agent codex "${extra[@]}" "$@"
}
