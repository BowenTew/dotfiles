-- ============================================================================
-- Neovim Aeon Config
-- 模块化 Neovim 配置
-- ============================================================================

-- 启动性能优化
vim.loader.enable()

-- 加载核心模块
local function load_module(name)
  local ok, err = pcall(require, name)
  if not ok then
    vim.notify("Failed to load module: " .. name .. "\n" .. err, vim.log.levels.ERROR)
  end
end

-- 按顺序加载
local modules = {
  "config.global",
  "utils.globals",        -- 全局函数
  "utils.functions",      -- 工具函数
  "config.options",       -- 基础选项
  "config.keymaps",       -- 基础键位
  "config.autocmds",      -- 自动命令
  "config.lazy",          -- 插件管理器
}

for _, mod in ipairs(modules) do
  load_module(mod)
end

-- 异步加载非关键模块
vim.defer_fn(function()
  load_module("internal.cursorword")  -- 光标下单词高亮
end, 100)

-- 设置配色方案
local function setup_colorscheme()
  local colorscheme = AeonVim.colorscheme
  local ok, _ = pcall(vim.cmd.colorscheme, colorscheme)
  if not ok then
    vim.notify("Colorscheme not found: " .. colorscheme, vim.log.levels.WARN)
    vim.cmd.colorscheme("habamax")  -- 回退方案
  end
end

setup_colorscheme()

vim.notify("AeonVim loaded successfully! v" .. AeonVim.version, vim.log.levels.INFO)
