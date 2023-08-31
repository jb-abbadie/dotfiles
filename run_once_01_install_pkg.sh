#!/bin/bash
{{ if eq .chezmoi.osRelease.id "arch" }}
 sudo pacman -S --needed \
     alacritty \
     bat \
     bemenu \
     brightnessctl \
     choose \
     dog \
     dunst \
     fd \
     firefox \
     fzf \
     hyperfine \
     imv \
     jq \
     keychain \
     kmscon \
     kubectl \
     kubie \
     pavucontrol \
     ranger \
     ripgrep \
     sway \
     swayidle \
     swaylock \
     tmux \
     waybar \
     waylock \
     zsh
{{ end }}
