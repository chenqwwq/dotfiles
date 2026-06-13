-- lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv or not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ===== 从 .vimrc 迁移的配置 =====

-- 前缀键（保持 ; 不变）
vim.g.mapleader = ";"
vim.g.maplocalleader = ","

-- 行号
vim.opt.number = true
vim.opt.relativenumber = true

-- Tab
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2

-- 括号高亮
vim.opt.showmatch = true

-- 搜索
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- 界面
vim.opt.ruler = true
vim.opt.laststatus = 2
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.wildmenu = true
vim.opt.scrolloff = 6
vim.opt.signcolumn = "yes"
vim.opt.cmdheight = 2
vim.opt.updatetime = 300
vim.opt.shortmess:append("c")

-- 折叠
vim.opt.foldmethod = "syntax"
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

-- 换行
vim.opt.wrap = false
vim.opt.textwidth = 80

-- 文件类型检测
vim.cmd("filetype plugin indent on")

-- 禁止生成备份/交换文件
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.history = 2000
vim.opt.directory = vim.fn.expand("~/.vim/.swp//")
vim.opt.undodir = vim.fn.expand("~/.vim/.undo//")

-- 错误不发声
vim.opt.errorbells = false

-- 缩进
vim.opt.autoindent = true
vim.opt.smartindent = true

-- 显示特殊符号
vim.opt.list = true
vim.opt.listchars = "tab:▸ ,trail:·,eol:¬,nbsp:_,extends:>,precedes:<"

-- 语法高亮
vim.cmd("syntax enable")
vim.cmd("syntax on")

-- 退出插入模式自动保存 (.go .sh .java)
vim.api.nvim_create_augroup("autoSave", { clear = true })
vim.api.nvim_create_autocmd("InsertLeave", {
  group = "autoSave",
  pattern = { "*.go", "*.sh", "*.java" },
  command = "silent! write",
})

-- ===== LSP 快捷键（从 .vimrc.coc 迁移） =====
vim.api.nvim_create_augroup("lspAttach", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
  group = "lspAttach",
  callback = function(ev)
    local opts = { buffer = ev.buf, silent = true }

    -- 跳转到定义/类型定义/实现/引用
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

    -- 重命名
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

    -- 代码操作
    vim.keymap.set({ "n", "x" }, "<leader>a", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>ac", vim.lsp.buf.code_action, opts)

    -- 格式化
    vim.keymap.set({ "n", "x" }, "<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, opts)

    -- 悬停文档
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

    -- 诊断导航
    vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]g", vim.diagnostic.goto_next, opts)
  end,
})

-- 加载插件
require("lazy").setup("plugins", {
  change_detection = { notify = false },
})
