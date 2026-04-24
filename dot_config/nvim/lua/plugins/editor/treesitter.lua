-- ============================================================================
-- Treesitter - 语法高亮和解析
-- 提供语法树解析、高亮、缩进、折叠等功能
-- ============================================================================

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSInstall", "TSUpdate", "TSUpdateSync" },
  build = ":TSUpdate",
  dependencies = {
    { "nvim-treesitter/nvim-treesitter-textobjects" },
    { "windwp/nvim-ts-autotag" },
    { "JoosepAlviste/nvim-ts-context-commentstring" },
  },
  opts = {
    -- 自动安装的语言
    ensure_installed = {
      "bash",
      "c",
      "cpp",
      "css",
      "diff",
      "dockerfile",
      "git_rebase",
      "gitcommit",
      "gitignore",
      "go",
      "gomod",
      "gosum",
      "gowork",
      "html",
      "javascript",
      "jsdoc",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "nix",
      "python",
      "query",
      "regex",
      "rust",
      "sql",
      "styled",
      "svelte",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "vue",
      "yaml",
    },

    -- 自动安装缺失的 parser
    auto_install = true,

    -- 高亮
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },

    -- 缩进
    indent = {
      enable = true,
    },

    -- 增量选择
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },

    -- 文本对象
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]f"] = "@function.outer",
          ["]c"] = "@class.outer",
        },
        goto_next_end = {
          ["]F"] = "@function.outer",
          ["]C"] = "@class.outer",
        },
        goto_previous_start = {
          ["[f"] = "@function.outer",
          ["[c"] = "@class.outer",
        },
        goto_previous_end = {
          ["[F"] = "@function.outer",
          ["[C"] = "@class.outer",
        },
      },
    },

    -- 自动标签（HTML/Vue等）
    autotag = {
      enable = true,
    },
  },
  config = function(_, opts)
    require("nvim-treesitter").setup(opts)

    -- 启用代码折叠
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.opt.foldlevel = 99  -- 默认不折叠
  end,
}
