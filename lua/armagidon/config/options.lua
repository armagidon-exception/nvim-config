local opt = vim.opt
local g = vim.g

opt.autoread = true
opt.clipboard:append { "unnamed", "unnamedplus" }
opt.cursorcolumn = true
opt.cursorline = true
opt.expandtab = true
opt.fileencoding = "utf-8"
opt.mouse = "a"
opt.number = true
opt.relativenumber = true
opt.autoindent = true
opt.showmode = false

opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

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
opt.signcolumn = "yes"

opt.backspace = { "eol", "start", "indent" }

opt.hidden = true
opt.path:append { "**" }

vim.opt.completeopt:append { "menu", "menuone", "noselect" }

if g.neovide then
	vim.o.guifont = "Source Code Pro:h10"
end
g.mapleader = " "
g.maplocalleader = " "
g.have_nerd_font = true
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0
g.loaded_python_provider = 0
g.loaded_python3_provider = 0

g.ft_scroll_ignore = {
	qf = true,
	["grug-far"] = true,
	help = true,
	man = true,
	query = true,
	TelescopePrompt = true,
	OverseerList = true,
	notify = true,
	checkhealth = true,
	alpha = true,
	lazy = true,
}
