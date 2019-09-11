if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC | q
endif

call plug#begin('~/.local/share/nvim/bundle')

Plug 'chriskempson/base16-vim'

Plug 'tpope/vim-sensible'

Plug 'bronson/vim-trailing-whitespace'
Plug 'tpope/vim-repeat'
Plug 'godlygeek/tabular'

Plug 'terryma/vim-multiple-cursors'
Plug 'yuttie/comfortable-motion.vim'
Plug 'easymotion/vim-easymotion'
Plug 'wellle/targets.vim'
Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-surround'

Plug 'milkypostman/vim-togglelist'

Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/nerdcommenter'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-vinegar'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'majutsushi/tagbar'

Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
      \ }

Plug 'junegunn/fzf', { 'dir': '~/.local/share/fzf/', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

call plug#end()

autocmd VimEnter *
      \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
      \|   PlugInstall --sync | q
      \| endif

set shell=/bin/sh

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

set shiftwidth=2
set tabstop=2
set expandtab
set autoindent
set smartindent

set list
set listchars=tab:\ \ ,extends:›,precedes:‹,nbsp:·,trail:·

set signcolumn=yes
set shortmess+=c

set termguicolors
let base16colorspace=256
colorscheme base16-tomorrow-night
let g:airline_theme='base16_vim'

noremap <silent> <leader>r :source $MYVIMRC<CR>:do VimEnter *<CR>
noremap <leader>n :NERDTreeToggle<CR>
noremap <leader>nn :NERDTreeFind<CR>
noremap <leader>t :TagbarToggle<CR>
noremap <leader>g :GitGutterToggle<CR>
noremap <leader><space> :Files<CR>
noremap <leader>f :Rg <C-R><C-W><CR>
noremap <leader>F :Rg <C-R><C-A><CR>
vnoremap <leader>f y:Rg <C-R>"<CR>

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

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter *
      \ if argc() == 0 && !exists("s:std_in") |
      \   NERDTree |
      \ elseif argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") |
      \	  exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] |
      \ endif

let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMouseMode = 3
let g:NERDTreeIndicatorMapCustom = {
      \ "Modified"  : "~",
      \ "Staged"    : "✚",
      \ "Untracked" : "✭",
      \ "Renamed"   : "➜",
      \ "Unmerged"  : "═",
      \ "Deleted"   : "-",
      \ "Dirty"     : "·",
      \ "Clean"     : "✔︎",
      \ "Unknown"   : "?"
      \ }

let g:comfortable_motion_no_default_key_mappings = 1
let g:comfortable_motion_impulse_multiplier = 0.5
let g:comfortable_motion_friction = 0.0
let g:comfortable_motion_air_drag = 4.0
nnoremap <silent> <C-j> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 1)<CR>
nnoremap <silent> <C-k> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -1)<CR>
nnoremap <silent> <C-d> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 2)<CR>
nnoremap <silent> <C-u> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -2)<CR>
nnoremap <silent> <C-f> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 4)<CR>
nnoremap <silent> <C-b> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -4)<CR>
noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 1)<CR>
noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -1)<CR>

let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping = ''
nmap sk :SplitjoinSplit<cr>
nmap sj :SplitjoinJoin<cr>

let g:fzf_colors = {
      \ 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment']
      \ }
command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview('right:50%', '?'), <bang>0)
command! -bang -nargs=+ Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
      \		fzf#vim#with_preview('right:50%', '?'),
      \   <bang>0)

let g:LanguageClient_serverCommands = {
      \ 'go': ['gopls']
      \ }
let g:LanguageClient_useVirtualText = 1

autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gt :call LanguageClient#textDocument_typeDefinition()<CR>
nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
noremap <leader>rn :call LanguageClient#textDocument_rename()<CR>
noremap <leader>= :call LanguageClient#textDocument_codeAction()<CR>

