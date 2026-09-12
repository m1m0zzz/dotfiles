# GitHub Stacked PR

スタックは `gh stack`（[github/gh-stack](https://github.com/github/gh-stack) 拡張）で管理する。

## 進め方

1 PR 分の実装・必要な確認・コミットが完了するたびに、その時点のスタックを Draft で submit する。
依頼されたすべての PR を作成し、スタック内のすべての段で CI が通ったら、
スタック内の全 PR の Draft を解除する。

下段のコミットを amend などで書き換えた場合は、後続の段を rebase してから
スタックを再度 submit する。

## コマンド

**スタックの所属は PR の base ref とは別に GitHub 側へ保存される。**
`gh pr create --base <下の段のブランチ>` は base を設定するだけでスタックには入らないので、
スタックに積むつもりの PR を `gh pr create` だけで作らないこと。

- 新しく作る: `gh stack init [branch …]` → `gh stack submit`
- 既存スタックに 1 本足す:
  `gh stack link <bottom PR> … <top PR> <新 PR>`（bottom → top の順。既存分は skip される）
  stack 番号が分かっていれば `gh stack link <stack 番号> <新 PR>` でよい
- 確認: `gh stack view` はローカル追跡が無いと使えない。追跡なしで確かめるなら
  `gh api graphql` で `pullRequest(number:N){ stack{ number size entries(first:20){ nodes{ pullRequest{ number } } } } }`

rebase し直したときは、各ブランチを下から順に force push すれば PR は追従する。
**base ref もスタックの登録も維持される**ので、PR を作り直す必要はない。
