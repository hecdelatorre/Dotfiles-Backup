set runtimepath^=$HOME/.vim runtimepath+=$HOME/.vim/after
let &packpath=&runtimepath
source $HOME/.vimrc

let g:polyglot_disabled = ['markdown']

call plug#begin('~/.vim/plugins')
" Theme
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'itchyny/lightline.vim'
" IDE
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdtree'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'terryma/vim-multiple-cursors'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'sheerun/vim-polyglot'
Plug 'yggdroot/indentline'
Plug 'rust-lang/rust.vim'
Plug 'mattn/vim-gist'
Plug 'mattn/webapi-vim'
Plug 'ryanoasis/vim-devicons'
call plug#end()

"Theme
source $HOME/.config/nvim/theme.vimrc
" Plugins
source $HOME/.config/nvim/plugins.vimrc
source $HOME/.config/nvim/shortcuts.vimrc
