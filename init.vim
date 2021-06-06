" Tanzeeb's NeoVim Configuration
" github.com/tanzeeb/nvim

" Plugins {{{

" Auto-Install Plugin Manager {{{
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC | q
endif
" }}}

call plug#begin('~/.local/share/nvim/bundle')

Plug 'chriskempson/base16-vim'

Plug 'tpope/vim-sensible'

Plug 'bronson/vim-trailing-whitespace'
Plug 'tpope/vim-repeat'
Plug 'godlygeek/tabular'

Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/nerdcommenter'

call plug#end()

" Auto-install Plugins {{{
autocmd VimEnter *
      \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
      \|   PlugInstall --sync | q
      \| endif
" }}}

" }}}

" General {{{
set mouse=a
set hidden
set nobackup
set noswapfile
set nowritebackup
set updatetime=300

set number
set nowrap
set termguicolors
set backspace=indent,eol,start
set cursorline
set cursorcolumn
set wildmenu

set shiftwidth=2
set tabstop=2
set expandtab
set autoindent
set smartindent

set list
set listchars=tab:\ \ ,extends:›,precedes:‹,nbsp:·,trail:·

set signcolumn=auto:3
set shortmess+=c

set foldmethod=syntax
set foldlevelstart=99
" }}}

" Keymaps {{{
noremap <silent> <leader>r :source $MYVIMRC<CR>:do VimEnter *<CR>
" }}}

" Colours {{{
set termguicolors
let base16colorspace=256
colorscheme base16-tomorrow-night

" SetBase16hi(group, fg, bg)
" sets a base16 colorscheme based on fg/bg for the specified highlight group
" eg.
"   call <sid>SetBase16hi("Pmenu", "7", "1")
function! s:SetBase16hi(group, fg, bg)
  let g_bg = "g:base16_gui0" . a:bg
  let g_fg = "g:base16_gui0" . a:fg
  let c_bg = "g:base16_cterm0" . a:bg
  let c_fg = "g:base16_cterm0" . a:fg

  execute "call g:Base16hi('".a:group."', ".g_fg.", ".g_bg.", ".c_fg.", ".c_bg.", '', '')"
endfunction

hi link ExtraWhitespace Error
" }}}

" Airline {{{
let g:airline_theme='base16_vim'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#close_symbol = '✖'
let g:airline_powerline_fonts = 1
" }}}

" Misc. {{{

" }}}

" Go {{{
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
" }}}

"
" vim:foldmethod=marker:foldlevel=0
