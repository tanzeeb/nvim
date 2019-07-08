if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC | q
endif

call plug#begin('~/.local/share/nvim/bundle')
	Plug 'chriskempson/base16-vim'

	Plug 'tpope/vim-sensible'
	Plug 'terryma/vim-multiple-cursors'
	Plug 'bronson/vim-trailing-whitespace'
	Plug 'tpope/vim-surround'

	Plug 'yuttie/comfortable-motion.vim'
	Plug 'easymotion/vim-easymotion'

	Plug 'sheerun/vim-polyglot'
	Plug 'scrooloose/nerdcommenter'

	Plug 'airblade/vim-gitgutter'
	Plug 'tpope/vim-fugitive'
	Plug 'junegunn/gv.vim'

	Plug 'scrooloose/nerdtree'
	Plug 'Xuyuanp/nerdtree-git-plugin'

	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'

	Plug 'majutsushi/tagbar'

	Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

	Plug 'w0rp/ale'
call plug#end()

autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

set shell=sh
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

let base16colorspace=256
colorscheme base16-tomorrow-night
let g:airline_theme='base16_tomorrow'

noremap <silent> <leader>r :source $MYVIMRC<CR>:do VimEnter *<CR>
noremap <leader>n :NERDTreeToggle<CR>
noremap <leader>t :TagbarToggle<CR>
noremap <leader>g :GitGutterToggle<CR>
noremap <leader>l :ALEToggle<CR>

let g:go_fmt_command="goimports"
let g:go_metalinter_command="golangci-lint"
let g:go_echo_command_info=0

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

let g:ale_linters = {
	\		'go': ['gobuild', 'gopls', 'golangci-lint']
	\	}
let g:ale_go_golangci_lint_options = '--fast --enable-all --disable errcheck,gofmt,goimports,dupl,lll,nakedret,gochecknoglobals,typecheck'
let g:ale_sign_error = "*"
let g:ale_sign_warning = "*"
highlight link ALEErrorSign GitGutterDelete
highlight link ALEWarningSign GitGutterChangeDelete

set omnifunc=ale#completion#OmniFunc

fun! s:UseGoPls()
	if match(getline(1),'+build') == -1
		let g:go_info_mode="gopls"
		let g:go_def_mode="gopls"
	else
		let g:go_info_mode="gocode"
		let g:go_def_mode="godef"
	endif
endfun
autocmd BufEnter *.go call s:UseGoPls()

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter *
	\ if argc() == 0 && !exists("s:std_in") |
	\   NERDTree |
	\ elseif argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") |
	\	  exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] |
	\ endif

let g:comfortable_motion_no_default_key_mappings = 1
let g:comfortable_motion_impulse_multiplier = 0.5  " Feel free to increase/decrease this value.
nnoremap <silent> <C-d> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 2)<CR>
nnoremap <silent> <C-u> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -2)<CR>
nnoremap <silent> <C-f> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 4)<CR>
nnoremap <silent> <C-b> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -4)<CR>
noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 1)<CR>
noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -1)<CR>

let NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeIndicatorMapCustom = {
	\ "Modified"  : "~",
	\ "Staged"    : "✚",
	\ "Untracked" : "✭",
	\ "Renamed"   : "➜",
	\ "Unmerged"  : "═",
	\ "Deleted"   : "-",
	\ "Dirty"     : "*",
	\ "Clean"     : "✔︎",
	\ "Unknown"   : "?"
	\ }

