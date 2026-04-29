" Go 快捷键（仅 Go buffer 生效）
augroup GoShortcut
  autocmd!

  " 编译 / 运行 / 测试
  autocmd FileType go nnoremap <buffer> <leader>gb :GoBuild<CR>
  autocmd FileType go nnoremap <buffer> <leader>gi :GoInstall<CR>
  autocmd FileType go nnoremap <buffer> <leader>gR :GoRun<CR>
  autocmd FileType go nnoremap <buffer> <leader>gt :GoTest<CR>
  autocmd FileType go nnoremap <buffer> <leader>gT :GoTestFunc<CR>
  autocmd FileType go nnoremap <buffer> <leader>gc :GoCoverage<CR>
  autocmd FileType go nnoremap <buffer> <leader>gC :GoCoverageClear<CR>

  " 跳转 / 文档 / 分析
  autocmd FileType go nnoremap <buffer> <leader>gdd :GoDef<CR>
  autocmd FileType go nnoremap <buffer> <leader>gds :GoDefStack<CR>
  autocmd FileType go nnoremap <buffer> <leader>gD :GoDoc<CR>
  autocmd FileType go nnoremap <buffer> <leader>gB :GoDocBrowser<CR>
  autocmd FileType go nnoremap <buffer> <leader>gle :GoLint<CR>
  autocmd FileType go nnoremap <buffer> <leader>gv :GoVet<CR>
  autocmd FileType go nnoremap <buffer> <leader>gI :GoInfo<CR>
  autocmd FileType go nnoremap <buffer> <leader>gim :GoImplements<CR>
  autocmd FileType go nnoremap <buffer> <leader>gcb :GoCallees<CR>
  autocmd FileType go nnoremap <buffer> <leader>gcr :GoCallers<CR>
  autocmd FileType go nnoremap <buffer> <leader>grf :GoReferrers<CR>

  " 重构 / 标签 / 生成
  autocmd FileType go nnoremap <buffer> <leader>gn :GoRename<CR>
  autocmd FileType go nnoremap <buffer> <leader>gat :GoAddTags<CR>
  autocmd FileType go nnoremap <buffer> <leader>grt :GoRemoveTags<CR>
  autocmd FileType go nnoremap <buffer> <leader>gaj :GoAddTags json<CR>
  autocmd FileType go nnoremap <buffer> <leader>gay :GoAddTags yaml<CR>
  autocmd FileType go nnoremap <buffer> <leader>gad :GoAddTags db<CR>
  autocmd FileType go nnoremap <buffer> <leader>gg :GoGenerate<CR>
  autocmd FileType go nnoremap <buffer> <leader>gfs :GoFillStruct<CR>
  autocmd FileType go nnoremap <buffer> <leader>gif :GoIfErr<CR>
  autocmd FileType go nnoremap <buffer> <leader>ga :GoAlternate<CR>
  autocmd FileType go nnoremap <buffer> <leader>gml :GoMetaLinter<CR>

  " 调试 (Delve)
  autocmd FileType go nnoremap <buffer> <leader>db :GoDebugStart<CR>
  autocmd FileType go nnoremap <buffer> <leader>ds :GoDebugStop<CR>
  autocmd FileType go nnoremap <buffer> <leader>dc :GoDebugContinue<CR>
  autocmd FileType go nnoremap <buffer> <leader>dn :GoDebugNext<CR>
  autocmd FileType go nnoremap <buffer> <leader>di :GoDebugStep<CR>
  autocmd FileType go nnoremap <buffer> <leader>dO :GoDebugStepOut<CR>
  autocmd FileType go nnoremap <buffer> <leader>dbb :GoDebugBreakpoint<CR>
  autocmd FileType go nnoremap <buffer> <leader>dB :GoDebugClearBreakpoint<CR>

  " coc-go 互补
  autocmd FileType go nnoremap <buffer> <leader>gf :call CocAction('format')<CR>
  autocmd FileType go nnoremap <buffer> <leader>gio :call CocAction('runCommand', 'editor.action.organizeImport')<CR>
  autocmd FileType go nnoremap <buffer> <leader>ca <Plug>(coc-codeaction)
  autocmd FileType go nnoremap <buffer> <leader>cac <Plug>(coc-codeaction-cursor)
  autocmd FileType go nnoremap <buffer> <leader>gxf :call CocAction('runCommand', 'go.refactor.extract.function')<CR>
  autocmd FileType go nnoremap <buffer> <leader>gxv :call CocAction('runCommand', 'go.refactor.extract.variable')<CR>
  autocmd FileType go nnoremap <buffer> <leader>ttf :call CocAction('runCommand', 'go.test.generate.function')<CR>
  autocmd FileType go nnoremap <buffer> <leader>ttg :call CocAction('runCommand', 'go.test.function')<CR>
  autocmd FileType go nnoremap <buffer> <leader>ttp :call CocAction('runCommand', 'go.test.package')<CR>

  " 代码片段
  autocmd FileType go inoremap <buffer> <C-e>err if err != nil {<CR>return err<CR>}<CR><ESC>O
  autocmd FileType go inoremap <buffer> <C-e>main func main() {<CR>}<CR><ESC>O
  autocmd FileType go inoremap <buffer> <C-e>for for _, v := range  {<CR>}<ESC>k$f{a
  autocmd FileType go inoremap <buffer> <C-e>go go func() {<CR>}()<CR><ESC>kO
  autocmd FileType go inoremap <buffer> <C-e>type type  struct {<CR>}<CR><ESC>2k$2ba
  autocmd FileType go inoremap <buffer> <C-e>inter type  interface {<CR>}<CR><ESC>2k$2ba

  " 其他 Go 快捷键
  autocmd FileType go nnoremap <buffer> <leader>gatf :call GoToTestFile()<CR>
  autocmd FileType go nnoremap <buffer> <leader>gm :e go.mod<CR>
augroup END

function! GoToTestFile()
  let l:current = expand('%:t')
  if l:current =~ '_test\.go$'
    let l:source = substitute(l:current, '_test\.go$', '.go', '')
    execute 'edit ' . fnameescape(l:source)
  else
    let l:test = substitute(l:current, '\.go$', '_test.go', '')
    if filereadable(l:test)
      execute 'edit ' . fnameescape(l:test)
    else
      execute 'edit ' . fnameescape(l:test)
      let l:pkg = go#package#ImportPath(expand('%:p:h'))
      call setline(1, 'package ' . l:pkg)
      normal! Go
    endif
  endif
endfunction
