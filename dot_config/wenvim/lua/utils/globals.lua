-- ============================================================================
-- 全局函数
-- ============================================================================

-- 打印表格内容 (调试用)
function _G.dump(...)
  local objects = vim.tbl_map(vim.inspect, { ... })
  print(table.unpack(objects))
  return ...
end

-- 重新加载模块
function _G.reload(module)
  package.loaded[module] = nil
  return require(module)
end

-- 检查模块是否存在
function _G.module_exists(module)
  local ok, _ = pcall(require, module)
  return ok
end

-- 获取当前视觉选择
function _G.get_visual_selection()
  local mode = vim.fn.mode()
  if mode ~= "v" and mode ~= "V" and mode ~= "\22" then
    return nil
  end
  
  local _, start_row, start_col, _ = table.unpack(vim.fn.getpos("'<"))
  local _, end_row, end_col, _ = table.unpack(vim.fn.getpos("'>"))
  
  if mode == "V" then
    start_col = 1
    end_col = #vim.fn.getline(end_row)
  end
  
  local lines = vim.fn.getline(start_row, end_row)
  if #lines == 0 then
    return nil
  end
  
  lines[1] = string.sub(lines[1], start_col)
  lines[#lines] = string.sub(lines[#lines], 1, end_col - start_col + 1)
  
  return table.concat(lines, "\n")
end

-- 切换快速修复列表
function _G.toggle_quickfix()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
    end
  end
  if qf_exists then
    vim.cmd("cclose")
  else
    vim.cmd("copen")
  end
end

-- 切换位置列表
function _G.toggle_loclist()
  local loc_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["loclist"] == 1 then
      loc_exists = true
    end
  end
  if loc_exists then
    vim.cmd("lclose")
  else
    vim.cmd("lopen")
  end
end

-- 创建浮动终端
function _G.float_term(cmd, opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)
  
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded",
  })
  
  vim.fn.termopen(cmd or vim.o.shell)
  vim.cmd("startinsert")
  
  -- 关闭时清理
  vim.api.nvim_create_autocmd("TermClose", {
    buffer = buf,
    callback = function()
      vim.api.nvim_win_close(win, true)
      vim.api.nvim_buf_delete(buf, { force = true })
    end,
  })
end

-- 安全的 require
function _G.safe_require(module)
  local ok, result = pcall(require, module)
  if ok then
    return result
  else
    vim.notify("Failed to load module: " .. module, vim.log.levels.WARN)
    return nil
  end
end
