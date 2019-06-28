call plug#begin('~/.local/share/nvim/bundle')
	Plug 'chriskempson/base16-vim'

	Plug 'tpope/vim-sensible'
	Plug 'terryma/vim-multiple-cursors'
	Plug 'bronson/vim-trailing-whitespace'

	Plug 'sheerun/vim-polyglot'
	Plug 'scrooloose/nerdcommenter'

	Plug 'airblade/vim-gitgutter'
	Plug 'tpope/vim-fugitive'

	Plug 'scrooloose/nerdtree'
	Plug 'Xuyuanp/nerdtree-git-plugin'

	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
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
let g:airline_theme='base16_tomorrow'

map <leader>n :NERDTreeToggle<CR>
