call plug#begin('~/.local/share/nvim/bundle')
Plug 'chriskempson/base16-vim'
Plug 'tpope/vim-sensible'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()

set mouse=a

set nobackup
set noswapfile

set number
set nowrap
set termguicolors

set shiftwidth=2
set tabstop=2
set autoindent
set smartindent

colorscheme base16-tomorrow-night

map <leader>n :NERDTreeToggle<CR>
