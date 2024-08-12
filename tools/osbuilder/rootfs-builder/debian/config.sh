#
# Copyright (c) 2018 SUSE
#
# SPDX-License-Identifier: Apache-2.0

OS_VERSION=${OS_VERSION:-12.6}

# Set OS_NAME to the desired debian "codename"
OS_NAME=${OS_NAME:-"bookworm"}

PACKAGES="systemd coreutils init iptables chrony kmod"

# Init process must be one of {systemd,kata-agent}
INIT_PROCESS=systemd

# List of zero or more architectures to exclude from build,
# as reported by  `uname -m`
ARCH_EXCLUDE_LIST=()
