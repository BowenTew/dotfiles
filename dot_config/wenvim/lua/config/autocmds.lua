-- ============================================================================
-- 自动命令配置
-- ============================================================================

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local cmd = vim.api.nvim_create_user_command

-- 创建自动命令组
local general = augroup("General", { clear = true })
local highlight = augroup("Highlight", { clear = true })
local filetype = augroup("AeonFileType", { clear = true })
local terminal = augroup("Terminal", { clear = true })
local lsp = augroup("LSP", { clear = true })
local git = augroup("Git", { clear = true })

-- ============================================================================
-- 基础自动命令
-- ============================================================================

-- 高亮复制的内容
autocmd("TextYankPost", {
  group = highlight,
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
  desc = "Highlight on yank",
})

-- 回到上次编辑位置
autocmd("BufReadPost", {
  group = general,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = "Go to last loc when opening a buffer",
})

-- 关闭某些文件类型的行号
autocmd("FileType", {
  group = filetype,
  pattern = {
    "qf",
    "help",
    "man",
    "notify",
    "nofile",
    "lspinfo",
    "terminal",
    "prompt",
    "Trouble",
    "alpha",
    "dashboard",
  },
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
  end,
  desc = "Disable number and signcolumn for certain filetypes",
})

-- ============================================================================
-- 文件类型特定设置
-- ============================================================================

-- 自动设置缩进
autocmd("FileType", {
  group = filetype,
  pattern = {
    "c",
    "cpp",
    "java",
    "cs",
    "go",
    "rust",
    "python",
  },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
  end,
  desc = "Set 4 space indentation for certain languages",
})

-- Makefile 使用 tab
autocmd("FileType", {
  group = filetype,
  pattern = "make",
  callback = function()
    vim.opt_local.expandtab = false
  end,
  desc = "Use tabs in Makefiles",
})

-- 文本文件设置
autocmd("FileType", {
  group = filetype,
  pattern = { "text", "markdown", "txt" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
  end,
  desc = "Enable wrap and spell for text files",
})

-- JSON 文件格式化
autocmd("FileType", {
  group = filetype,
  pattern = "json",
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
  desc = "Disable concealing in JSON files",
})

-- ============================================================================
-- 终端设置
-- ============================================================================

autocmd("TermOpen", {
  group = terminal,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.cmd("startinsert")
  end,
  desc = "Terminal settings",
})

-- 离开终端时自动进入插入模式
autocmd("BufEnter", {
  group = terminal,
  pattern = "term://*",
  callback = function()
    vim.cmd("startinsert")
  end,
  desc = "Auto enter insert mode in terminal",
})

-- ============================================================================
-- 窗口和缓冲区管理
-- ============================================================================

-- 自动关闭某些窗口按 q
autocmd("FileType", {
  group = filetype,
  pattern = {
    "qf",
    "help",
    "man",
    "notify",
    "lspinfo",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "PlenaryTestPopup",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", {
      buffer = event.buf,
      silent = true,
      desc = "Close buffer",
    })
  end,
  desc = "Close certain windows with q",
})

-- 自动保存焦点缓冲区
autocmd({ "BufLeave", "FocusLost" }, {
  group = general,
  callback = function()
    if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
      vim.api.nvim_command("silent update")
    end
  end,
  desc = "Auto save when leaving buffer",
})

-- ============================================================================
-- LSP 相关
-- ============================================================================

-- 显示行内诊断
autocmd({ "CursorHold", "CursorHoldI" }, {
  group = lsp,
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
  end,
  desc = "Show diagnostics on cursor hold",
})

-- ============================================================================
-- Git 相关
-- ============================================================================

-- 在 gitcommit 中启用拼写检查
autocmd("FileType", {
  group = git,
  pattern = "gitcommit",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.wrap = true
  end,
  desc = "Enable spell check in git commits",
})

-- ============================================================================
-- 性能优化
-- ============================================================================

-- 大文件优化
autocmd("BufReadPre", {
  group = general,
  callback = function(args)
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(args.buf))
    if ok and stats and stats.size > 1024 * 1024 then -- 1MB
      vim.opt_local.foldmethod = "manual"
      vim.opt_local.undolevels = -1
      vim.b.large_file = true
      vim.notify("Large file detected, some features disabled", vim.log.levels.WARN)
    end
  end,
  desc = "Optimize for large files",
})

-- ============================================================================
-- 用户命令
-- ============================================================================

cmd("W", "w", { desc = "Save file (alias)" })
cmd("Wq", "wq", { desc = "Save and quit (alias)" })
cmd("WQ", "wq", { desc = "Save and quit (alias)" })
cmd("Q", "q", { desc = "Quit (alias)" })
cmd("Qa", "qa", { desc = "Quit all (alias)" })
cmd("QA", "qa", { desc = "Quit all (alias)" })

-- 删除当前文件
cmd("DeleteFile", function()
  local path = vim.api.nvim_buf_get_name(0)
  vim.fn.delete(path)
  vim.cmd("bdelete!")
  vim.notify("Deleted: " .. path, vim.log.levels.INFO)
end, { desc = "Delete current file" })

-- 复制当前文件路径
cmd("CopyPath", function()
  local path = vim.api.nvim_buf_get_name(0)
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path, vim.log.levels.INFO)
end, { desc = "Copy current file path" })

cmd("CopyRelativePath", function()
  local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":~:.")
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path, vim.log.levels.INFO)
end, { desc = "Copy current relative file path" })
