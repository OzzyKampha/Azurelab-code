#!/bin/bash -eux

# Add ubuntu user to sudoers.
echo "ubuntu        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

# Disable daily apt unattended updates.
echo 'APT::Periodic::Enable "0";' >> /etc/apt/apt.conf.d/10periodic

# Increase vm.max_map_count for Elastic Stack to run
echo 'vm.max_map_count=262144' >> /etc/sysctl.conf

