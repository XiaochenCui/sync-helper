nnoremap <silent> <leader>u :GoReferrers<CR>
nnoremap <leader>r :GoRename<Space>
nnoremap <silent> <leader>d :GoDoc<CR>

"Run goimports on save
"https://github.com/fatih/vim-go/issues/207
let g:go_fmt_command = "goimports"

"let g:go_auto_type_info = 1
"set updatetime=50

let g:go_def_reuse_buffer = 0

nnoremap <silent> <C-G> :GoDef<CR>

let g:syntastic_go_checkers = ['go', 'golint', 'govet', 'errcheck']
