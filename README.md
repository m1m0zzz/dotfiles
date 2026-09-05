# dotfiles

## Setup

### 1. Install chezmoi

```bash
sh -c "$(curl -fsLS get.chezmoi.io)"
```

### 2. Apply dotfiles

```bash
chezmoi init --apply m1m0zzz
```

Windows のユーザー名（`/mnt/c/Users/<name>`）を `winuser` として聞かれる。
値は `~/.config/chezmoi/chezmoi.toml` に保存され、リポジトリには入らない。

非対話で渡す場合:

```bash
chezmoi init --apply --promptString winuser=<name> m1m0zzz
```

値を変えたくなったら `chezmoi init --promptString winuser=<name>` で上書きする。
