-- Neovim 插件 & 语言支持清单
-- 支持: JavaScript / TypeScript / Java / C / C++ / Go / Rust / Markdown / Lua / Python / Bash / SQL / JSON / YAML / XML

return {
  -- ===== 主题 =====
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    config = function()
      local function is_dark()
        local result = vim.fn.system("defaults read -g AppleInterfaceStyle 2>/dev/null")
        return vim.v.shell_error == 0 and result:match("Dark") ~= nil
      end
      local function apply_theme()
        if is_dark() then
          vim.cmd.colorscheme("nightfox")
          vim.opt.background = "dark"
        else
          vim.cmd.colorscheme("dayfox")
          vim.opt.background = "light"
        end
      end
      apply_theme()
      vim.api.nvim_create_autocmd("FocusGained", { callback = apply_theme })
    end,
  },

  -- ===== 文件树 =====
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
    keys = { { "<C-t>", "<cmd>Neotree toggle<cr>", desc = "文件树" } },
    opts = { filesystem = { filtered_items = { hide_dotfiles = false } } },
  },

  -- ===== 缩进线 =====
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },

  -- ===== 模糊搜索 =====
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "查找文件" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "文本搜索" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "切换缓冲区" },
    },
  },

  -- ===== 状态栏 =====
  {
    "nvim-lualine/lualine.nvim",
    opts = {},
  },

  -- ===== 语法高亮 Treesitter =====
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.config").setup({
        ensure_installed = {
          "lua", "vim", "vimdoc",
          "javascript", "typescript", "tsx",
          "java",
          "c", "cpp",
          "go", "gomod",
          "rust",
          "python",
          "bash", "json", "yaml", "toml", "xml",
          "markdown", "markdown_inline",
          "sql", "html", "css",
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- ===== LSP 安装器 =====
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = {
        "lua_ls",
        "ts_ls",          -- JavaScript / TypeScript
        "jdtls",          -- Java
        "clangd",         -- C / C++
        "gopls",          -- Go
        "rust_analyzer",  -- Rust
        "pyright",        -- Python
        "bashls",
        "marksman",       -- Markdown
        "jsonls",
        "yamlls",
      },
      automatic_installation = true,
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
    end,
  },

  -- ===== 代码补全 =====
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local has_words_before = function()
        if vim.bo.buftype == "prompt" then return false end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, col - 1, line - 1, col, {})[1]:match("%s") == nil
      end

      cmp.setup({
        snippet = {
          expand = function(args) require("luasnip").lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
              require("luasnip").expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
              require("luasnip").jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
      })
    end,
  },

  -- ===== 括号自动配对 =====
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  -- ===== Git 标记 =====
  {
    "lewis6991/gitsigns.nvim",
    opts = {},
  },

  -- ===== 注释 =====
  {
    "numToStr/Comment.nvim",
    opts = {},
  },
}
