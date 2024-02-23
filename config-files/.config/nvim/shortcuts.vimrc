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
nmap <leader>a ggvG$y 

" inoremap ( ()<Esc>i
" inoremap { {}<Esc>i
" inoremap {<CR> {<CR>}<Esc>O
" inoremap [ []<Esc>i
" inoremap < <><Esc>i
" inoremap ' ''<Esc>i
" inoremap " ""<Esc>i
