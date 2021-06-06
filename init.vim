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
Plug 'scrooloose/nerdcommenter'

Plug 'sheerun/vim-polyglot'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

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

set shortmess+=c

set completeopt=menuone,noinsert,noselect

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=99
" }}}

" Keymaps {{{
noremap <silent> <leader>r :source $MYVIMRC<CR>:do VimEnter *<CR>
" }}}

" Colours {{{
set termguicolors
"let base16colorspace=256
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

" Misc. {{{

" }}}

" Treesitter {{{
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true
  }
}
EOF
" }}}

" LSP {{{

lua << EOF
local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }

  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

local servers = {
  "bashls",        -- npm i -g bash-language-server
  "gopls",         -- GO111MODULE=on go get golang.org/x/tools/gopls@latest
  "rust_analyzer", -- rustup +nightly component add rust-analyzer-preview
  "vimls",         -- npm install -g vim-language-server
}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

EOF

" }}}

" Completion {{{
autocmd BufEnter * lua require'completion'.on_attach()

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
imap <tab> <Plug>(completion_smart_tab)
imap <s-tab> <Plug>(completion_smart_s_tab)
" }}}

" Telescope {{{
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

lua << EOF
require('telescope').setup{
  defaults = {
    layout_strategy = 'flex',
  },
}
EOF
" }}}

" vim:foldmethod=marker:foldlevel=0
