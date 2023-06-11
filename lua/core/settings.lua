local opt = vim.opt
local g = vim.g

--opt.autochdir = true
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

opt.wildignore:append { "**/node_modules/*", '**/.git/*' }

opt.completeopt = 'menu,menuone,noselect'
vim.api.nvim_create_autocmd({'BufNewFile','BufRead'}, {
    pattern = "*",
    callback = function(_)        
        opt.formatoptions:remove { "c", "r", "o" } 
    end,
})

--package.path = vim.fn.stdpath("config") .. '/after/plugin/?.lua;' .. package.path
-- package.path = home_dir .. "/.config/nvim/after/plugin/?.lua;" .. package.path
