local telescope = require "telescope"
local t_actions = require "telescope.actions"
local builtin = require "telescope.builtin"
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
}

return {
	{

		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
			},
			{
				"nvim-telescope/telescope-file-browser.nvim",
				keys = {
					{
						"<leader>fb",
						"<cmd>Telescope file_browser<cr>",
						desc = "File browser",
					},
				},
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{
				"nvim-telescope/telescope-symbols.nvim",
				keys = {
					{
						"<leader>sym",
						builtin.symbols,
						desc = "Show symbols",
					},
				},
			},
			{ "nvim-lua/plenary.nvim" },
		},
		keys = {
			{
				"<leader>ff",
				builtin.find_files,
				desc = "Find files",
			},
			{
				"<leader>fg",
				builtin.live_grep,
				desc = "Live grep",
			},
			{
				"<leader>bfs",
				builtin.buffers,
				desc = "List buffers",
			},
			{
				"<leader>fh",
				builtin.help_tags,
				desc = "Help tags",
			},
		},
		config = function()
			telescope.setup {
				defaults = {
					file_ignore_patterns = { "node_modules" },
					mappings = {
						i = default_mappings.insert,
						n = default_mappings.normal,
					},
					preview = {
						mime_hook = telescope_extras.mime_hook,
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
							n = vim.tbl_extend("force", default_mappings, {
								["<C-h>"] = telescope_extras.find_hidden_files,
								F = telescope_extras.browse_selected_dir,
								g = telescope_extras.search_git_files,
							}),
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
							n = vim.tbl_extend("force", default_mappings, {
								F = telescope_extras.find_in_directory,
								x = telescope_extras.execute_shell_command,
							}),
						},
					},
				},
			}

			telescope.load_extension "fzf"
			telescope.load_extension "file_browser"
			telescope.load_extension "ui-select"
		end,
	},
}
