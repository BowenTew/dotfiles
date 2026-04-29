" --------------------------------------------
" vim-gitgutter 配置（侧边栏标记 + 行内预览）
" --------------------------------------------

" 始终显示符号列（避免抖动）
set signcolumn=yes

" 高亮设置
let g:gitgutter_highlight_lines = 0
let g:gitgutter_highlight_linenrs = 1

" 符号样式（类似 VSCode）
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_removed_above_and_below = '{'
let g:gitgutter_sign_modified_removed = '~'

" 预览窗口样式
let g:gitgutter_preview_win_floating = 1
let g:gitgutter_close_preview_on_escape = 1

highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22 gui=none guifg=#98c379 guibg=#3c4c3c
highlight DiffChange cterm=bold ctermfg=11 ctermbg=24 gui=none guifg=#e5c07b guibg=#4c4c3c
highlight DiffDelete cterm=bold ctermfg=9  ctermbg=52 gui=none guifg=#e06c75 guibg=#4c3c3c
