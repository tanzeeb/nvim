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

	Plug 'majutsushi/tagbar'

	Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()

set mouse=a
set hidden
set nobackup
set noswapfile
set nowritebackup
set updatetime=300

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
map <leader>t :TagbarToggle<CR>

let g:go_fmt_command="goimports"
let g:go_metalinter_command="golangci-lint"

let g:go_highlight_variable_assignments=1
let g:go_highlight_variable_declarations=1
let g:go_highlight_generate_tags=1
let g:go_highlight_build_constraints=1
let g:go_highlight_fields=1
let g:go_highlight_types=1
let g:go_highlight_function_calls=1
let g:go_highlight_function_arguments=1
let g:go_highlight_functions=1
let g:go_highlight_operators=1
let g:go_highlight_trailing_whitespace_error=1
let g:go_highlight_space_tab_error=1
let g:go_highlight_extra_types=1
let g:go_highlight_chan_whitespace_error=1
let g:go_highlight_array_whitespace_error=1

fun! s:UseGoPls()
	if match(getline(1),'+build') == -1
		let g:go_info_mode="gopls"
		let g:go_def_mode="gopls"
	else
		let g:go_info_mode="gocode"
		let g:go_def_mode="godef"
	endif
endfun
autocmd BufWinEnter *.go call s:UseGoPls()

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter *
	\ if argc() == 0 && !exists("s:std_in") |
	\   NERDTree |
	\ elseif argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") |
	\	  exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] |
	\ endif

