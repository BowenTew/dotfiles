-- ============================================================================
-- 键位映射配置
-- 键位映射配置
-- ============================================================================

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader 键
vim.g.mapleader = AeonVim.keys.leader
vim.g.maplocalleader = AeonVim.keys.localleader

-- 基础映射函数
local function nmap(lhs, rhs, desc)
  map("n", lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
end

local function imap(lhs, rhs, desc)
  map("i", lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
end

local function vmap(lhs, rhs, desc)
  map("v", lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
end

local function tmap(lhs, rhs, desc)
  map("t", lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
end

-- ============================================================================
-- 基础操作
-- ============================================================================

-- 保存和退出
nmap("<C-s>", "<cmd>w<CR>", "Save file")
imap("<C-s>", "<cmd>w<CR><Esc>", "Save file")
nmap("<C-q>", "<cmd>q<CR>", "Quit")
nmap("<leader>q", "<cmd>confirm q<CR>", "Quit")
nmap("<leader>Q", "<cmd>confirm qall<CR>", "Quit all")

-- 取消高亮
nmap("<Esc>", "<cmd>nohlsearch<CR>", "Clear highlights")
nmap("<leader>h", "<cmd>nohlsearch<CR>", "Clear highlights")

-- 更好的 j/k 移动 (处理 wrap)
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- 快速移动
nmap("H", "^", "Go to start of line")
nmap("L", "$", "Go to end of line")
vmap("H", "^", "Go to start of line")
vmap("L", "$", "Go to end of line")

-- 缩进保持选择
vmap("<", "<gv", "Decrease indent")
vmap(">", ">gv", "Increase indent")

-- 移动行 (像 VS Code)
nmap("<A-j>", "<cmd>m .+1<CR>==", "Move line down")
nmap("<A-k>", "<cmd>m .-2<CR>==", "Move line up")
imap("<A-j>", "<Esc><cmd>m .+1<CR>==gi", "Move line down")
imap("<A-k>", "<Esc><cmd>m .-2<CR>==gi", "Move line up")
vmap("<A-j>", ":m '>+1<CR>gv=gv", "Move selection down")
vmap("<A-k>", ":m '<-2<CR>gv=gv", "Move selection up")

-- 复制到系统剪贴板
nmap("<leader>y", '"+y', "Copy to system clipboard")
vmap("<leader>y", '"+y', "Copy to system clipboard")
nmap("<leader>Y", '"+Y', "Copy line to system clipboard")

-- 粘贴不换行
nmap("<leader>p", '"0p', "Paste from yank register")
nmap("<leader>P", '"0P', "Paste from yank register before")

-- 黑洞删除 (不覆盖寄存器)
nmap("<leader>d", '"_d', "Delete to black hole")
vmap("<leader>d", '"_d', "Delete to black hole")
nmap("<leader>c", '"_c', "Change to black hole")
vmap("<leader>c", '"_c', "Change to black hole")

-- 快速退出插入模式
imap("jk", "<Esc>", "Exit insert mode")
imap("jj", "<Esc>", "Exit insert mode")

-- 在插入模式下移动
imap("<C-h>", "<Left>", "Move left")
imap("<C-l>", "<Right>", "Move right")
imap("<C-j>", "<Down>", "Move down")
imap("<C-k>", "<Up>", "Move up")

-- ============================================================================
-- 窗口导航 (类似 Tmux)
-- ============================================================================

-- 窗口切换
nmap("<C-h>", "<C-w>h", "Go to left window")
nmap("<C-j>", "<C-w>j", "Go to lower window")
nmap("<C-k>", "<C-w>k", "Go to upper window")
nmap("<C-l>", "<C-w>l", "Go to right window")

-- 终端模式窗口切换
tmap("<C-h>", "<cmd>wincmd h<CR>", "Go to left window")
tmap("<C-j>", "<cmd>wincmd j<CR>", "Go to lower window")
tmap("<C-k>", "<cmd>wincmd k<CR>", "Go to upper window")
tmap("<C-l>", "<cmd>wincmd l<CR>", "Go to right window")

-- 窗口调整大小
nmap("<C-Up>", "<cmd>resize +2<CR>", "Increase window height")
nmap("<C-Down>", "<cmd>resize -2<CR>", "Decrease window height")
nmap("<C-Left>", "<cmd>vertical resize -2<CR>", "Decrease window width")
nmap("<C-Right>", "<cmd>vertical resize +2<CR>", "Increase window width")

-- 窗口分割
nmap("<leader>-", "<C-w>s", "Split below")
nmap("<leader>|", "<C-w>v", "Split right")
nmap("<leader>se", "<C-w>=", "Equal window size")
nmap("<leader>xs", "<cmd>close<CR>", "Close split")

-- 标签页
nmap("<leader>tx", "<cmd>tabclose<CR>", "Close tab")
nmap("<leader>tn", "<cmd>tabnext<CR>", "Next tab")
nmap("<leader>tp", "<cmd>tabprevious<CR>", "Previous tab")

-- ============================================================================
-- 快速修复和位置列表
-- ============================================================================

nmap("[q", "<cmd>cprev<CR>", "Previous quickfix")
nmap("]q", "<cmd>cnext<CR>", "Next quickfix")
nmap("[l", "<cmd>lprev<CR>", "Previous location")
nmap("]l", "<cmd>lnext<CR>", "Next location")

-- ============================================================================
-- 诊断导航
-- ============================================================================

nmap("]d", function()
  vim.diagnostic.jump({ count = 1 })
end, "Next diagnostic")

nmap("[d", function()
  vim.diagnostic.jump({ count = -1 })
end, "Previous diagnostic")

nmap("]e", function()
  vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
end, "Next error")

nmap("[e", function()
  vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
end, "Previous error")

nmap("]w", function()
  vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.WARN })
end, "Next warning")

nmap("[w", function()
  vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.WARN })
end, "Previous warning")

-- ============================================================================
-- 搜索和替换
-- ============================================================================

-- 可视模式下搜索选中的文本
vmap("//", 'y/<C-R>"<CR>', "Search selection")

-- 替换当前单词
nmap("<leader>sr", [[:%s/<C-r><C-w>//g<Left><Left>]], "Replace current word")

-- ============================================================================
-- 其他实用键位
-- ============================================================================

-- 重新加载配置
nmap("<leader>rr", "<cmd>source %<CR>", "Reload current file")
nmap("<leader>rl", "<cmd>luafile %<CR>", "Reload Lua file")

-- 打开 URL
nmap("gx", function()
  local url = vim.fn.expand("<cfile>")
  vim.fn.jobstart({ "open", url }, { detach = true })
end, "Open URL under cursor")

-- 保持光标位置当使用 J
nmap("J", "mzJ`z", "Join lines (keep cursor)")

-- 滚动时保持光标居中
nmap("<C-d>", "<C-d>zz", "Scroll down (center)")
nmap("<C-u>", "<C-u>zz", "Scroll up (center)")
nmap("n", "nzzzv", "Next search (center)")
nmap("N", "Nzzzv", "Previous search (center)")

-- 打开 URL（跨平台）
nmap("gx", function()
  local url = vim.fn.expand("<cfile>")
  if not url or url == "" then
    return
  end

  local cmd
  if vim.fn.has("macunix") == 1 then
    cmd = { "open", url }
  elseif vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
    cmd = { "cmd", "/c", "start", url }
  else
    cmd = { "xdg-open", url }
  end

  vim.fn.jobstart(cmd, { detach = true })
end, "Open URL under cursor")

