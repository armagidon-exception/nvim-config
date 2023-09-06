local project_nvim = require'project_nvim'
local map = require'utils.mappings'
local telescope = require'telescope'
local themes = require'telescope.themes'

project_nvim.setup({
    detection_methods = {'pattern', 'lsp'},
    manual_mode = true,
    scope_chdir = "tab"
})

map('n', '<leader>prjs', function()
    telescope.extensions.projects.projects(themes.get_dropdown({}))
end)
