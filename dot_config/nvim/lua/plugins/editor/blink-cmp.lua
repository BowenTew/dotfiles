-- ============================================================================
-- blink.cmp - 代码补全引擎 (Rust 后端, 替代 nvim-cmp)
--
-- 补全源 (按优先级):
--   LSP(100) > Snippets(80) > Path(50) > Buffer(10)
--
-- 快捷键:
--   <C-Space>  → 显示补全 / 切换文档
--   <C-e>      → 关闭补全
--   <CR>       → 确认选择
--   <Tab>      → 下一项 / snippet 跳转下一占位符
--   <S-Tab>    → 上一项 / snippet 跳转上一占位符
--   <C-n/p>    → 下一项 / 上一项
--   <C-b/f>    → 文档上翻 / 下翻
--   <C-k>      → LuaSnip 展开或跳转下一占位符
--   <C-j>      → LuaSnip 跳转上一占位符
--
-- 特性:
--   - Rust 模糊匹配引擎, 允许最多 2 个拼写错误
--   - Ghost text 预览
--   - 自动文档弹窗 (200ms 延迟)
--   - 函数签名参数提示
--   - Treesitter 高亮补全项
--   - TS/JSX 文件继承 JS snippet
-- ============================================================================

return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "L3MON4D3/LuaSnip", -- 代码片段引擎
  },
  version = "*",

  -- 可选配置
  opts = {
    -- 按键映射
    keymap = {
      preset = "default",
      -- 显示/隐藏补全菜单
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      -- 确认选择
      ["<CR>"] = { "accept", "fallback" },
      -- 选择下一项/上一项
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },
      -- 文档滚动
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    },

    -- 外观配置
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
      kind_icons = AeonVim.icons.kind, -- 使用统一的图标
    },

    -- 补全行为
    completion = {
      -- 菜单显示
      menu = {
        border = "rounded",
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        draw = {
          gap = 2,
          columns = {
            { "kind_icon", "label", gap = 1 },
            { "kind" },
          },
          treesitter = { "lsp" }, -- 使用 Treesitter 高亮补全项
        },
      },
      -- 文档窗口
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = {
          border = "rounded",
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,Search:None",
        },
      },
      -- 接受补全时显示 ghost text
      ghost_text = {
        enabled = true,
      },
      -- 触发补全
      trigger = {
        show_on_keyword = true,
        show_on_trigger_character = true,
      },
    },

    -- 补全源
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      -- 每个源的特定配置
      providers = {
        lsp = {
          name = "LSP",
          module = "blink.cmp.sources.lsp",
          score_offset = 100, -- LSP 结果优先级最高
        },
        path = {
          name = "Path",
          module = "blink.cmp.sources.path",
          score_offset = 50,
          opts = {
            trailing_slash = false,
            label_trailing_slash = true,
            get_cwd = function(context)
              return vim.fn.expand("#%:p:h")
            end,
          },
        },
        snippets = {
          name = "Snippets",
          module = "blink.cmp.sources.snippets",
          score_offset = 80,
          opts = {
            friendly_snippets = true,
            search_paths = { vim.fn.stdpath("config") .. "/snippets" },
            global_snippets = { "all" },
            extended_filetypes = {
              typescript = { "javascript" },
              typescriptreact = { "typescript", "javascript" },
              javascriptreact = { "javascript" },
            },
          },
        },
        buffer = {
          name = "Buffer",
          module = "blink.cmp.sources.buffer",
          score_offset = 10,
          opts = {
            get_bufnrs = function()
              return vim.tbl_filter(function(bufnr)
                return vim.bo[bufnr].buftype == ""
              end, vim.api.nvim_list_bufs())
            end,
          },
        },
      },
    },

    -- 签名帮助（函数参数提示）
    signature = {
      enabled = true,
      window = {
        border = "rounded",
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,Search:None",
      },
    },

    -- 模糊匹配
    fuzzy = {
      implementation = "rust", -- 使用 Rust 实现，性能更好
      max_typos = 2, -- 允许的最大拼写错误
    },
  },

  -- 允许扩展配置
  opts_extend = { "sources.default" },

  -- 可选：配置 LuaSnip 集成
  config = function(_, opts)
    require("blink.cmp").setup(opts)

    -- 可选：配置 LuaSnip 按键
    local ls = require("luasnip")
    vim.keymap.set({ "i", "s" }, "<C-k>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end, { silent = true, desc = "LuaSnip expand/jump" })
    vim.keymap.set({ "i", "s" }, "<C-j>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, { silent = true, desc = "LuaSnip jump back" })
  end,
}
