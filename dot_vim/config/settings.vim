" 基础设置
set encoding=utf-8
set fileencoding=utf-8
set number
set relativenumber
set cursorline
set colorcolumn=80
set laststatus=2
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set hlsearch
set incsearch
set ignorecase
set smartcase
set clipboard=unnamedplus
set mouse=a
set hidden
set updatetime=100
set nobackup
set nowritebackup
set noswapfile
let mapleader=" "
let maplocalleader=" "

" ============================================
" Diff 优化配置 - 兼容系统 vim
" ============================================
set diffopt=filler,closeoff,vertical,context:5,iblank,iwhiteall

" 快速刷新 diff
nnoremap <leader>du :diffupdate<CR>
