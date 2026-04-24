-- ============================================================================
-- nvim-lint - 代码检查
-- 比 none-ls 更轻量，专注于 linting
-- ============================================================================

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    linters_by_ft = {
      lua = { "luacheck" },
      -- python = { "pyright" },
      javascript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescript = { "eslint_d" },
      typescriptreact = { "eslint_d" },
    },
  },
  config = function(_, opts)
    local lint = require "lint"
    lint.linters_by_ft = opts.linters_by_ft

    -- linter 需要的配置文件，找不到则跳过该 linter
    local linter_configs = {
      eslint_d = {
        ".eslintrc",
        ".eslintrc.js",
        ".eslintrc.cjs",
        ".eslintrc.json",
        ".eslintrc.yml",
        ".eslintrc.yaml",
        "eslint.config.js",
        "eslint.config.mjs",
        "eslint.config.cjs",
      },
      luacheck = { ".luacheckrc" },
    }

    --- 检查项目中是否存在 linter 所需的配置文件
    local function has_config(linter_name)
      local configs = linter_configs[linter_name]
      if not configs then return true end -- 没有定义配置要求的 linter 默认放行
      local root = vim.fn.getcwd()
      for _, name in ipairs(configs) do
        if vim.uv.fs_stat(root .. "/" .. name) then return true end
      end
      return false
    end

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
      callback = function()
        local ft = vim.bo.filetype
        if not lint.linters_by_ft[ft] then return end

        -- 只保留项目中有配置文件的 linter
        local active = vim.tbl_filter(has_config, lint.linters_by_ft[ft])
        if #active == 0 then return end
        lint.try_lint(active)
      end,
    })
  end,
}
