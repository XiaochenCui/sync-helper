" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" async syntax checking plugin for Vim
"""""""""""""""""""""""""""""""""""""""""""""
"           personal plugin start           "
"""""""""""""""""""""""""""""""""""""""""""""
" async syntax checking plugin for Vim
Plug 'w0rp/ale'

" Highlights trailing whitespace in red and provides
Plug 'bronson/vim-trailing-whitespace'

" multiple selections
Plug 'terryma/vim-multiple-cursors'

" Colorthemes
Plug 'altercation/vim-colors-solarized'
Plug 'jnurmine/Zenburn'
Plug 'flazz/vim-colorschemes'

" best auto complete tool I have ever used(jedi, supertab...)
Plug 'Valloric/YouCompleteMe'

" tree explore plugin
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" show venv、git branch、file
" Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" enhance za
Plug 'tmhedberg/SimpylFold'

" super search
Plug 'kien/ctrlp.vim'
" a vim plug-in which provides support for expanding abbreviations similar to emmet.
Plug 'mattn/emmet-vim'

" Syntaxes
Plug 'othree/html5.vim'
Plug 'fatih/vim-go'
Plug 'hynek/vim-python-pep8-indent'
Plug 'elzr/vim-json'
Plug 'dyng/ctrlsf.vim'
Plug 'kylef/apiblueprint.vim'

" A Git wrapper so awesome
Plug 'tpope/vim-fugitive'
" A Vim plugin which shows a git diff in the gutter (sign column) and stages/undoes hunks.
Plug 'airblade/vim-gitgutter'

" Chinese typesetting
Plug 'hotoo/pangu.vim'

" a git wrapper
Plug 'tpope/vim-fugitive'

" create cscope database and connect to existing proper database automatically.
Plug 'vim-scripts/cscope.vim'

" code comment
Plug 'scrooloose/nerdcommenter'

" quotes plugin
Plug 'jiangmiao/auto-pairs'

" rainbow parentheses
Plug 'luochen1990/rainbow', { 'for': ['scheme', 'python', 'go', 'c'] }

" function list
Plug 'majutsushi/tagbar'

Plug 'stamblerre/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh'  }

" 🌷 Distraction-free writing in Vim
Plug 'junegunn/goyo.vim'

" Initialize plugin system
call plug#end()
filetype plugin indent on
syntax enable
syntax on

" When vimrc is edited, reload it
"autocmd! BufWritePost ~/.vimrc source ~/.vimrc

set nocompatible
set backspace=indent,eol,start
set encoding=utf-8
set fencs=utf-8,gb2312,gbk     " Sets the default encoding
set nu
set hlsearch
set incsearch

" toggle line number and vim-gitgutter
map <silent> <F2> :set number! \| GitGutterToggle<cR>
let g:gitgutter_max_signs = 500  " default value
map <F8> :Glog<cR>
map <F9> :cprev<cR>
map <F10> :cnext<cR>

" toggle paste
set pastetoggle=<F3>

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" auto clear whitespace
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * call <SID>StripTrailingWhitespaces()

" syntastic
let &runtimepath.=',~/.vim/plugged/ale'
let g:ale_sign_column_always = 0 " 一般需要实时检查，默认关闭
let g:ale_lint_on_save = 1 " save file auto check
let g:ale_lint_on_text_changed = 0 " for ale_lint_on_save = 1
let g:ale_lint_on_enter = 0 " for ale_lint_on_save = 1
map <F6> :ALEToggle \| echo 'g:ale_enabled =' g:ale_enabled<CR>
let g:ale_echo_msg_error_str = 'Error'
let g:ale_echo_msg_warning_str = 'Warning'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" YouCompleteMe settings
let g:ycm_collect_identifiers_from_comments_and_strings = 0
" 输入第0个字符开始补全
let g:ycm_min_num_of_chars_for_completion=0
" 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_cache_omnifunc=0
" 开启语义补全
let g:ycm_seed_identifiers_with_syntax=1
" 在注释输入中也能补全
let g:ycm_complete_in_comments = 1
" 在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
" let g:ycm_filetype_whitelist = { 'python': 1 }
let g:ycm_python_binary_path = 'python'
map <C-G>  :YcmCompleter GoToDefinitionElseDeclaration<CR>
"  fix .cpp error: ValueError: Still no compile flags, no completions yet.
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
" Vim's autocomplete is excruciatingly slow
" http://stackoverflow.com/questions/2169645/vims-autocomplete-is-excruciatingly-slow
set complete-=i
" set filetype
let g:ycm_filetype_blacklist = {}

