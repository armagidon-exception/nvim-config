vim.opt.termguicolors = true

local status, nightfox = pcall(require, 'nightfox')
if not status then
    print('This module requires NightFox to be installed')
    return
end
require'nightfox'.setup {
    options = {
        transparent = false
    }
}

vim.cmd('colorscheme carbonfox')
