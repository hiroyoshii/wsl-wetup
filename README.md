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

## 機能

### fzf 履歴検索

`Ctrl+R` を押すことで、コマンド履歴をファジー検索できます。fzfを使った履歴検索機能が自動的に設定されます。

- **使い方**: コマンドライン上で `Ctrl+R` を押す
- **検索**: 入力した文字列で履歴を絞り込み
- **選択**: ↑↓ キーで選択、Enter で確定

## インストールされるツール

### 基本パッケージ（cloud-init経由）
- git
- curl
- unzip

### 開発ツール（devbox経由）
- Go 1.23
- Node.js 22
- Google Cloud SDK
- Firebase Tools
- fzf (fuzzy finder for history search)
- Starship (高速でカスタマイズ可能なプロンプト)

## ファイル構成

```
wsl-wetup/
├── cloud-init.yaml                          # WSL初期化設定
├── .chezmoi.yaml.tmpl                       # chezmoi設定
└── .chezmoi/                                # chezmoi dotfiles
    ├── dot_bashrc                           # bashrc設定
    ├── dot_config/
    │   └── starship.toml                    # Starship プロンプト設定
    ├── run_once_install-devbox.sh          # devboxインストールスクリプト
    └── dot_local/share/devbox/global/default/
        └── devbox.json                      # devboxグローバル設定
```

## カスタマイズ

### パッケージの追加・変更

`.chezmoi/dot_local/share/devbox/global/default/devbox.json` を編集：

```json
{
  "packages": [
    "go@1.23",
    "nodejs@22",
    "python@3.11",
    "terraform@latest"
  ]
}
```

### bashrcのカスタマイズ

`.chezmoi/dot_bashrc` を編集してエイリアスや環境変数を追加できます。

### Starshipプロンプトのカスタマイズ

Starship はシェルプロンプトを高速かつ美しく表示します。設定は `.chezmoi/dot_config/starship.toml` で行えます。

詳細は [Starship 公式ドキュメント](https://starship.rs/ja-JP/) を参照してください。

## トラブルシューティング

### devboxが認識されない場合

シェルを再起動してください：

```bash
exec bash
```

### chezmoi設定を再適用

```bash
chezmoi apply
```

## 参考リンク

- [chezmoi](https://www.chezmoi.io/)
- [devbox](https://www.jetify.com/devbox)
- [cloud-init](https://cloudinit.readthedocs.io/)
