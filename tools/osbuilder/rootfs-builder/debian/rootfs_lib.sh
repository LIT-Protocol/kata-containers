#
# Copyright (c) 2018 SUSE
#
# SPDX-License-Identifier: Apache-2.0

# NOTE: Re-using ubuntu rootfs lib, see 'ubuntu' folder for details.

PKG_MANAGER="apt"

build_dbus()
{
    local ROOTFS_DIR=$1

    info "building dbus"
    
    # Prepare directory structure
    mkdir -p $ROOTFS_DIR/etc/systemd/system

    ln -sf /lib/systemd/system/dbus.service $ROOTFS_DIR/etc/systemd/system/dbus.service
    ln -sf /lib/systemd/system/dbus.socket $ROOTFS_DIR/etc/systemd/system/dbus.socket
}

setup_rootfs()
{
    local ROOTFS_DIR=$1

    info "configuring rootfs"
}


build_rootfs()
{
    local ROOTFS_DIR=$1

    [ -z "$ROOTFS_DIR" ] && die "need rootfs"

    check_root
    mkdir -p "${ROOTFS_DIR}"
    
    apt-get update
    apt-get upgrade -y
    apt-get install makedev -qy

    rm -rf ${ROOTFS_DIR}/var
    rm -rf ${ROOTFS_DIR}/etc

    mkdir -p $ROOTFS_DIR/var
    ln -s /run $ROOTFS_DIR/var

    mkdir -p $ROOTFS_DIR/etc/ssl/certs
    cp --remove-destination /etc/ssl/certs/ca-certificates.crt $ROOTFS_DIR/etc/ssl/certs

    # Clean up rootfs directory and reduce size by removing unused files
    rm -rf ${ROOTFS_DIR}/usr/share/{bash-completion,cracklib,doc,info,locale,man,misc,pixmaps,terminfo,zoneinfo,zsh} 

    mkdir -p $ROOTFS_DIR/dev
    pushd $ROOTFS_DIR/dev
    MAKEDEV -v console tty ttyS null zero fd
    popd
}
