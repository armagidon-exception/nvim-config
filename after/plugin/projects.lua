local project_nvim = require "project_nvim"
local mapper = require "utils.mappings"
local telescope = require "telescope"
local themes = require "telescope.themes"

project_nvim.setup {
	detection_methods = { "pattern", "lsp" },
	manual_mode = false,
	scope_chdir = "tab",
}

mapper.create_mappings {
    {
        mode = "n",
        keys = "<leader>prjs",
        command = function()
            telescope.extensions.projects.projects(themes.get_dropdown {})
        end,
    },
}
