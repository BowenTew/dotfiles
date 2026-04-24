-- ============================================================================
-- nvim-lspconfig - LSP 核心配置
-- 提供语言服务器协议客户端配置
-- ============================================================================

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
  },
  opts = {
    -- 诊断配置
    diagnostics = {
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
      },
      severity_sort = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = AeonVim.icons.diagnostics.Error,
          [vim.diagnostic.severity.WARN] = AeonVim.icons.diagnostics.Warn,
          [vim.diagnostic.severity.HINT] = AeonVim.icons.diagnostics.Hint,
          [vim.diagnostic.severity.INFO] = AeonVim.icons.diagnostics.Info,
        },
      },
    },

    -- Inlay hints
    inlay_hints = {
      enabled = true,
    },

    -- 代码折叠
    folds = {
      enabled = true,
    },

    -- 格式化
    format = {
      formatting_options = nil,
      timeout_ms = nil,
    },

    -- 服务器配置（从 servers/ 目录加载）
    servers = require("config.lsp"),
  },

  config = function(_, opts)
    -- 诊断配置
    vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

    -- 全局服务器配置
    if opts.servers["*"] then
      vim.lsp.config("*", opts.servers["*"])
    end

    -- 配置并启用各服务器
    local enabled = {}
    for server, server_opts in pairs(opts.servers) do
      if server ~= "*" and server_opts ~= false then
        vim.lsp.config(server, server_opts)
        table.insert(enabled, server)
      end
    end
    vim.lsp.enable(enabled)

    -- Inlay hints
    if opts.inlay_hints.enabled then
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
          end
        end,
      })
    end

    -- 代码折叠
    if opts.folds.enabled then
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "v:lua.vim.lsp.foldexpr()"
      vim.opt.foldlevel = 99
    end
  end,
}
