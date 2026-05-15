-- ============================================================================
-- nvim-hlslens - 更好的增量搜索
-- 高亮搜索匹配，显示匹配数量
-- ============================================================================

return {
  "kevinhwang91/nvim-hlslens",
  event = "BufReadPost",
  config = function()
    require("hlslens").setup({
      calm_down = true,
      nearest_only = true,
    })

    local kopts = { noremap = true, silent = true }
    vim.api.nvim_set_keymap("n", "n", [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)
    vim.api.nvim_set_keymap("n", "N", [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)
    vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
    vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
    vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
    vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
  end,
}
