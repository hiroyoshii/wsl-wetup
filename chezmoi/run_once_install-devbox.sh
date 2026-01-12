#!/bin/bash
# このスクリプトは chezmoi apply 時に一度だけ実行され、devbox をインストールします

set -e

disable_ipv6_for_devbox() {
    echo "Disabling IPv6 for devbox update (requires sudo/root)..."
    if command -v sudo >/dev/null 2>&1; then
        echo 'net.ipv6.conf.all.disable_ipv6 = 1'  | sudo tee /etc/sysctl.d/99-disable-ipv6.conf >/dev/null
        echo 'net.ipv6.conf.default.disable_ipv6 = 1' | sudo tee -a /etc/sysctl.d/99-disable-ipv6.conf >/dev/null
        # ensure system configs are reloaded (needed on some distros)
        sudo sysctl --system
    else
        echo 'net.ipv6.conf.all.disable_ipv6 = 1'  > /etc/sysctl.d/99-disable-ipv6.conf
        echo 'net.ipv6.conf.default.disable_ipv6 = 1' >> /etc/sysctl.d/99-disable-ipv6.conf
        sysctl --system 
    fi
}

echo "Installing devbox..."

if command -v devbox >/dev/null 2>&1; then
    echo "devbox is already installed."
    devbox version
else
    curl -L https://nixos.org/nix/install | sh -s -- --daemon --yes
    . /etc/profile.d/nix.sh
    nix profile add github:jetify-com/devbox/latest --extra-experimental-features nix-command --extra-experimental-features flakes

    if command -v devbox >/dev/null 2>&1; then
        echo "devbox installation successful!"
        devbox version
    else
        echo "devbox installation failed!"
        exit 1
    fi
fi

echo "Forcing IPv4 and refreshing devbox global environment..."
disable_ipv6_for_devbox
# ログイン不要で進めるため、remote pull はスキップし、更新失敗も致命にしない
DEVBOX_PREFER_IPV4=1 devbox global update || \
    echo "devbox global update skipped (likely not logged in)"

echo "devbox setup complete!"
