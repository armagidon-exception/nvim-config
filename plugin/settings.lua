local opt = vim.opt
local g = vim.g
opt.autoread = true
--opt.bsdir = 'buffer'
opt.clipboard:append { "unnamed", "unnamedplus" }
opt.cursorcolumn = true
opt.cursorline = true
opt.expandtab = true
opt.fileencoding = "utf-8"
opt.mouse = "a"
opt.number = true
opt.relativenumber = true
opt.autoindent = true

opt.guicursor = ""

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

opt.smartindent = true
opt.wrap = false
opt.backup = false
opt.swapfile = false
g.mapleader = " "
g.maplocalleader = " "

opt.hlsearch = false
opt.incsearch = true
opt.termguicolors = true
opt.scrolloff = 10
opt.updatetime = 50
opt.signcolumn = "yes"

opt.hidden = true

vim.opt.completeopt:append { "menu", "menuone", "noselect" }

if vim.g.neovide then
	vim.o.guifont = "Source Code Pro:h10"
end
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0
