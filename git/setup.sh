#!/bin/zsh

git config --global --replace-all core.excludesfile "$HOME/.gitignore_global"

git config --global --replace-all alias.dp "diff --patience"
git config --global --replace-all alias.cp "cherry-pick"
git config --global --replace-all alias.cplog 'log --oneline --reverse'
git config --global --replace-all alias.cb "checkout -b"
git config --global --replace-all alias.personal 'config user.email "donatj@gmail.com"'
git config --global --replace-all alias.exclude '!f(){ echo $1 >> $(git rev-parse --git-dir)/info/exclude; }; f'

git config --global --replace-all alias.co '!f(){ git fetch origin; git checkout origin/$1; }; f'
git config --global --replace-all alias.cr '!f(){ git fetch origin; git checkout -b $1 origin/$1; }; f'
git config --global --replace-all alias.pr '!f(){ git log --merges --ancestry-path --oneline $1..HEAD | grep "pull request" | tail -n1 | awk "{print \\$5}"; }; f'
