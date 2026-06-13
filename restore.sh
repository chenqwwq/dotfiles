#!/bin/bash
#
# dotfiles 恢复脚本
# 将本仓库中的配置文件以软链接方式安装到当前用户的 $HOME 目录
#
# 用法:
#   ./restore.sh          # 安装所有配置
#   ./restore.sh uninstall # 移除所有软链接
#

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_DIR="$HOME"

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

info()  { echo -e "${GREEN}[INFO]${NC}  $*"; }
warn()  { echo -e "${YELLOW}[WARN]${NC}  $*"; }
error() { echo -e "${RED}[ERROR]${NC} $*"; }

# 创建一个软链接: link_file <源文件绝对路径> <目标路径(相对HOME)>
link_file() {
  local src="$1"
  local dst="$2"
  local dst_abs="${HOME_DIR}/${dst}"

  if [[ ! -e "$src" ]]; then
    warn "源文件不存在，跳过: $src"
    return 0
  fi

  # 如果目标已存在且是指向同一源的软链接，跳过
  if [[ -L "$dst_abs" && "$(readlink "$dst_abs")" == "$src" ]]; then
    info "已存在，跳过: ~/$dst"
    return 0
  fi

  # 目标存在且不是软链接，备份
  if [[ -e "$dst_abs" && ! -L "$dst_abs" ]]; then
    local backup="${dst_abs}.bak.$(date +%Y%m%d%H%M%S)"
    mv "$dst_abs" "$backup"
    warn "已备份原有文件: $dst -> ${dst}.bak.*"
  fi

  # 如果是失效的软链接，先删除
  [[ -L "$dst_abs" ]] && rm -f "$dst_abs"

  ln -sf "$src" "$dst_abs"
  info "已链接: ~/$dst -> $src"
}

# 安装
install() {
  echo "=========================================="
  echo "  dotfiles 恢复 - 安装"
  echo "  HOME:      $HOME_DIR"
  echo "  DOTFILES:  $DOTFILES_DIR"
  echo "=========================================="

  # --------------------------------------------------
  # NeoVim
  # --------------------------------------------------
  info "配置 NeoVim ..."
  mkdir -p "${HOME_DIR}/.config"
  link_file "${DOTFILES_DIR}/nvim" ".config/nvim"

  # --------------------------------------------------
  # Vim (legacy)
  # --------------------------------------------------
  info "配置 Vim ..."
  link_file "${DOTFILES_DIR}/.vimrc"        ".vimrc"
  link_file "${DOTFILES_DIR}/.vimrc.coc"    ".vimrc.coc"
  link_file "${DOTFILES_DIR}/.vimrc.plugged" ".vimrc.plugged"
  link_file "${DOTFILES_DIR}/.vim"          ".vim"

  # 创建 vim 运行时所需目录（.vimrc 中引用了这些路径）
  mkdir -p "${DOTFILES_DIR}/.vim/.swp"
  mkdir -p "${DOTFILES_DIR}/.vim/.undo"
  info "Vim 运行时目录已就绪 (.swp / .undo)"

  # --------------------------------------------------
  # Zsh
  # --------------------------------------------------
  info "配置 Zsh ..."
  link_file "${DOTFILES_DIR}/.zshrc"      ".zshrc"
  link_file "${DOTFILES_DIR}/.zshrc.alias" ".zshrc.alias"

  # oh-my-zsh: 仓库中是空目录，如果本机已安装则保留本机的；否则给出提示
  if [[ -d "${HOME_DIR}/.oh-my-zsh" ]]; then
    info "检测到本机已安装 oh-my-zsh: ${HOME_DIR}/.oh-my-zsh"
  else
    warn "未检测到 oh-my-zsh，请手动安装: sh -c \"\$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\""
  fi

  echo ""
  info "安装完成！"
}

# 卸载
uninstall() {
  echo "=========================================="
  echo "  dotfiles 恢复 - 卸载"
  echo "=========================================="

  local targets=(
    ".config/nvim"
    ".vimrc"
    ".vimrc.coc"
    ".vimrc.plugged"
    ".vim"
    ".zshrc"
    ".zshrc.alias"
  )

  for t in "${targets[@]}"; do
    local abs="${HOME_DIR}/${t}"
    if [[ -L "$abs" ]]; then
      rm -f "$abs"
      info "已移除软链接: ~/$t"
    elif [[ -e "$abs" ]]; then
      warn "存在但非软链接，未删除: ~/$t"
    fi
  done

  echo ""
  info "卸载完成！备份文件(.bak.*)未自动清理，如需可手动删除。"
}

# 主入口
case "${1:-install}" in
  install)
    install
    ;;
  uninstall)
    uninstall
    ;;
  *)
    echo "用法: $0 [install|uninstall]"
    exit 1
    ;;
esac
