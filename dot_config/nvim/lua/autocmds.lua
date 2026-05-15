require "nvchad.autocmds"

-- ============================================================================
-- 自定义 autocmd
-- ============================================================================

local autocmd = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup("UserAutocmds", { clear = true })

-- ---------- 语言缩进 ----------
-- 4 空格缩进：C/C++/Java/C#/Go/Rust/Python
autocmd("FileType", {
  group = group,
  pattern = { "c", "cpp", "java", "cs", "go", "rust", "python" },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
  end,
})

-- Makefile 必须用 Tab
autocmd("FileType", {
  group = group,
  pattern = "make",
  callback = function()
    vim.opt_local.expandtab = false
  end,
})

-- 文本类启用 wrap / linebreak / spell
autocmd("FileType", {
  group = group,
  pattern = { "text", "markdown", "txt" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
  end,
})

-- gitcommit 启用拼写检查 + 自动换行
autocmd("FileType", {
  group = group,
  pattern = "gitcommit",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.wrap = true
  end,
})

-- ---------- 体验增强 ----------

-- yank 后高亮选区 200ms（复制反馈）
autocmd("TextYankPost", {
  group = group,
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

-- 打开文件时跳回上次编辑位置（跳过 commit / rebase 等特殊 buffer）
autocmd("BufReadPost", {
  group = group,
  callback = function(args)
    local exclude = { "gitcommit", "gitrebase", "hgcommit" }
    local buf = args.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc then
      return
    end
    vim.b[buf].last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- 光标停留时自动弹诊断浮窗（配合 updatetime=200）
autocmd({ "CursorHold", "CursorHoldI" }, {
  group = group,
  callback = function()
    vim.diagnostic.open_float(nil, {
      focus = false,
      scope = "cursor",
      border = "rounded",
    })
  end,
})

-- ---------- 路径复制命令 ----------
vim.api.nvim_create_user_command("CopyPath", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path, vim.log.levels.INFO)
end, { desc = "Copy absolute path of current file" })

vim.api.nvim_create_user_command("CopyRelativePath", function()
  local path = vim.fn.expand("%:.")
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path, vim.log.levels.INFO)
end, { desc = "Copy relative path of current file" })