let g:ycm_goto_buffer_command = 'new-or-existing-tab'


"""""""""""""""""""""""""""""""""""""""""""""
"              Vim UI                       "
"""""""""""""""""""""""""""""""""""""""""""""
" https://stackoverflow.com/questions/11392941/disabling-autocommands-for-help-buffers?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
au BufRead,BufNewFile * if &l:modifiable | setlocal fileformat=unix | endif

au BufNewFile,BufRead *
\ set tabstop=4 |
\ set softtabstop=4 |
\ set shiftwidth=4 |
\ set expandtab |
\ set autoindent |
\ set list listchars=tab:>-

au BufNewFile,BufRead Makefile
\ set expandtab!

au BufNewFile,BufRead *.yaml,*.yml,.vimrc
\ set tabstop=2 |
\ set softtabstop=2 |
\ set shiftwidth=2 |

au BufNewFile,BufRead *.c,*.py
\ set colorcolumn=80

au BufNewFile,BufRead *.go
\ set nolist

" split navigations
set splitbelow
set splitright


"""""""""""""""""""""""""""""""""""""""""""""
"               Window Navigate             "
"""""""""""""""""""""""""""""""""""""""""""""

" Ctrl-j 切换到下方的分割窗口 - Ctrl-k 切换到上方的分割窗口 - Ctrl-l
" 切换到右侧的分割窗口 - Ctrl-h 切换到左侧的分割窗口
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Alt + left for perivous tab
noremap <ESC>b :tabp<CR>
" Alt + right for next tab
noremap <ESC>f :tabn<CR>


"""""""""""""""""""""""""""""""""""""""""""""
"               Window Resize               "
"""""""""""""""""""""""""""""""""""""""""""""

" quick resize split
" Alt + h
nnoremap ˙ <C-W><
" Alt + l
nnoremap ¬ <C-W>>
" Alt + j
nnoremap ∆ <C-W>+
" Alt + k
nnoremap ˚ <C-W>-


" ignore compiled files
"set wildignore=*.o,*~,*.pyc

" 目录树快捷键
map <F5> :NERDTreeToggle<CR>
" NERDTree settings
" 是否显示隐藏文件
let NERDTreeShowHidden=0
" 忽略以下文件的显示
let NERDTreeIgnore=['\.pyc','\~$','\.swp','__pycache__','\.git$','\.DS_Store']
" NERDTree git 扩展
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

" for airline
" 使用powerline打过补丁的字体
let g:airline_powerline_fonts = 1
let g:airline_theme='dark_minimal'
" 开启tabline
let g:airline#extensions#tabline#enabled = 1
" 显示buffer编号
let g:airline#extensions#tabline#buffer_nr_show = 1
" tabline中当前buffer两端的分隔字符
let g:airline#extensions#tabline#left_sep = '🔥'
" tabline中未激活buffer两端的分隔字符
let g:airline#extensions#tabline#left_alt_sep = '💦'
" 关于buffer使用：
"     :ls 查看buffer
"     :bn (buffer next)
"     :bp (buffer previous)
"     :b <num> 打开编号为num的buffer

" color scheme
set background=dark        " Assume a dark background

" 自定义代码折叠，折叠（和取消折叠）
set foldmethod=syntax
set nofoldenable " default unfolded when open file
nnoremap <space> za
map <F4> :call ToggleFold()<CR>
function! ToggleFold()
  if(&foldlevel == '0')
      exec "normal! zR"
  else
      exec "normal! zM"
  endif
  echo "foldlevel:" &foldlevel
endfunction

set cursorline  " 光标横线
set cursorcolumn  " 光标竖线

" Shifting blocks visually
" http://vim.wikia.com/wiki/Shifting_blocks_visually
" Following is a more elaborate set of mappings (mapping Shift-Tab will
" probably only work on gvim)
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" auto typesetting for text file
autocmd BufWritePre *.markdown,*.md,*.text,*.txt,*.wiki,*.cnx call PanGuSpacing()

