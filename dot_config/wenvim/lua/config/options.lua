-- ============================================================================
-- 基础选项配置
-- 选项配置
-- ============================================================================

local opt = vim.opt
local g = vim.g

-- 编码
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.fileencodings = "utf-8,gbk,gb2312,gb18030,ucs-bom,cp936"

-- 行号
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2

-- 缩进
opt.expandtab = true      -- 使用空格代替 tab
opt.shiftwidth = 2        -- 自动缩进宽度
opt.tabstop = 2           -- Tab 显示宽度
opt.softtabstop = 2       -- Tab 操作宽度
opt.smartindent = true    -- 智能缩进
opt.autoindent = true     -- 自动继承缩进

-- 搜索
opt.ignorecase = true     -- 忽略大小写
opt.smartcase = true      -- 智能大小写
opt.hlsearch = true       -- 高亮搜索
opt.incsearch = true      -- 增量搜索

-- 外观
opt.termguicolors = true  -- 真彩色
opt.cursorline = true     -- 高亮当前行
opt.colorcolumn = "120"   -- 行长度提示
opt.laststatus = 3        -- 全局状态栏
opt.showmode = false      -- 不显示模式 (由状态栏处理)
opt.cmdheight = 0         -- 命令行高度
opt.pumheight = 10        -- 补全菜单高度
opt.pumblend = 10         -- 补全菜单透明度
opt.winblend = 0          -- 浮动窗口透明度
opt.conceallevel = 0      -- 显示隐藏字符
opt.signcolumn = "yes"    -- 始终显示标记列
opt.fillchars = {
  fold = " ",
  foldopen = "",
  foldclose = "",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

-- 折叠
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- 滚动
opt.scrolloff = 8         -- 上下滚动保留行数
opt.sidescrolloff = 8     -- 左右滚动保留列数
opt.wrap = false          -- 不自动换行
opt.linebreak = true      -- 软换行
opt.breakindent = true    -- 换行保持缩进

-- 性能
opt.updatetime = 200      -- 更新时间 (LSP 诊断等)
opt.timeoutlen = 500      -- 键位超时
opt.ttimeoutlen = 10      -- 终端键位超时
opt.redrawtime = 1000     -- 重绘时间限制
opt.lazyredraw = false    -- 不重绘时延迟 (会导致闪烁)

-- 文件
opt.backup = false        -- 不创建备份
opt.writebackup = false   -- 不创建写入备份
opt.swapfile = false      -- 不创建交换文件
opt.undofile = true       -- 启用持久化撤销
opt.undolevels = 10000    -- 撤销层级
opt.confirm = true        -- 未保存时确认
opt.autoread = true       -- 自动重新加载外部修改

-- 分割
opt.splitbelow = true     -- 下方分割
opt.splitright = true     -- 右侧分割
opt.splitkeep = "screen"  -- 保持屏幕稳定

-- 补全
opt.completeopt = { "menu", "menuone", "noselect", "preview" }
opt.wildmenu = true
opt.wildmode = "longest:full,full"
opt.wildoptions = "pum"

-- 列表字符
opt.list = true
opt.listchars = {
  tab = "» ",
  trail = "·",
  nbsp = "␣",
  extends = "⟩",
  precedes = "⟨",
}

-- 禁用内置插件 (加速启动)
g.loaded_gzip = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_matchit = 1
g.loaded_matchparen = 1
g.loaded_2html_plugin = 1
g.loaded_logiPat = 1
g.loaded_rrhelper = 1
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1
g.loaded_netrwFileHandlers = 1

-- 禁用 providers (如果没有安装)
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0
g.loaded_node_provider = 0

-- 剪贴板
opt.clipboard = "unnamedplus"  -- 使用系统剪贴板

-- 会话选项
opt.sessionoptions = {
  "buffers",
  "curdir",
  "folds",
  "help",
  "tabpages",
  "winsize",
  "winpos",
  "terminal",
  "localoptions",
}

-- 差异模式
opt.diffopt = {
  "internal",
  "filler",
  "closeoff",
  "context:12",
  "algorithm:histogram",
  "linematch:200",
  "indent-heuristic",
}
