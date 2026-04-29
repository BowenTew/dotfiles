" ============================================
" 注释快捷键配置 (vim-commentary)
" ============================================

" 行注释 - 空格+c+c (类似 VSCode 的 Cmd+/)
nnoremap <leader>cc :Commentary<CR>
vnoremap <leader>cc :Commentary<CR>

" 快速注释当前行 (按两次空格+c)
nnoremap <leader>c :Commentary<CR>

" 可视模式下直接按 c 注释
vnoremap <silent> c :Commentary<CR>gv

" 整行注释 (gcc 是 vim-commentary 原生支持的)
" 这里添加更直观的映射
nnoremap gcc :Commentary<CR>
nnoremap gcu :Commentary<CR>
