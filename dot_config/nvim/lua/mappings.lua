require "nvchad.mappings"

local map = vim.keymap.set

-- ---------- NvChad starter 原有 ----------
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- ---------- 交换 nvim-tree 默认键 ----------
-- NvChad 默认：<C-n> toggle, <leader>e focus
-- 用户偏好：<leader>e toggle, <C-n> focus
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map("n", "<C-n>", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

-- ---------- LSP 最小集（在 NvChad 默认 gd/gD/<leader>ra 之外补足） ----------
-- 取消 NvChad 默认绑定的 D=类型定义（会覆盖原生 D=删到行末）
pcall(vim.keymap.del, "n", "D")

local lsp_group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
  group = lsp_group,
  callback = function(args)
    local o = { buffer = args.buf, silent = true }
    map("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", o, { desc = "LSP Hover" }))
    map("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", o, { desc = "LSP Code Action" }))
    map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end,
      vim.tbl_extend("force", o, { desc = "Next Diagnostic" }))
    map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end,
      vim.tbl_extend("force", o, { desc = "Prev Diagnostic" }))

    local function toggle_signature()
      local ok, sig = pcall(require, "lsp_signature")
      if ok then
        sig.toggle_float_win()
      else
        vim.lsp.buf.signature_help()
      end
    end
    map("n", "<leader>gs", toggle_signature,
      vim.tbl_extend("force", o, { desc = "LSP Signature help (toggle)" }))
  end,
})
map("n", "<leader>ih", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle Inlay Hints" })
-- ---------- 移动 & 编辑（VSCode 风格） ----------
-- 处理 wrap：j/k 按视觉行
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- 行首/行尾
map({ "n", "x" }, "H", "^", { desc = "Go to start of line" })
map({ "n", "x" }, "L", "$", { desc = "Go to end of line" })

-- 缩进保持选区
map("x", "<", "<gv", { desc = "Decrease indent" })
map("x", ">", ">gv", { desc = "Increase indent" })

-- 行移动（Alt+J/K）
map("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "Move line up" })
map("i", "<A-j>", "<Esc><cmd>m .+1<CR>==gi", { desc = "Move line down" })
map("i", "<A-k>", "<Esc><cmd>m .-2<CR>==gi", { desc = "Move line up" })
map("x", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("x", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- 滚动 & 搜索 居中
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down (center)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up (center)" })
map("n", "n", "nzzzv", { desc = "Next search (center)" })
map("n", "N", "Nzzzv", { desc = "Prev search (center)" })

-- Join 保持光标
map("n", "J", "mzJ`z", { desc = "Join lines (keep cursor)" })

-- ---------- 寄存器：系统剪贴板 / 黑洞 ----------
map({ "n", "x" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map("n", "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })
map({ "n", "x" }, "<leader>d", '"_d', { desc = "Delete to black hole" })
map({ "n", "x" }, "<leader>c", '"_c', { desc = "Change to black hole" })
map("n", "<leader>p", '"0p', { desc = "Paste from yank register" })
map("n", "<leader>P", '"0P', { desc = "Paste from yank register (before)" })

-- ---------- 其他实用 ----------
map("n", "<leader>q", "<cmd>confirm q<CR>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>confirm qall<CR>", { desc = "Quit all" })
map("n", "<leader>sr", [[:%s/<C-r><C-w>//g<Left><Left>]], { desc = "Replace current word" })
map("x", "//", 'y/<C-R>"<CR>', { desc = "Search selection" })

-- ---------- Quickfix / Location list ----------
map("n", "[q", "<cmd>cprev<CR>", { desc = "Previous quickfix" })
map("n", "]q", "<cmd>cnext<CR>", { desc = "Next quickfix" })
map("n", "[l", "<cmd>lprev<CR>", { desc = "Previous location" })
map("n", "]l", "<cmd>lnext<CR>", { desc = "Next location" })
