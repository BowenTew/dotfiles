" workspace diff stage
nnoremap <leader>gd :Gvdiffsplit<CR>
"
nnoremap <leader>gs :Git diff --cached<CR>


" 撤销当前文件修改
nnoremap <leader>gr :Gread<CR>
" 提交当前文件修改到暂存
nnoremap <leader>gw :Gwrite<CR>


" 查看当前 hunk 的详细改动
nnoremap <leader>ghb :Git blame<CR>
" 预览当前 hunk（类似 VSCode 点击行看修改）
nnoremap <leader>ghp :GitGutterPreviewHunk<CR>
" 暂存当前 hunk（类似 VSCode 的 + 按钮）
nnoremap <leader>ghs :GitGutterStageHunk<CR>
" 撤销当前 hunk（类似 VSCode 的撤销）
nnoremap <leader>ghr :GitGutterUndoHunk<CR>
"列出本项目所有改动点到 Quickfix 窗口（适合全局审阅代码）
nnoremap <leader>ghl :GitGutterQuickFix<CR>:copen<CR>

" 查看下一个diff的hunk
nmap ]c <Plug>(GitGutterNextHunk)
" 查看上一个diff的hunk
nmap [c <Plug>(GitGutterPrevHunk)

" 处理conflict，使用目标分支
nnoremap <leader>do :diffget //2<CR>:diffupdate<CR>
" 处理conflict，使用本地分支
nnoremap <leader>dp :diffget //3<CR>:diffupdate<CR>
" 关闭 diff 视图
noremap <leader>dqd :diffoff!<CR>:q<CR>

nnoremap <leader>gcl :Gclog -- %<CR>