" Move cursor by display lines when wrapping
nnoremap  <silent> k gk
nnoremap  <silent> j gj
nnoremap  <silent> 0 g0
nnoremap  <silent> $ g$

" set background to transparent
hi Normal guibg=NONE ctermbg=NONE

let mapleader = ","

" Alt+h for previous buffer
"noremap ˙ :bp<CR>
" Alt+l for next buffer
"noremap ¬ :bn<CR>

noremap <silent> <F6> :noh<CR>

" copy to & paste from system clipboard
noremap <Leader>y "*y
noremap <Leader>p "*p

"""""""""""""""""""""""""""""""""""""""""""""
"           CtrlP                           "
"""""""""""""""""""""""""""""""""""""""""""""

nnoremap <silent> <F9> :CtrlPBuffer<CR>
nnoremap <silent> <F10> :CtrlP .<CR>
let g:ctrlp_custom_ignore = {
  \ 'dir':  'node_modules',
  \ }
" The maximum number of files to scan, set to 0 for no limit
let g:ctrlp_max_files = 1000


"""""""""""""""""""""""""""""""""""""""""""""
"           ctrlsf                          "
"""""""""""""""""""""""""""""""""""""""""""""

let g:ctrlsf_ackprg = 'ag'
let g:ctrlsf_winsize = '40%'
let g:ctrlsf_position = 'right'
let g:ctrlsf_case_sensitive = 'no'

nmap     <C-F>f <Plug>CtrlSFPrompt -R -I<Space>
vmap     <C-F>f <Plug>CtrlSFVwordPath
vmap     <C-F>F <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>


"""""""""""""""""""""""""""""""""""""""""""""
"           cscope                          "
"""""""""""""""""""""""""""""""""""""""""""""

nnoremap <leader>fa :call cscope#findInteractive(expand('<cword>'))<CR>
nnoremap <leader>l :call ToggleLocationList()<CR>

" s: Find this C symbol
nnoremap  <leader>fs :call cscope#find('s', expand('<cword>'))<CR>
" g: Find this definition
nnoremap  <leader>fg :call cscope#find('g', expand('<cword>'))<CR>
" d: Find functions called by this function
nnoremap  <leader>fd :call cscope#find('d', expand('<cword>'))<CR>
" c: Find functions calling this function
nnoremap  <leader>fc :call cscope#find('c', expand('<cword>'))<CR>
" t: Find this text string
nnoremap  <leader>ft :call cscope#find('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
nnoremap  <leader>fe :call cscope#find('e', expand('<cword>'))<CR>
" f: Find this file
nnoremap  <leader>ff :call cscope#find('f', expand('<cword>'))<CR>
" i: Find files #including this file
nnoremap  <leader>fi :call cscope#find('i', expand('<cword>'))<CR>

set runtimepath^=~/.vim/plugin
" ale lint toggle
nnoremap <silent> <F8> :ALEToggle<CR>
" disable ale by default
"autocmd BufEnter :AleDiaable

" Enable gitgutter
let g:gitgutter_enabled = 1


"""""""""""""""""""""""""""""""""""""""""""""
"           vim multiple cursors            "
"""""""""""""""""""""""""""""""""""""""""""""

let g:multi_cursor_select_all_word_key = '<C-a>'

" disable matchparen
"autocmd VimEnter * NoMatchParen

let g:rainbow_active = 1

let g:rainbow_conf = {
\    'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
\    'ctermfgs': ['darkred', 'blue', 'yellow', 'cyan', 'magenta', 'brown'],
\}

let g:ycm_global_ycm_extra_conf = '/Users/cuixiaochen/.vim/plugged/YouCompleteMe/third_party/ycmd/examples/.ycm_extra_conf.py'


"""""""""""""""""""""""""""""""""""""""""""""
"           templates                       "
"""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
  augroup templates
    autocmd BufNewFile *.sh 0r ~/.vim/templates/skeleton.sh
    autocmd BufNewFile *.py 0r ~/.vim/templates/skeleton.py
  augroup END
endif


"""""""""""""""""""""""""""""""""""""""""""""
"           vim-gitgutter                   "
"""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_enabled = 0
