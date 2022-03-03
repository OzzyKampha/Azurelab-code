#!/bin/bash -eux

SSH_USER=${SSH_USERNAME:-ubuntu}

# Apt cleanup.
echo "==> Autoremove clean"
apt-get autoremove -y
apt-get update -y

echo "==> Cleaning up tmp"
rm -rf /tmp/*

# Remove Bash history
unset HISTFILE
rm -f /root/.bash_history
rm -f /home/${SSH_USER}/.bash_history

# Add `sync` so Packer doesn't quit too early, before the large file is deleted.
sync
