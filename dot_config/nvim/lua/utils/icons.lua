-- ============================================================================
-- 图标配置
-- ============================================================================

local M = {}

M.kind = {
  Text = "󰉿",
  Method = "󰆧",
  Function = "󰊕",
  Constructor = "",
  Field = "󰜢",
  Variable = "󰀫",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "󰑭",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈙",
  Reference = "󰈇",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "󰙅",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "",
  Namespace = "",
  Package = "",
  String = "",
  Number = "",
  Boolean = "",
  Array = "",
  Object = "",
  Key = "",
  Null = "",
}

M.diagnostics = {
  Error = "",
  Warn = "",
  Hint = "󰌵",
  Info = "",
  Debug = "",
  Trace = "✎",
}

M.folder = {
  -- Nerd Font / nvim-web-devicons 风格的文件夹图标
  closed = "",      -- 关闭的文件夹
  open = "",        -- 打开的文件夹
  empty = "",       -- 空文件夹（关闭）
  empty_open = "",  -- 空文件夹（打开）
}

M.arrow = {
  right = ">",
  down = "v",
  left = "<",
}

M.ui = {
  check = "✓",
  close = "",
}

M.git = {
  added = "+",
  changed = "~",
  deleted = "- ",
  modified = "~",
  removed = "-",
  renamed = "➜",
  untracked = "✗",
  ignored = "◌",
  unstaged = "✗",
  staged = "✓",
  conflict = "",
  branch = "",
}

return M
