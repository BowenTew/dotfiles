" ============================================
" Go 开发环境配置 (vim-go + coc-go)
" 目标: 保留核心能力，并消除与全局快捷键冲突
" ============================================

" --------------------------------------------
" vim-go 基础配置
" --------------------------------------------
let g:go_code_completion_enabled = 0
let g:go_fmt_autosave = 0
let g:go_imports_autosave = 0

" 使用 gopls
let g:go_gopls_enabled = 1
let g:go_def_mode = 'gopls'
let g:go_info_mode = 'gopls'

" Go 语法增强高亮
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1

" 折叠
let g:go_fold_enable = ['block', 'import', 'varconst', 'package_comment']

" --------------------------------------------
" Go 文件行为（非快捷键）
" --------------------------------------------
augroup GoCore
  autocmd!
  autocmd FileType go setlocal foldmethod=syntax
  autocmd FileType go setlocal foldlevel=99
  autocmd BufWritePre *.go silent! call CocAction('runCommand', 'editor.action.organizeImport')
  autocmd BufWritePre *.go silent! call CocAction('format')
augroup END

" --------------------------------------------
" 常用命令
" --------------------------------------------
command! GoVersion echo system('go version')
command! GoInstallBinaries :GoInstallBinaries
command! GoUpdateBinaries :GoUpdateBinaries
command! GoPlay !curl -s https://play.golang.org/share -d body=@% | xargs -I {} echo https://play.golang.org/p/{}
