#!/bin/zsh

git config --global --replace-all core.excludesfile "$HOME/.gitignore_global"

git config --global --replace-all alias.dp "diff --patience"
git config --global --replace-all alias.cp "cherry-pick"
git config --global --replace-all alias.cplog 'log --oneline --reverse'
git config --global --replace-all alias.cb "checkout -b"
git config --global --replace-all alias.exclude '!f(){ echo $1 >> $(git rev-parse --git-dir)/info/exclude; }; f'