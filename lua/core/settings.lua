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

local function set_cwd()
    local first_argument = vim.v.argv[2]
    if not first_argument then return end

    if first_argument == '.' then
        first_argument = vim.fn.getcwd()
    elseif first_argument == '..' then
        local curr = vim.fn.getcwd()
        first_argument = tostring(vim.fs.dirname(curr))
    end
    if vim.fn.isdirectory(first_argument) == 1 then
        vim.fn.chdir(first_argument)
    else
        local parent = tostring(vim.fs.dirname(first_argument))
        vim.fn.chdir(parent)
    end
end

if not _G.cwd_parent_set then
    set_cwd()
    _G.cwd_parent_set = true
end
