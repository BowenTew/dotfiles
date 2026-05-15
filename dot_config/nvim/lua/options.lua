require "nvchad.options"

-- ============================================================================
-- 用户自定义 options
-- ============================================================================

local o = vim.opt

-- ---------- cmdline 补全（:Tab 走 popup 菜单） ----------
o.wildmode = "longest:full,full"  -- 先补到最长前缀，再展示完整列表
o.wildoptions = "pum"             -- popup menu 而非传统横条
o.pumheight = 10                  -- 补全菜单高度上限
o.pumblend = 10                   -- 补全菜单半透明（0=不透明，100=全透）

-- ---------- 编辑体验微调 ----------
o.undofile = true                 -- 持久化 undo：关 vim 重开还能 u 回去
o.undolevels = 10000              -- undo 历史上限
o.scrolloff = 8                   -- 光标距屏幕顶底至少 8 行
o.sidescrolloff = 8               -- 光标距屏幕左右至少 8 列
o.updatetime = 200                -- LSP 诊断浮窗触发更快（默认 4000ms）
o.confirm = true                  -- :q 未保存时弹确认而非报错
o.colorcolumn = "120"             -- 120 字符警示线
