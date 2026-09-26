# codex: ワークツリーでも動くようにするラッパー
#
# ワークツリーでは .git が「<main>/.git/worktrees/<name>」を指すファイルで、実体は
# workspace の外にある。codex のサンドボックスからは見えず git 操作が失敗するので、
# git の共通ディレクトリと main ワークツリーを --add-dir で明示的に渡す。
# 共通ディレクトリだけでは git の参照は更新できても、別の場所にある main の
# ファイル本体は更新できない。
#
# なぜ alias ではなく関数か:
#   alias は関数より先に展開されるため、alias codex と関数 codex を両方定義すると
#   関数は絶対に呼ばれない。そのため alias codex は廃止した（aliases.sh 参照）。
#   利用制限の自動リトライは、この関数から agent-auto-continue を呼んで維持する。
#   agent-auto-continue は type -P で実体を探すので、この関数には戻ってこない。
#   Herdr のペイン外では agent-auto-continue 側が codex を素通しする。
#
# ラッパーを迂回したいときは `command codex ...`。

codex() {
  local gitdir
  local extra=()

  if gitdir=$(git rev-parse --path-format=absolute --git-common-dir 2>/dev/null); then
    extra+=(--add-dir "$gitdir")

    # 通常のリポジトリと linked worktree のどちらでも、common dir が
    # <main>/.git ならその親が main ワークツリー。通常のリポジトリでは cwd と
    # 重複するだけだが、linked worktree ではマージ後に main を更新するために必要。
    if [[ $gitdir == */.git ]]; then
      extra+=(--add-dir "${gitdir%/.git}")
    fi
  fi

  agent-auto-continue --agent codex "${extra[@]}" "$@"
}
