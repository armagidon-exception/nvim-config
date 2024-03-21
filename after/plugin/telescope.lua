local telescope = require "telescope"
local t_actions = require "telescope.actions"
local builtin = require "telescope.builtin"
local keymaps = require "utils.mappings"
local telescope_extras = require "configs.telescope"

local default_mappings = {
	normal = {
		["<Tab>"] = t_actions.move_selection_next,
		["<S-Tab>"] = t_actions.move_selection_previous,
		["="] = t_actions.toggle_selection,
		["K"] = telescope_extras.select_prev,
		["J"] = telescope_extras.select_next,
		["<Up>"] = t_actions.nop,
		["<Down>"] = t_actions.nop,
		["q"] = t_actions.close,
	},
	insert = {
		["<leader>gti"] = vim.cmd.stopinsert,
	},
}

telescope.setup {
	defaults = {
        file_ignore_patterns = { "node_modules" },
		mappings = {
			i = default_mappings.insert,
			n = default_mappings.normal,
		},
        preview = {
            mime_hook = telescope_extras.mime_hook
        }
	},
	pickers = {
		symbols = {
			theme = "dropdown",
		},
		buffers = {
			theme = "dropdown",
		},
		find_files = {
			mappings = {
				n = {
					["<C-h>"] = telescope_extras.find_hidden_files,
					F = telescope_extras.browse_selected_dir,
					g = telescope_extras.search_git_files,
				},
			},
		},
	},
	extensions = {
		file_browser = {
			theme = "dropdown",
			hijack_netrw = true,
			cwd_to_path = true,
			prompt_path = true,
            path = "%:p:h",
			mappings = {
				n = {
					F = telescope_extras.find_in_directory,
				},
			},
		},
	},
}

telescope.load_extension "fzf"
telescope.load_extension "projects"
telescope.load_extension "file_browser"
telescope.load_extension "noice"

keymaps.create_mappings {
	{
		mode = "n",
		keys = "<leader>ff",
		command = builtin.find_files,
		opts = { desc = "Find files" },
	},
	{
		mode = "n",
		keys = "<leader>fg",
		command = builtin.live_grep,
		opts = { desc = "Live grep" },
	},
	{
		mode = "n",
		keys = "<leader>bfs",
		command = builtin.buffers,
		opts = { desc = "List buffers" },
	},
	{
		mode = "n",
		keys = "<leader>sym",
		command = builtin.symbols,
		opts = { desc = "Show symbols" },
	},
	{
		mode = "n",
		keys = "<leader>fh",
		command = builtin.help_tags,
		opts = { desc = "Help tags" },
	},
	{
		mode = "n",
		keys = "<leader>fb",
		command = telescope.extensions.file_browser.file_browser,
		opts = { desc = "File browser" },
	},
}
