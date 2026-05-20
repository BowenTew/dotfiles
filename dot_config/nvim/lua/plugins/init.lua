return {
  -- 格式化器
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- 保存前才加载（与 format_on_save 配合）
    opts = require "configs.conform",
  },

  -- LSP 客户端
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Mason ↔ lspconfig 桥接：自动确保 LSP 安装并启用
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "bashls",        -- Bash
        "clangd",        -- C / C++
        "cssls",         -- CSS
        "dockerls",      -- Dockerfile
        "eslint",        -- JS/TS linting
        "gopls",         -- Go
        "html",          -- HTML
        "jsonls",        -- JSON
        "lua_ls",        -- Lua
        "pyright",       -- Python
        "rust_analyzer", -- Rust
        "svelte",        -- Svelte
        "taplo",         -- TOML
        "ts_ls",         -- TypeScript / JavaScript
        "vue_ls",        -- Vue (Volar)
        "yamlls",        -- YAML
      },
      automatic_installation = true,
    },
  },

  -- 自动安装 formatter / linter（mason 主仓）
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "VeryLazy",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        "stylua",       -- Lua formatter
        "prettier",     -- JS/TS/Vue/CSS/HTML/JSON/YAML/MD formatter
        "black",        -- Python formatter
        "isort",        -- Python import sorter
        "luacheck",     -- Lua linter
        "eslint_d",     -- JS/TS linter daemon
      },
      auto_update = false,
      run_on_start = true,
    },
  },

  -- ===========================================================================
  -- UI：noice.nvim - cmdline / messages / 通知 浮窗化
  -- ===========================================================================
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      cmdline = {
        enabled = true,
        view = "cmdline_popup", -- : 命令走屏幕中央浮窗（VSCode 风格）
      },
      messages = {
        enabled = true,
        view = "mini",        -- 短消息走右下角 mini 浮窗
        view_error = "notify", -- 错误走通知
        view_warn = "notify",  -- 警告走通知
      },
      notify = {
        enabled = true,
        view = "notify",
      },
      lsp = {
        progress = { enabled = false }, -- 让 NvChad 自己的 LSP 进度条接管
        hover = { enabled = false },    -- K hover 保持原生（与 NvChad 兼容）
        signature = { enabled = true }, -- 但接管签名帮助
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
      presets = {
        bottom_search = true,         -- / 搜索仍在底部（保留 vim 习惯）
        command_palette = true,       -- : 命令居中浮窗
        long_message_to_split = true, -- 长消息开新 split，告别 "Press ENTER to continue"
        lsp_doc_border = true,        -- LSP 文档浮窗加边框
      },
    },
  },

  -- nvim-cmp：在 NvChad 默认基础上额外支持 ↑/↓ 切换补全项
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require "cmp"
      opts.mapping = opts.mapping or {}
      opts.mapping["<Down>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select }
      opts.mapping["<Up>"]   = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select }
      return opts
    end,
  },

  -- Treesitter 语法高亮 / 缩进 / 折叠
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- NvChad starter 默认
        "vim", "vimdoc", "lua",
        -- 主力语言
        "bash", "c", "cpp", "go", "gomod", "gowork", "gosum",
        "rust", "python",
        "javascript", "jsdoc", "typescript", "tsx",
        "vue", "svelte", "html", "css", "scss",
        -- 配置/文档
        "json", "json5", "jsonc", "yaml", "toml",
        "markdown", "markdown_inline",
        "dockerfile", "make", "diff", "gitignore", "gitcommit",
      },
    },
  },
}
