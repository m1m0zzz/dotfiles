# git コミット

**`git commit` に `-c user.name=` / `-c user.email=` を付けて identity を上書きしないこと。**
素の `git commit` を使い、リポジトリの `git config` の値をそのまま使う。

- コミット用のアドレスは `117814895+m1m0zzz@users.noreply.github.com`（global に設定済み）
- セッションのコンテキストで渡されるメールアドレスは**本人を識別するための情報**であって、
  コミットの author に使ってよいアドレスではない
- identity を明示したくなったら、まず `git config user.name` と `git config user.email` を
  読んで確認する。設定が空のときだけ、どうするかを聞く

理由: 上書きすると GitHub 上でアカウントに紐づかないコミットになり、実アドレスが履歴に
残る。push 後に気づくと、履歴の書き換えと force push が必要になる。
