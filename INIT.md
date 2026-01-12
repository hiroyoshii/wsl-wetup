
## Git SSH 設定

1. SSHキーを作成（メールアドレスは自身のものに置き換え）

  ```bash
  ssh-keygen -t ed25519 -C "orient110yh@gmail.com" -f ~/.ssh/id_ed25519
  ```

2. ssh-agent を起動してキーを登録

  ```bash
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_ed25519
  ```

3. 公開鍵をGitHubに登録

  ```bash
  cat ~/.ssh/id_ed25519.pub
  ```

  GitHubの Settings → SSH and GPG keys → New SSH key で貼り付けて保存。

4. 接続確認

  ```bash
  ssh -T git@github.com
  ```

## Repo 追加
```bash
~/.bin/wsl-clone-repos.sh
```