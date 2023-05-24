local treesitter_status, treesitter = pcall(require, 'nvim-treesitter')

if not treesitter_status then
    print("This module requires TreeSitter to be installed")
    return
end

local configs = require'nvim-treesitter.configs'

configs.setup {
    ensure_installed = {"lua"},
    sync_install = true,
    auto_install = true,
    

    -- Modules
    highlight = {
        enable = true,
    },
    indent = {
        enabled = true,
    }
}

vim.treesitter.language.register('embedded_template', 'ejs')
require('vim.treesitter.query').set('embedded_template', 'injections', [[
((content) @injection.content
 (#set! injection.language "html")
 (#set! injection.combined))

((code) @injection.content
 (#set! injection.language "javascript")
 (#set! injection.combined))
]])
