let mapleader=" "
nmap <Leader>s <Plug>(easymotion-s2)
" NERDTree
nmap <Leader>nt :NERDTreeFind<CR>
nmap <Leader>e :NERDTree<CR>
nmap <Leader>nr :NERDTreeRefreshRoot<CR>
nmap <leader>w :w<cr>
nmap <leader>q :q<cr>
nmap <leader><F4> :q!<cr>

" Duplicate a line
nmap <leader>d 0v$yo<Esc>pji<del><Esc>k$
nmap <leader>c 0v$y$
nmap <leader>p o<Esc>pji<del><Esc>k$
nmap <leader>a gg0vG$y 

" Coc
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
	\ coc#pum#visible() ? coc#pum#next(1):
	\ <SID>check_back_space() ? "\<Tab>" :
	\ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" inoremap ( ()<Esc>i
" inoremap { {}<Esc>i
" inoremap {<CR> {<CR>}<Esc>O
" inoremap [ []<Esc>i
" inoremap < <><Esc>i
" inoremap ' ''<Esc>i
" inoremap " ""<Esc>i
