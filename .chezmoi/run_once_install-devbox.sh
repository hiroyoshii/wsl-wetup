#!/bin/bash
# このスクリプトは chezmoi apply 時に一度だけ実行され、devbox をインストールします

set -e

echo "Installing devbox..."

# devbox がすでにインストールされているか確認
if command -v devbox >/dev/null 2>&1; then
    echo "devbox is already installed."
    devbox version
    exit 0
fi

# devbox をインストール
curl -fsSL https://get.jetify.com/devbox | bash

# インストール確認
if command -v devbox >/dev/null 2>&1; then
    echo "devbox installation successful!"
    devbox version
    
    # グローバル設定の初期化
    echo "Initializing devbox global configuration..."
    devbox global pull
else
    echo "devbox installation failed!"
    exit 1
fi

echo "devbox setup complete!"
