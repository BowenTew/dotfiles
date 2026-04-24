-- ============================================================================
-- 光标下单词高亮
-- 轻量级实现，无需额外插件
-- ============================================================================

local api = vim.api
local fn = vim.fn

local enabled = true
local highlight_group = "CursorWord"

-- 创建高亮组
api.nvim_set_hl(0, highlight_group, {
  underline = true,
  sp = "#7aa2f7",
})

-- 获取光标下的单词
local function get_cursor_word()
  local line = api.nvim_get_current_line()
  local col = fn.col(".")
  
  -- 找到单词边界
  local left = col
  while left > 1 and line:sub(left - 1, left - 1):match("[%w_]") do
    left = left - 1
  end
  
  local right = col
  while right < #line and line:sub(right + 1, right + 1):match("[%w_]") do
    right = right + 1
  end
  
  return line:sub(left, right)
end

-- 清除高亮
local function clear_highlight()
  local buf = api.nvim_get_current_buf()
  local ns = api.nvim_create_namespace("cursorword")
  api.nvim_buf_clear_namespace(buf, ns, 0, -1)
end

-- 高亮单词
local function highlight_word()
  if not enabled then
    return
  end
  
  clear_highlight()
  
  local word = get_cursor_word()
  if word == "" or #word < 2 then
    return
  end
  
  -- 忽略关键字
  local ignore_patterns = {
    "^if$", "^else$", "^for$", "^while$", "^return$",
    "^function$", "^local$", "^var$", "^let$", "^const$",
  }
  
  for _, pattern in ipairs(ignore_patterns) do
    if word:match(pattern) then
      return
    end
  end
  
  local buf = api.nvim_get_current_buf()
  local ns = api.nvim_create_namespace("cursorword")
  local cursor_line = fn.line(".") - 1
  
  -- 获取可见区域
  local top = fn.line("w0") - 1
  local bottom = fn.line("w$") - 1
  
  -- 在可见区域内搜索
  local lines = api.nvim_buf_get_lines(buf, top, bottom + 1, false)
  
  for i, line in ipairs(lines) do
    local line_num = top + i - 1
    if line_num ~= cursor_line then
      local col = 0
      while true do
        local start_col, end_col = line:find("%f[%w_]" .. word:gsub("(%W)", "%%%1") .. "%f[^%w_]", col + 1)
        if not start_col then
          break
        end
        api.nvim_buf_add_highlight(buf, ns, highlight_group, line_num, start_col - 1, end_col)
        col = end_col
      end
    end
  end
end

-- 自动命令
local group = api.nvim_create_augroup("CursorWord", { clear = true })

api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
  group = group,
  callback = function()
    highlight_word()
  end,
})

api.nvim_create_autocmd({ "BufLeave", "InsertEnter" }, {
  group = group,
  callback = function()
    clear_highlight()
  end,
})

-- 切换功能
function _G.toggle_cursorword()
  enabled = not enabled
  if not enabled then
    clear_highlight()
  else
    highlight_word()
  end
  vim.notify("Cursor word highlight: " .. (enabled and "enabled" or "disabled"), vim.log.levels.INFO)
end

-- 快捷键
vim.keymap.set("n", "<leader>uw", toggle_cursorword, { desc = "Toggle cursor word highlight" })
