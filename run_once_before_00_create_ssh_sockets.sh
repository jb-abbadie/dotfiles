#!/bin/sh
set -eu

# Create the private directory used by SSH's ControlPath before applying config.
umask 077
mkdir -p "$HOME/.ssh/sockets"
chmod 700 "$HOME/.ssh" "$HOME/.ssh/sockets"
