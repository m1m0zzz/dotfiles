alias sad='ssh-add ~/.ssh/id_ed25519'

alias pd='cd ..'
alias ppd='cd ../..'
alias pppd='cd ../../..'
alias ppppd='cd ../../../..'
alias pppppd='cd ../../../../..'
alias ppppppd='cd ../../../../../..'

# ~/script/agent-auto-continue
alias claude='agent-auto-continue'
# codex は --add-dir を渡すため codex.sh のシェル関数にしてある（alias だと関数が
# 展開順で負けて呼ばれないので、ここに alias codex を復活させないこと）

# Windows の adb を利用する（PATH は .bashrc 側で設定）
alias adb='adb.exe'
