-- ============================================================================
-- mason-lspconfig.nvim - Mason 与 LSPConfig 桥接
-- 自动确保 LSP 服务器安装并启动
--
-- 职责：
--   1. 声明需要自动安装的 LSP 服务器列表（ensure_installed）
--   2. 在 LSP 附加到 buffer 时统一绑定快捷键（LspAttach）
--
-- 快捷键一览（仅在 LSP 激活的 buffer 中生效）：
--
--   导航跳转
--     gd          跳转到定义（definition）
--     gr          查看所有引用（references）
--     gI          跳转到接口实现（implementation）
--     gy          跳转到类型定义（type definition）
--     gD          跳转到声明（declaration）
--
--   文档与签名
--     K           悬浮文档（hover）
--     gK          函数签名帮助（normal 模式）
--     <C-k>       函数签名帮助（insert 模式）
--
--   代码操作
--     <leader>ca  代码动作（code action：快速修复、重构等）
--     <leader>cr  重命名符号（rename，全项目生效）
--     <leader>cf  格式化当前文件（format）
--
--   诊断导航
--     <leader>cd  弹出当前行诊断详情（float diagnostic）
--     ]d / [d     下一个 / 上一个诊断
--     ]e / [e     下一个 / 上一个错误（仅 ERROR 级别）
--
--   LSP 管理
--     <leader>li  显示 LSP 信息（:LspInfo）
--     <leader>lr  重启 LSP（:LspRestart）
-- ============================================================================

return {
  "mason-org/mason-lspconfig.nvim",

  -- 打开/新建文件时加载，确保 LSP 及时启动
  event = { "BufReadPre", "BufNewFile" },

  dependencies = {
    "mason-org/mason.nvim",      -- 工具安装器
    "neovim/nvim-lspconfig",     -- LSP 客户端配置
  },

  opts = {
    -- Mason 自动安装的 LSP 服务器列表（按字母排序）
    ensure_installed = {
      "bashls",                  -- Bash
      "clangd",                  -- C / C++
      "cssls",                   -- CSS
      "dockerls",                -- Dockerfile
      "eslint",                  -- JS/TS linting
      "gopls",                   -- Go
      "html",                    -- HTML
      "jsonls",                  -- JSON
      "lua_ls",                  -- Lua
      -- "nil_ls",               -- Nix（安装失败可先注释；需要时在 :Mason 里手动装）
      "pyright",                 -- Python
      "rust_analyzer",           -- Rust
      "svelte",                  -- Svelte
      "taplo",                   -- TOML
      "ts_ls",                   -- TypeScript / JavaScript
      "vue_ls",                  -- Vue (Volar)
      "yamlls",                  -- YAML
    },

    -- lspconfig 中配置了但不在上述列表的服务器也会自动安装
    automatic_installation = true,
  },

  config = function(_, opts)
    -- LSP 快捷键：仅在 buffer 级别生效，不污染普通文本文件
    local function apply_lsp_keymaps(_, bufnr)
      local map_opts = { buffer = bufnr, silent = true }

      -- 导航跳转
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", map_opts, { desc = "Goto Definition" }))
      vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", map_opts, { desc = "References" }))
      vim.keymap.set("n", "gI", vim.lsp.buf.implementation, vim.tbl_extend("force", map_opts, { desc = "Goto Implementation" }))
      vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, vim.tbl_extend("force", map_opts, { desc = "Goto Type Definition" }))
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", map_opts, { desc = "Goto Declaration" }))

      -- 文档与签名
      vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", map_opts, { desc = "Hover" }))
      vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, vim.tbl_extend("force", map_opts, { desc = "Signature Help" }))
      vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", map_opts, { desc = "Signature Help" }))

      -- 代码操作
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", map_opts, { desc = "Code Action" }))
      vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, vim.tbl_extend("force", map_opts, { desc = "Rename" }))
      vim.keymap.set("n", "<leader>cf", function()
        vim.lsp.buf.format({ async = true })
      end, vim.tbl_extend("force", map_opts, { desc = "Format" }))

      -- 诊断导航
      vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, vim.tbl_extend("force", map_opts, { desc = "Line Diagnostics" }))
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", map_opts, { desc = "Next Diagnostic" }))
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", map_opts, { desc = "Prev Diagnostic" }))
      vim.keymap.set("n", "]e", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, vim.tbl_extend("force", map_opts, { desc = "Next Error" }))
      vim.keymap.set("n", "[e", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, vim.tbl_extend("force", map_opts, { desc = "Prev Error" }))

      -- LSP 管理
      vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>", vim.tbl_extend("force", map_opts, { desc = "LSP Info" }))
      vim.keymap.set("n", "<leader>lr", "<cmd>LspRestart<cr>", vim.tbl_extend("force", map_opts, { desc = "LSP Restart" }))
    end

    require("mason-lspconfig").setup(opts)

    -- LSP 附加时自动绑定快捷键（augroup 防止热重载时重复注册）
    local augroup = vim.api.nvim_create_augroup("LspKeymaps", { clear = true })
    vim.api.nvim_create_autocmd("LspAttach", {
      group = augroup,
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client then
          apply_lsp_keymaps(client, args.buf)
        end
      end,
    })
  end,
}
