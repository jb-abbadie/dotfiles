#!/bin/bash
if [ ! -d ${ZDOTDIR:-~}/.antidote ]; then
  git clone --depth=1 https://github.com/mattmc3/antidote.git
fi
