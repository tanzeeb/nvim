-- Tanzeeb's NeoVim Configuration
-- github.com/tanzeeb/nvim

_G.init = function()

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

local lsp_installer = require("nvim-lsp-installer")
local servers = {
  "bashls",
  "dockerls",
  "gopls",
  "rust_analyzer",
  "solargraph",
  "sumneko_lua",
  "vimls",
  "yamlls",
}

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
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

lsp_installer.on_server_ready(function(server)
    local opts = {}

    if server.name == "sumneko_lua" then
      opts = require("lua-dev").setup()
    end

    opts.on_attach = on_attach

    server:setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
end)

for _, name in pairs(servers) do
	local ok, server = lsp_installer.get_server(name)
	if ok then
		if not server:is_installed() then
			server:install()
		end
	end
end

-- Run goimports on save {{{
function OrgImports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = {only = {"source.organizeImports"}}
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit)
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
  vim.lsp.buf.formatting()
end

vim.api.nvim_command("au BufWritePre *.go lua OrgImports(1000)")
-- }}}

-- }}}

end

-- Plugins {{{

-- Auto-Install Plugin Manager {{{
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end
-- }}}

require('packer').startup({
  function(use)
    use { 'wbthomason/packer.nvim' }

    use { 'chriskempson/base16-vim' }

    use { 'bronson/vim-trailing-whitespace' }
    use { 'tpope/vim-repeat' }
    use { 'tpope/vim-surround' }

    use { 'godlygeek/tabular' }
    use { 'scrooloose/nerdcommenter' }

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'nvim-treesitter/playground' }

    use {
      'neovim/nvim-lspconfig',
      'williamboman/nvim-lsp-installer',
      'folke/lua-dev.nvim',
    }

    if packer_bootstrap then
      require('packer').sync()
    end
  end,
  config = {
    display = {
      non_interactive = true,
    },
  },
})

if packer_bootstrap then
  vim.cmd [[autocmd User PackerComplete call v:lua.init()]]
else
  init()
end

-- }}}

-- vim:foldmethod=marker:foldlevel=0
