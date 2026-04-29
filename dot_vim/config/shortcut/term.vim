" 底部水平分屏打开终端
nnoremap <leader>t :below terminal<CR>

" 右侧垂直分屏打开终端
nnoremap <leader>vt :vertical terminal<CR>

" Esc 退出终端模式（失焦）
tnoremap <C-\> <C-\><C-N>

" 终端模式下直接切换窗口
tnoremap <C-W>h <C-\><C-N><C-W>h
tnoremap <C-W>j <C-\><C-N><C-W>j
tnoremap <C-W>k <C-\><C-N><C-W>k
tnoremap <C-W>l <C-\><C-N><C-W>l
