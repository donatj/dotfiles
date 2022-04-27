#!/bin/bash

brew install \
	htop \
	git \
	ffmpeg \
	wget \
	exiftool \
	guetzli \
	deno \
	tmux \
	shellcheck \
	jq

brew tap homebrew/cask-fonts
brew install --cask font-fira-code font-ibm-plex font-jetbrains-mono
