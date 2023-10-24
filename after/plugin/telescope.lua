local telescope = require "telescope"
local t_actions = require "telescope.actions"
local builtin = require "telescope.builtin"
local map = require "utils.mappings"

local normal_default_mappings = {
	["<Tab>"] = t_actions.move_selection_next,
	["<S-Tab>"] = t_actions.move_selection_previous,
	["="] = t_actions.toggle_selection,
	["<S-Up>"] = t_actions.remove_selection + t_actions.move_selection_previous,
	["<S-Down>"] = t_actions.add_selection + t_actions.move_selection_next,
	["<Up>"] = nil,
	["<Down>"] = nil,
}

local switch_to_normal_mode = function()
	vim.cmd.stopinsert()
end

local insert_default_mappings = vim.tbl_deep_extend("force", normal_default_mappings, {
	["<C-I>"] = switch_to_normal_mode,
})

telescope.setup {
	defaults = {
		mappings = {
			i = insert_default_mappings,
			n = normal_default_mappings,
		},
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
					["<C-h>"] = function()
						builtin.find_files { hidden = true }
					end,
					F = function()
						local action_state = require "telescope.actions.state"
						telescope.extensions.file_browser.file_browser {
							path = getmetatable(action_state.get_selected_entry()).cwd,
						}
					end,
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
			mappings = {
				n = {
					F = function(promptnr)
						local action_state = require "telescope.actions.state"
						local picker = action_state.get_current_picker(promptnr)
						builtin.find_files {
							cwd = picker.finder.path,
						}
					end,
				},
			},
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
