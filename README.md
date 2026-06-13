# dotfiles

个人开发环境配置备份，包含 Vim、NeoVim、Zsh 等配置文件。

## 目录结构

```
.
├── nvim/              # NeoVim 配置 (Lua)
│   ├── init.lua
│   ├── lazy-lock.json
│   └── lua/
├── .vim/              # Vim 运行时目录（插件、撤销历史等）
├── .vimrc             # Vim 主配置
├── .vimrc.coc         # Vim coc.nvim 配置
├── .vimrc.plugged     # Vim 插件列表 (vim-plug)
├── .zshrc             # Zsh 主配置
├── .zshrc.alias       # Zsh 别名
├── .oh-my-zsh/        # oh-my-zsh（占位，需本机自行安装）
├── restore.sh         # 恢复脚本
└── README.md
```

## 快速使用

```bash
# 安装配置（将文件以软链接方式部署到 $HOME）
./restore.sh

# 卸载配置（移除所有软链接）
./restore.sh uninstall
```

`restore.sh` 会在 `$HOME` 下创建以下软链接：

| 目标路径 | 源 |
|---------|---|
| `~/.config/nvim` | `nvim/` |
| `~/.vimrc` | `.vimrc` |
| `~/.vimrc.coc` | `.vimrc.coc` |
| `~/.vimrc.plugged` | `.vimrc.plugged` |
| `~/.vim` | `.vim/` |
| `~/.zshrc` | `.zshrc` |
| `~/.zshrc.alias` | `.zshrc.alias` |

> 若目标位置已存在真实文件，脚本会自动备份为 `*.bak.<时间戳>`。

## 依赖安装

- **oh-my-zsh**：`sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
- **Vim 插件**：打开 Vim 后执行 `:PlugInstall`
- **coc.nvim 扩展**：按需执行 `:CocInstall <extension>`
