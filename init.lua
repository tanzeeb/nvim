-- Tanzeeb's NeoVim Configuration
-- github.com/tanzeeb/nvim

-- Plugins {{{

-- Auto-Install Plugin Manager {{{
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.api.nvim_command('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

vim.cmd [[packadd packer.nvim]]
vim.cmd 'autocmd BufWritePost init.lua PackerCompile'

-- }}}

require('packer').startup({function(use)

use { 'chriskempson/base16-vim' }

use { 'bronson/vim-trailing-whitespace' }
use { 'tpope/vim-repeat' }
use { 'tpope/vim-surround' }

use { 'godlygeek/tabular' }
use { 'scrooloose/nerdcommenter' }

use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
use { 'nvim-treesitter/playground' }

use { 'neovim/nvim-lspconfig' }
use { 'kabouzeid/nvim-lspinstall' }

end,
config = {
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end
  }
}})
-- }}}

-- General {{{
vim.o.mouse = 'a'
vim.o.hidden = true
vim.o.backup = false
vim.o.swapfile = false
vim.o.writebackup = false
vim.o.updatetime = 300

vim.o.number = true
vim.o.wrap = false
vim.o.termguicolors = true
vim.o.backspace = 'indent,eol,start'
vim.o.cursorline = true
vim.o.cursorcolumn = true
vim.o.wildmenu = true

vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true

vim.o.list = true
vim.opt.listchars = { tab='  ', extends='›', precedes='‹', nbsp='·', trail='·' }

vim.o.shortmess = vim.o.shortmess .. 'c'

vim.o.completeopt = 'menuone,noinsert,noselect'

vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldlevelstart = 99
-- }}}

-- Keymaps {{{
local function keymap(mode, lhs, rhs) vim.api.nvim_set_keymap(mode,lhs,rhs,{noremap=true, silent=true}) end

keymap('n', '<leader>r', '<cmd>source $MYVIMRC<CR>:do VimEnter *<CR>')
-- }}}

-- Colours {{{
vim.o.termguicolors = true
vim.cmd 'let base16colorspace=256'
vim.cmd 'colorscheme base16-tomorrow-night'

vim.cmd 'hi link ExtraWhitespace Error'
-- }}}

-- Misc. {{{

-- }}}

-- Treesitter {{{
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
-- }}}

-- LSP {{{

local lspconfig = require('lspconfig')
local lspinstall = require('lspinstall')

local languages = {
  "bash",
  "go",
  "lua",
  "rust",
  "vim",
}
for _,lang in pairs(languages) do
  if not lspinstall.is_server_installed(lang) then
    lspinstall.install_server(lang)
  end
end

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

  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
    augroup lsp_document_highlight
    autocmd! * <buffer>
    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]], false)
  end
end

local lua_settings = {
  Lua = {
    runtime = {
      version = 'LuaJIT',
      path = vim.split(package.path, ';'),
    },
    diagnostics = {
      globals = {'vim'},
    },
    workspace = {
      library = {
        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
      },
    },
  }
}

local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return {
    capabilities = capabilities,
    on_attach = on_attach,
  }
end

local function setup_servers()
  lspinstall.setup()

  local servers = lspinstall.installed_servers()

  for _, server in pairs(servers) do
    local config = make_config()

    if server == "lua" then
      config.settings = lua_settings
    end

    lspconfig[server].setup(config)
  end
end

setup_servers()

lspinstall.post_install_hook = function ()
  setup_servers()
  vim.cmd("bufdo e")
end

-- }}}

-- vim:foldmethod=marker:foldlevel=0
