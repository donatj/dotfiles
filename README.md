dotfiles
========

[![Install](https://github.com/donatj/dotfiles/actions/workflows/install.yml/badge.svg)](https://github.com/donatj/dotfiles/actions/workflows/install.yml)

My personal dotfiles repo

Supported Linux, macOS and WSL. The installation process is CI tested.

Principles
----------

Generally, think of my dotfiles as an exercise in restraint.

One might righly look at this and think "Oh, there's not much here". That is by design. I'd rather *learn* the defaults than become dependent on configuration. I spend a lot of time SSH'd into servers which I cannot install my dotfiles. I want to be able to jump onto any machine and be productive.

More often than not, I don't configure something unless it literally does not work for me, or in the case of a lot of macOS things, it changed out from under me.

I avoiding special tooling, keeping the installer a simple shell script. I want to keep this as simple as reasonable.

Installation
------------

**Warning**: Do not run with sudo unless you know what you are doing. This likely will cause permission issues. You do not need it. It will ask for sudo when it needs it.

```bash
cd ~
git clone git@github.com:donatj/dotfiles.git
./dotfiles/install.sh
```
