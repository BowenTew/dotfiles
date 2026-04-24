-- ============================================================================
-- 工具函数
-- ============================================================================

local M = {}

-- 检查是否为空字符串
function M.is_empty(s)
  return s == nil or s == ""
end

-- 检查文件是否存在
function M.file_exists(path)
  local stat = vim.loop.fs_stat(path)
  return stat ~= nil and stat.type == "file"
end

-- 检查目录是否存在
function M.dir_exists(path)
  local stat = vim.loop.fs_stat(path)
  return stat ~= nil and stat.type == "directory"
end

-- 确保目录存在
function M.ensure_dir(path)
  if not M.dir_exists(path) then
    vim.fn.mkdir(path, "p")
  end
end

-- 获取当前缓冲区目录
function M.get_buffer_dir()
  local buf_name = vim.api.nvim_buf_get_name(0)
  if buf_name == "" then
    return vim.fn.getcwd()
  end
  return vim.fn.fnamemodify(buf_name, ":h")
end

-- 获取 git 根目录
function M.get_git_root()
  local dot_git_path = vim.fn.finddir(".git", ".;")
  if dot_git_path == "" then
    return nil
  end
  return vim.fn.fnamemodify(dot_git_path, ":h")
end

-- 检查是否在 git 仓库中
function M.is_git_repo()
  return M.get_git_root() ~= nil
end

-- 获取项目根目录
function M.get_project_root()
  local git_root = M.get_git_root()
  if git_root then
    return git_root
  end
  return vim.fn.getcwd()
end

-- 切换背景
function M.toggle_background()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
end

-- 切换透明背景
function M.toggle_transparency()
  local is_transparent = vim.g.transparent_enabled
  if is_transparent then
    vim.cmd("TransparentDisable")
  else
    vim.cmd("TransparentEnable")
  end
end

-- 格式化 JSON
function M.format_json()
  vim.cmd("%!jq .")
end

-- 压缩 JSON
function M.minify_json()
  vim.cmd("%!jq -c .")
end

-- 复制当前行到剪贴板
function M.copy_line()
  local line = vim.api.nvim_get_current_line()
  vim.fn.setreg("+", line)
  vim.notify("Copied to clipboard", vim.log.levels.INFO)
end

-- 复制文件内容到剪贴板
function M.copy_file_content()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local content = table.concat(lines, "\n")
  vim.fn.setreg("+", content)
  vim.notify("File content copied to clipboard", vim.log.levels.INFO)
end

-- 删除当前缓冲区且不关闭窗口
function M.delete_buffer_keep_window()
  local bufnr = vim.api.nvim_get_current_buf()
  local windows = vim.fn.win_findbuf(bufnr)
  
  -- 为每个窗口切换到替代缓冲区
  for _, win in ipairs(windows) do
    vim.api.nvim_win_call(win, function()
      vim.cmd("bprevious")
      -- 如果还在同一个缓冲区，创建新缓冲区
      if vim.api.nvim_win_get_buf(win) == bufnr then
        vim.cmd("enew")
      end
    end)
  end
  
  -- 删除原缓冲区
  vim.api.nvim_buf_delete(bufnr, { force = false })
end

-- 打开 URL
function M.open_url(url)
  if not url then
    url = vim.fn.expand("<cfile>")
  end
  
  local cmd
  if vim.fn.has("mac") == 1 then
    cmd = "open"
  elseif vim.fn.has("unix") == 1 then
    cmd = "xdg-open"
  elseif vim.fn.has("win32") == 1 then
    cmd = "start"
  end
  
  if cmd then
    vim.fn.jobstart({ cmd, url }, { detach = true })
  end
end

-- 搜索选中的文本
function M.search_selection()
  local text = vim.fn.getreg("v")
  if text and text ~= "" then
    vim.fn.setreg("/", text)
    vim.cmd("normal! n")
  end
end

-- 显示消息
function M.info(msg)
  vim.notify(msg, vim.log.levels.INFO)
end

function M.warn(msg)
  vim.notify(msg, vim.log.levels.WARN)
end

function M.error(msg)
  vim.notify(msg, vim.log.levels.ERROR)
end

return M
