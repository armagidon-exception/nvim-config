local telescope = require "telescope"
local t_actions = require "telescope.actions"
local builtin = require "telescope.builtin"
local map = require "utils.mappings"

telescope.setup {
	defaults = {
		mappings = {
			i = {
				["<Tab>"] = t_actions.move_selection_next,
				["<S-Tab>"] = t_actions.move_selection_previous,
				["="] = t_actions.toggle_selection,
				["<S-Up>"] = t_actions.remove_selection + t_actions.move_selection_previous,
				["<S-Down>"] = t_actions.add_selection + t_actions.move_selection_next,
				["<Up>"] = nil,
				["<Down>"] = nil,
			},
		},
	},
	pickers = {
		symbols = {
			theme = "dropdown",
		},
        buffers = {
            theme = "dropdown"
        }
	},
	extensions = {
		file_browser = {
			theme = "dropdown",
			hijack_netrw = true,
			cwd_to_path = true,
		},
	},
}

telescope.load_extension "fzf"
telescope.load_extension "projects"
telescope.load_extension "file_browser"

map("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
map("n", "<leader>bfs", builtin.buffers, { desc = "List buffers" })
map("n", "<leader>sym", builtin.symbols, { desc = "Show symbols" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })

map("n", "<leader>fb", telescope.extensions.file_browser.file_browser, { desc = "File browser" })
