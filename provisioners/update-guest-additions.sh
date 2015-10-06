#!/usr/bin/env bash
set -o errexit

echo "Running update-guest-additions.sh script as user: " $(whoami)

VERSION="$(VBoxControl guestproperty get /VirtualBox/HostInfo/VBoxVer | tail -1 | awk '{print $2}')"

ISO="$(mktemp)"
MOUNT="$(mktemp -d)"
wget -O "${ISO}" "http://download.virtualbox.org/virtualbox/${VERSION}/VBoxGuestAdditions_${VERSION}.iso"

mount --read-only "${ISO}" "${MOUNT}"

# remove guest additions that may have been installed on base box
# without this, VBoxControl symlink of old version takes precedence in /usr/sbin
sudo apt-get -y remove virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11 || true
apt-get -y install dkms

set +e
yes | "${MOUNT}/VBoxLinuxAdditions.run"

# preceding command fails. Could be related to X11.
# Manually check for installation

CURVER="$(modinfo vboxguest | grep "^version:" | awk '{print $2}')"
if [ "${VERSION}" != "${CURVER}" ]; then
    # fallback
    echo "Problem Installing Guest Additions"
    sudo apt-get -y install virtualbox-guest-dkms virtualbox-guest-utils
    exit 1
fi

set -e

umount "${MOUNT}"

# cleanup
rm "${ISO}"
rm -r "${MOUNT}"

echo "Done updating guest additions"


