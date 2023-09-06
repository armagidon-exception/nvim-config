local opt = vim.opt
local g = vim.g
opt.autoread = true
opt.browsedir = 'buffer'
opt.clipboard:append({'unnamed', 'unnamedplus'})
opt.cursorcolumn = true
opt.cursorline = true
opt.expandtab = true
opt.fileencoding = 'utf-8'
opt.mouse = 'a'
opt.number = true
opt.relativenumber = true

opt.guicursor = ""

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

opt.smartindent = true
opt.wrap = false
opt.backup = false
opt.swapfile = false

opt.hlsearch = false
opt.incsearch = true
opt.termguicolors = true
opt.scrolloff = 10
opt.updatetime = 50
g.mapleader = " "
opt.signcolumn = 'yes'

opt.hidden = true

vim.opt.completeopt:append( { "menu", "menuone", "noselect" } )
