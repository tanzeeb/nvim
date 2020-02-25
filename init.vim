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

Plug 'liuchengxu/vista.vim'

Plug 'junegunn/fzf', { 'dir': '~/.local/share/fzf/', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'honza/vim-snippets'

call plug#end()

" Auto-install Plugins {{{
autocmd VimEnter *
      \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
      \|   PlugInstall --sync | q
      \| endif
" }}}

" }}}

" General {{{
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
set cursorline
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
noremap <leader>n :NERDTreeToggle<CR>
noremap <leader>nn :NERDTreeFind<CR>
noremap <leader>v :Vista!!<CR>
noremap <leader>g :GitGutterToggle<CR>
noremap <leader><space> :Files<CR>
noremap <leader>f :Rg <C-R><C-W><CR>
noremap <leader>F :Rg <C-R><C-A><CR>
vnoremap <leader>f y:Rg <C-R>"<CR>
" }}}

" Colours {{{
set termguicolors
let base16colorspace=256
colorscheme base16-tomorrow-night

function! s:SetBase16hi(group, fg, bg)
  let g_bg = "g:base16_gui0" . a:bg
  let g_fg = "g:base16_gui0" . a:fg
  let c_bg = "g:base16_cterm0" . a:bg
  let c_fg = "g:base16_cterm0" . a:fg

  execute "call g:Base16hi('".a:group."', ".g_fg.", ".g_bg.", ".c_fg.", ".c_bg.", '', '')"
endfunction

hi link ExtraWhitespace Error

" TODO: tweak more
"call <sid>SetBase16hi("Pmenu", "7", "1")
"call <sid>SetBase16hi("PmenuSel", "1", "7")
"call <sid>SetBase16hi("PmenuSbar", "5", "1")
"call <sid>SetBase16hi("PmenuThumb", "2", "1")
"call <sid>SetBase16hi("CocFloating", "6", "1")

for level in [
  \   [ "Error", "8", "7" ],
  \   [ "Warning", "A", "7" ],
  \   [ "Info", "D", "7"],
  \   [ "Hint", "6", "7"],
  \ ]
  call <sid>SetBase16hi("Coc".level[0]."Sign", level[1], "1")
  call <sid>SetBase16hi("Coc".level[0]."Float", level[2], level[1])
  call <sid>SetBase16hi("Coc".level[0]."VirtualText", level[2], level[1])
endfor
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

" Vista {{{
let g:vista_echo_cursor_strategy = "floating_win"
let g:vista_icon_indent = ["","  "]
let g:vista_default_executive = "coc"
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

" NERDTree {{{
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
" }}}

" FZF {{{
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
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)
command! -bang -nargs=+ Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
      \		fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)

let $FZF_DEFAULT_OPTS='--layout=reverse'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

au FileType fzf set nonu nornu

" }}}

" CoC {{{
let g:coc_global_extensions = [
  \  'coc-json',
  \  'coc-snippets',
  \  'coc-vimlsp',
  \  'coc-rust-analyzer',
  \ ]

let g:coc_user_config = {
      \  "languageserver": {
      \    "golang": {
      \      "command": "gopls",
      \      "rootPatterns": ["go.mod"],
      \      "filetypes": ["go"],
      \      "initializationOptions": {
      \        "usePlaceholders": "true",
      \        "buildFlags": ["-tags=e2e"]
      \      }
      \    }
      \  },
      \  "diagnostic.virtualText": "false",
      \  "diagnostic.virtualTextPrefix": "",
      \  "diagnostic.enableMessage": "always",
      \  "diagnostic.messageTarget": "echo",
      \  "diagnostic.signOffset": 5000,
      \  "diagnostic.errorSign": "•",
      \  "diagnostic.warningSign": "◦",
      \  "diagnostic.infoSign": "‣",
      \  "diagnostic.hintSign": "⁃",
      \  "suggest.floatEnable": "true",
      \  "suggest.enablePreview": "true",
      \  "suggest.autoTrigger": "never",
      \  "coc.preferences.formatOnSaveFiletypes": ["rust"]
      \}

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"

nmap <silent> gd <Plug>(coc-declaration)
nmap <silent> <c-]> <Plug>(coc-type-definition)
nnoremap <silent> K :call CocAction('doHover')<CR>
nmap <silent> gD <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> <c-k> :call CocActionAsync('showSignatureHelp')<CR>
nmap <silent> <leader>rn <Plug>(coc-rename)
nmap <silent> <leader>= <Plug>(coc-codeaction)

autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
" }}}
"
" vim:foldmethod=marker:foldlevel=0
