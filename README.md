# wsl-wetup

WSL (Windows Subsystem for Linux) 環境を自動的にセットアップするための設定ファイル集

## 概要

このリポジトリには、WSL環境を自動セットアップするための以下のファイルが含まれています：

- **cloud-init.yaml**: WSL初期化用のcloud-init設定
- **.chezmoi/**: chezmoi dotfiles（bashrc、devbox設定など）

## セットアップフロー

1. **cloud-init** で基本パッケージをインストールし、chezmoiをセットアップ
2. **chezmoi** で dotfiles を適用し、devboxをインストール
3. **devbox** で開発ツール（Go, Node.js, Firebase Tools等）をインストール

## 使用方法

### 方法1: cloud-initを使用したセットアップ（推奨）

WSLの初期セットアップ時に`cloud-init.yaml`を使用：

```ps1
notepad $PWD\.cloud-init\Ubuntu-22.04.user-data
```

```bash
-d Ubuntu-22.04
```

### 方法2: 手動セットアップ

すでにWSL環境がある場合：

```bash
# chezmoiをインストール
sudo sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin

# このリポジトリのdotfilesを適用
chezmoi init --apply https://github.com/hiroyoshii/wsl-wetup.git

# シェルを再起動してdevbox環境を有効化
exec bash
```

## インストールされるツール

- [packages](./cloud-init.yaml)
- [cli/lang](./chezmoi/dot_local/share/devbox/global/default/devbox.json)

## ファイル構成

```
wsl-wetup/
├── cloud-init.yaml                          # WSL初期化設定
├── .chezmoi.yaml.tmpl                       # chezmoi設定
└── chezmoi/                                # chezmoi dotfiles
    ├── run_once_install-devbox.sh          # devboxインストールスクリプト
    └── dot_local/share/devbox/global/default/
        └── devbox.json                      # devboxグローバル設定
```

## 参考リンク

- [chezmoi](https://www.chezmoi.io/)
- [devbox](https://www.jetify.com/devbox)
- [cloud-init](https://cloudinit.readthedocs.io/)
