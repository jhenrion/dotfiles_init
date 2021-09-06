#SHELL = /bin/bash
DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
#old: OS := $(shell bin/is-supported bin/is-macos macos linux)
OS := $(shell bin/is-supported bin/is-macos macos)
PATH := $(DOTFILES_DIR)/bin:$(PATH)
#NVM_DIR := $(HOME)/.nvm
export XDG_CONFIG_HOME = $(HOME)/.config
export STOW_DIR = $(DOTFILES_DIR)
export ZSH = $(HOME)/.oh-my-zsh
export HAMMERSPOON = $(DOTFILES_DIR)/hammerspoon
#export ACCEPT_EULA=Y

.PHONY: test

all: $(OS)

macos: sudo core-macos packages link cron hammerspoon freerdp chrome

#linux: core-linux link

#core-macos: brew bash git npm ruby
core-macos: brew git zsh

#core-linux:
#	apt-get update
#	apt-get upgrade -y
#	apt-get dist-upgrade -f

stow-macos: brew
	is-executable stow || brew install stow

#stow-linux: core-linux
#	is-executable stow || apt-get -y install stow

sudo:
ifndef GITHUB_ACTION
	sudo -v
	while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
endif

#packages: brew-packages cask-apps node-packages
packages: brew-packages cask-apps

link: stow-$(OS)
	for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE -a ! -h $(HOME)/$$FILE ]; then \
		mv -v $(HOME)/$$FILE{,.bak}; fi; done
	mkdir -p $(XDG_CONFIG_HOME)
	stow -t $(HOME) runcom
	stow -t $(XDG_CONFIG_HOME) config

unlink: stow-$(OS)
	stow --delete -t $(HOME) runcom
	stow --delete -t $(XDG_CONFIG_HOME) config
	for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE.bak ]; then \
		mv -v $(HOME)/$$FILE.bak $(HOME)/$${FILE%%.bak}; fi; done

brew:
	is-executable brew || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash

#bash: BASH=/usr/local/bin/bash
#bash: SHELLS=/private/etc/shells
#bash: brew
#ifdef GITHUB_ACTION
#	if ! grep -q $(BASH) $(SHELLS); then \
#		brew install bash bash-completion@2 pcre && \
#		sudo append $(BASH) $(SHELLS) && \
#		sudo chsh -s $(BASH); \
#	fi
#else
#	if ! grep -q $(BASH) $(SHELLS); then \
#		brew install bash bash-completion@2 pcre && \
#		sudo append $(BASH) $(SHELLS) && \
#		chsh -s $(BASH); \
#	fi
#endif

git: brew
	brew install git git-extras

freerdp: brew
	brew install freerdp

#npm:
#	if ! [ -d $(NVM_DIR)/.git ]; then git clone https://github.com/creationix/nvm.git $(NVM_DIR); fi
#	. $(NVM_DIR)/nvm.sh; nvm install --lts

#ruby: brew
#	brew install ruby

brew-packages: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Brewfile

cron:
	crontab crontab/cron.txt

cask-apps: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Caskfile || true
#	defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"
#	for EXT in $$(cat install/Codefile); do code --install-extension $$EXT; done
#	xattr -d -r com.apple.quarantine ~/Library/QuickLook

#node-packages: npm
#	. $(NVM_DIR)/nvm.sh; npm install -g $(shell cat install/npmfile)

#test:
#	. $(NVM_DIR)/nvm.sh; bats test

# source : https://medium.com/@ivanaugustobd/your-terminal-can-be-much-much-more-productive-5256424658e8
zsh: git font
	if [ -d ${ZSH} ]; then rm -rf ${ZSH}; fi
	curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH}/custom/themes/powerlevel10k
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH}/plugins/zsh-syntax-highlighting
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH}/plugins/zsh-autosuggestions

font:
	if [ -d fonts ]; then rm -rf fonts; fi
	git clone https://github.com/powerline/fonts.git
	cd fonts; ./install.sh; rm -rf fonts

hammerspoon: cask-apps
	. $(HAMMERSPOON)/linker.sh


