return {
	{ "windwp/nvim-ts-autotag", event = "VeryLazy" },
	{ "nvim-treesitter/nvim-treesitter-textobjects", event = "VeryLazy" },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencides = {
			{ "windwp/nvim-ts-autotag", event = "VeryLazy" },
			{ "nvim-treesitter/nvim-treesitter-textobjects", event = "VeryLazy" },
		},
		event = "VeryLazy",
		config = function()
			local ts_configs = require "nvim-treesitter.configs"

			ts_configs.setup {
				ensure_installed = { "lua" },
				auto_install = true,
				sync_install = false,
				modules = {},
				ignore_install = {},
				highlight = {
					enable = true,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "gnn", -- set to `false` to disable one of the mappings
						node_incremental = "grn",
						scope_incremental = "grc",
						node_decremental = "grm",
					},
				},
				indent = {
					enable = true,
				},
				autotag = {
					enable = true,
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = { query = "@function.outer", desc = "Around function" },
							["if"] = { query = "@function.inner", desc = "Inside function" },
							["aC"] = { query = "@class.outer", desc = "Around class" },
							["iC"] = { query = "@class.inner", desc = "Inside class" },
							["ic"] = { query = "@comment.inner", desc = "Inside comment" },
							["ac"] = { query = "@comment.outer", desc = "Around comment" },
							["l="] = { query = "@assignment.lhs", desc = "Left-hand side of assignment" },
							["r="] = { query = "@assignment.rhs", desc = "Right-hand side of assignment" },
							["i="] = { query = "@assignment.inner", desc = "Inside of assignment" },
							["a="] = { query = "@assignment.outer", desc = "Outside of assignment" },
							["aa"] = { query = "@parameter.outer", desc = "Outer part of parameter" },
							["ia"] = { query = "@parameter.inner", desc = "Inner part of parameter" },
							["ai"] = { query = "@conditional.outer", desc = "Outer part of conditional" },
							["ii"] = { query = "@conditional.inner", desc = "Inner part of conditional" },
							["al"] = { query = "@loop.outer", desc = "Outer part of loop" },
							["il"] = { query = "@loop.inner", desc = "Inner part of loop" },
						},
						selection_modes = {
							["@class.outer"] = "<c-v>",
							["@class.inner"] = "<c-v>",
						},
						include_surrounding_whitespace = false,
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>na"] = "@parameter.inner",
						},
						swap_previous = {
							["<leader>pa"] = "@parameter.inner",
						},
					},
				},
			}

			vim.treesitter.language.register("c_sharp", "mono-cs")
			vim.treesitter.language.register("latex", "tex")
		end,
	},
}
